#!/usr/bin/env bash
# Verificaciones automáticas — Examen JS Prestamos.
set -u

HTML="index.html"
JS="js/script.js"
CSS="css/styles.css"

fail() {
  echo "$1" >&2
  exit 1
}

ok() {
  echo CORRECTO
}

clean_js() {
  grep -v '^\s*//' "$JS"
}

case "${1:-}" in
  link-css-js)
    [[ -f "$HTML" ]] || fail "No se encontró index.html en la raíz del proyecto."
    [[ -f "$CSS" ]]  || fail "No se encontró el archivo css/styles.css."
    [[ -f "$JS" ]]   || fail "No se encontró el archivo js/script.js."
    grep -qiE '<link[^>]*href=["'"'"'].*css/styles\.css["'"'"']' "$HTML" \
      || fail "Falta vincular el archivo css/styles.css con una etiqueta <link> en el <head> de index.html."
    grep -qiE '<script[^>]*src=["'"'"'].*js/script\.js["'"'"']' "$HTML" \
      || fail "Falta vincular el archivo js/script.js con una etiqueta <script> en index.html."
    ok
    ;;
  fetch-api)
    [[ -f "$JS" ]] || fail "No se encontró el archivo js/script.js."
    js_code="$(clean_js)"
    if echo "$js_code" | grep -qiE 'fetch\s*\('; then
      :
    elif echo "$js_code" | grep -qiE 'async.*await'; then
      :
    else
      fail "No se encontró la llamada a la API usando fetch() o async/await en js/script.js."
    fi
    echo "$js_code" | grep -qiE '(/api/plazos|/api/tasas|/api/financiera|localhost:3000)' \
      || fail "No se encontró la consulta a las rutas del backend (/api/plazos, /api/tasas o /api/financiera) en js/script.js."
    ok
    ;;
  render-dom)
    [[ -f "$JS" ]] || fail "No se encontró el archivo js/script.js."
    js_code="$(clean_js)"
    echo "$js_code" | grep -qiE '(plazo|tasa|cuotaMensual|totalPagar|monto)' \
      || fail "No se encontró la selección de los elementos del DOM (plazo, tasa, cuotaMensual, etc.)."
    if echo "$js_code" | grep -qiE '(innerHTML|appendChild|createElement|textContent|insertAdjacentHTML)'; then
      :
    else
      fail "No se encontró manipulación del DOM para renderizar las opciones de plazo, tasas o resultados."
    fi
    ok
    ;;
  events-logic)
    [[ -f "$JS" ]] || fail "No se encontró el archivo js/script.js."
    js_code="$(clean_js)"
    echo "$js_code" | grep -qiE 'addEventListener\s*\(\s*["'"'"'](submit|change|input|click)["'"'"']' \
      || fail "No se encontró la escucha de eventos (submit, change o click) en js/script.js."
    echo "$js_code" | grep -qiE '(cuota|interes|monto|total|tna)' \
      || fail "No se encontró la lógica de cálculo de la cuota mensual o monto total amortizado."
    ok
    ;;
  storage-history)
    [[ -f "$JS" ]] || fail "No se encontró el archivo js/script.js."
    js_code="$(clean_js)"
    echo "$js_code" | grep -qiE 'localStorage\s*\.\s*setItem\s*\(' \
      || fail "No se encontró el uso de localStorage.setItem() para persistir las simulaciones."
    echo "$js_code" | grep -qiE 'localStorage\s*\.\s*getItem\s*\(' \
      || fail "No se encontró el uso de localStorage.getItem() para recuperar las simulaciones."
    echo "$js_code" | grep -qiE 'JSON\s*\.\s*(stringify|parse)' \
      || fail "No se encontró el uso de JSON.stringify() o JSON.parse() para el almacenamiento."
    echo "$js_code" | grep -qiE '(removeItem|clear)' \
      || fail "No se encontró la lógica para limpiar el historial con removeItem() o clear()."
    ok
    ;;
  all)
    bash "$0" link-css-js >/dev/null || fail "Falló la prueba link-css-js"
    bash "$0" fetch-api >/dev/null || fail "Falló la prueba fetch-api"
    bash "$0" render-dom >/dev/null || fail "Falló la prueba render-dom"
    bash "$0" events-logic >/dev/null || fail "Falló la prueba events-logic"
    bash "$0" storage-history >/dev/null || fail "Falló la prueba storage-history"
    ok
    ;;
  *)
    echo "Prueba automática no reconocida. Avisale al docente." >&2
    exit 2
    ;;
esac
