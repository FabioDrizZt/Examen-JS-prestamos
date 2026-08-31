# 💰 Examen: Calculadora de Préstamos con JavaScript

## 📋 Objetivo del Examen

En este examen práctico deberás desarrollar una **aplicación web interactiva para la simulación y cálculo de préstamos y cuotas financieras**, conectando una interfaz frontend desarrollada con **HTML, CSS y JavaScript Vanilla** a un **servidor backend local en Node.js/Express**.

La aplicación debe permitir:

1. Consultar los plazos en cuotas y las tasas nominales anuales (TNA) disponibles desde el servidor backend local.
2. Renderizar dinámicamente las opciones en los selectores de plazos y tasas del formulario.
3. Calcular la cuota mensual estimada y el importe total a devolver en base al monto solicitado, plazo y tasa de interés.
4. Persistir las simulaciones realizadas en el navegador mediante `localStorage`.
5. Visualizar el historial de préstamos calculados y permitir su limpieza interactiva.

---

## 📌 Tabla de Entregas / Issues de GitHub

Cada entrega se corresponde con un **issue automático** en tu repositorio de GitHub. Para cerrar cada issue automáticamente, incluye el commit sugerido exacto al subir tu solución a la rama principal (`main`).

| Entrega | Tarea a Realizar                                                                                                      | Commit Sugerido                                                          |
| :------ | :-------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------- |
| **#1**  | Vincular `css/styles.css` y `js/script.js` en `index.html`.                                                           | `feat(html): vincular css y script js al html`                           |
| **#2**  | Consumir la API local (`/api/plazos` y `/api/tasas`) usando `fetch` y `async/await`.                                  | `feat(js): consumir api de plazos y tasas con fetch y async await`       |
| **#3**  | Renderizar dinámicamente las opciones de plazos y tasas en el DOM.                                                    | `feat(js): renderizar opciones de plazos y tasas en el dom`              |
| **#4**  | Implementar el cálculo de la cuota mensual y monto total al procesar el formulario.                                   | `feat(js): implementar calculo de cuotas y total de prestamo`            |
| **#5**  | Persistir las simulaciones en `localStorage`, mostrar el historial y permitir su limpieza con `#btnLimpiarHistorial`. | `feat(js): persistir y gestionar historial de prestamos en localstorage` |

---

## 🛠️ Especificación Técnica y Requerimientos

### 1. Servidor Backend Local

El servidor Express provisto corre en el puerto `3000` con CORS habilitado:

- **`GET http://localhost:3000/api/financiera`**: Devuelve el catálogo completo con plazos y tasas.
- **`GET http://localhost:3000/api/plazos`**: Devuelve el arreglo de plazos en meses.
- **`GET http://localhost:3000/api/tasas`**: Devuelve las líneas de crédito con su TNA.

Para iniciar el servidor backend:

```bash
npm start
```

### 2. Fórmula de Cálculo Financiero

1. **Interés Total**: $\text{Monto} \times \text{TNA} \times (\text{Meses} / 12)$.
2. **Total a Pagar**: $\text{Monto} + \text{Interés Total}$.
3. **Cuota Mensual Estimada**: $\text{Total a Pagar} / \text{Meses}$.

### 3. Elementos Clave del DOM

- **`#monto`**: Input numérico del monto solicitado.
- **`#plazo`**: `<select>` donde se cargan las opciones de cuotas.
- **`#tasa`**: `<select>` donde se cargan las líneas de crédito y TNA.
- **`#formPrestamo`** y **`#btnCalcular`**: Formulario y botón de envío.
- **`#cuotaMensual`** y **`#totalPagar`**: Spans donde se muestran los valores calculados.
- **`#historialLista`**: Lista `<ul>` donde se registran las simulaciones guardadas.
- **`#btnLimpiarHistorial`**: Botón para vaciar el historial en `localStorage`.

### 4. Almacenamiento Local (`localStorage`)

- **Clave obligatoria**: `'prestamos_historial'`
- **Estructura**: Arreglo de objetos con `{ monto, meses, lineaCredito, cuotaMensual, total, fecha }`.
- Utilizar `JSON.stringify()` para guardar y `JSON.parse()` para leer.

---

## 🧪 Comandos de Prueba y Autoevaluación

Antes de entregar, podés autoevaluar tu trabajo localmente:

```bash
# Ejecutar todas las pruebas automáticas
npm test

# Ejecutar una prueba individual
npm run test:link
npm run test:fetch
npm run test:render
npm run test:events
npm run test:storage

# Validar estilo y calidad de código
npm run lint
npm run format:check
```

---

## 🚀 Instrucciones para la Ejecución Local

1. Instalar dependencias:
   ```bash
   npm install
   ```
2. Iniciar el servidor local:
   ```bash
   npm start
   ```
3. Abrir `index.html` en el navegador (usando la extensión **Live Server** de VS Code).
4. Abrir la consola de herramientas de desarrollador (**F12**) para verificar peticiones de red y depurar posibles errores.
