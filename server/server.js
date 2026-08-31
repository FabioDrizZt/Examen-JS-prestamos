const express = require('express');
const cors = require('cors');
const path = require('path');
const financieraData = require('./data/financiera.json');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Ruta base
app.get('/', (req, res) => {
  res.send('Servidor de Préstamos corriendo. Datos en /api/financiera');
});

// Obtener catálogo financiero completo
app.get('/api/financiera', (req, res) => {
  res.json(financieraData);
});

// Obtener plazos
app.get('/api/plazos', (req, res) => {
  res.json(financieraData.plazos);
});

// Obtener tasas
app.get('/api/tasas', (req, res) => {
  res.json(financieraData.tasas);
});

app.use('/data', express.static(path.join(__dirname, 'data')));

app.listen(PORT, () => {
  console.log(`Servidor de Préstamos escuchando en http://localhost:${PORT}`);
  console.log(`API Financiera: http://localhost:${PORT}/api/financiera`);
});
