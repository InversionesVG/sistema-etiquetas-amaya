# 🏷️ Sistema de Generación de Etiquetas FDA - Amaya Express

Sistema profesional para generar etiquetas nutricionales FDA en formatos Avery 8164, Lácteo Avery 8164 y PLS 504.

![Python](https://img.shields.io/badge/python-3.8+-blue.svg)
![PyQt5](https://img.shields.io/badge/PyQt5-5.15-green.svg)
![License](https://img.shields.io/badge/license-Privado-red.svg)

## 📋 Descripción

Aplicación de escritorio con interfaz gráfica (GUI) que permite:
- ✅ Seleccionar productos desde base de datos Excel
- ✅ Elegir cantidades y tipo de etiqueta
- ✅ Generar PDFs listos para imprimir
- ✅ Soporta 3 tipos de etiquetas (Avery 8164, Lácteo, PLS 504)
- ✅ Compatible con Windows y Mac

## 🎯 Tipos de Etiquetas Soportados

### 1. **Avery 8164** (Normal - Vertical)
- Tamaño: 3.33" × 4"
- 6 etiquetas por hoja (2 columnas × 3 filas)
- Diseño estándar FDA con Nutrition Facts completo

### 2. **Lacteo Avery 8164** (Horizontal con fondos decorativos)
- Tamaño: 4" × 3.33" (rotada 90°)
- 6 etiquetas por hoja (2 columnas × 3 filas)
- Fondos decorativos amarillo y azul
- Nutrition Facts compacto (solo hasta Protein)

### 3. **PLS 504** (Pequeña)
- Tamaño: 3" × 2"
- 10 etiquetas por hoja (2 columnas × 5 filas)
- Diseño compacto

## 🚀 Instalación

### **Requisitos Previos**
- Python 3.8 o superior
- pip (gestor de paquetes de Python)

### **Windows**

1. **Instalar Python** (si no lo tienes):
   - Descarga desde: https://www.python.org/downloads/
   - ⚠️ **IMPORTANTE:** Marca "Add Python to PATH" durante instalación

2. **Clonar repositorio:**
   ```cmd
   git clone https://github.com/TU_USUARIO/sistema-etiquetas-amaya.git
   cd sistema-etiquetas-amaya
   ```

3. **Instalar dependencias:**
   ```cmd
   pip install -r requirements.txt
   ```

4. **Configurar archivos:**
   - Copia tus archivos a `C:\Sistema_Etiquetas\`:
     - `Base_Datos_Etiquetas_FDA.xlsx` (tu base de datos)
     - `Amaya_Imagen.png` (logo)
     - `Fondo_Superior.png` (fondo amarillo)
     - `Fondo_Inferior.png` (fondo azul)

5. **Ejecutar:**
   ```cmd
   python generador_etiquetas_gui.py
   ```

### **Mac**

1. **Clonar repositorio:**
   ```bash
   git clone https://github.com/TU_USUARIO/sistema-etiquetas-amaya.git
   cd sistema-etiquetas-amaya
   ```

2. **Instalar dependencias:**
   ```bash
   pip3 install -r requirements.txt
   ```

3. **Configurar archivos:**
   - Copia tus archivos a `~/Sistema_Etiquetas/`:
     ```bash
     mkdir -p ~/Sistema_Etiquetas
     cp Base_Datos_Etiquetas_FDA.xlsx ~/Sistema_Etiquetas/
     cp Amaya_Imagen.png ~/Sistema_Etiquetas/
     cp Fondo_Superior.png ~/Sistema_Etiquetas/
     cp Fondo_Inferior.png ~/Sistema_Etiquetas/
     ```

4. **Ejecutar:**
   ```bash
   python3 generador_etiquetas_gui.py
   ```

## 📁 Estructura del Proyecto

```
sistema-etiquetas-amaya/
├── generador_etiquetas_gui.py    # Aplicación principal con interfaz gráfica
├── requirements.txt               # Dependencias de Python
├── README.md                      # Este archivo
├── .gitignore                     # Archivos ignorados por Git
└── recursos/                      # (opcional) Capturas de pantalla
```

### **Archivos Necesarios (NO incluidos en Git por seguridad):**

Debes tener estos archivos en tu carpeta de trabajo:

**Windows:** `C:\Sistema_Etiquetas\`  
**Mac:** `~/Sistema_Etiquetas/`

- `Base_Datos_Etiquetas_FDA.xlsx` - Base de datos de productos
- `Amaya_Imagen.png` - Logo corporativo
- `Fondo_Superior.png` - Fondo amarillo con vacas (sin texto)
- `Fondo_Inferior.png` - Fondo azul degradado

## 🎨 Estructura del Excel

El archivo `Base_Datos_Etiquetas_FDA.xlsx` debe tener una hoja llamada **"Productos_FDA"** con las siguientes columnas:

### **Columnas Obligatorias:**

| Columna | Descripción | Ejemplo |
|---------|-------------|---------|
| `Product_Name` | Nombre en español | "CREMA SALVADOREÑA" |
| `Product_Name_English` | Nombre en inglés | "Soft Blend Dairy Spread" |
| `Net_Weight` | Peso neto | "16oz (453g)" |
| `Serving_Size` | Tamaño de porción | "2 Tbsp (30g)" |
| `Servings_Per_Container` | Porciones por envase | "15" |
| `Calories` | Calorías | "60" |
| `Total_Fat` | Grasa total | "5g" |
| `Saturated_Fat` | Grasa saturada | "3g" |
| `Trans_Fat` | Grasa trans | "0g" |
| `Cholesterol` | Colesterol | "15mg" |
| `Sodium` | Sodio | "85mg" |
| `Total_Carbohydrate` | Carbohidratos totales | "2g" |
| `Dietary_Fiber` | Fibra dietética | "0g" |
| `Total_Sugars` | Azúcares totales | "2g" |
| `Added_Sugars` | Azúcares añadidos | "0g" |
| `Protein` | Proteína | "1g" |
| `Ingredients` | Lista de ingredientes | "Water, Hydrogenated..." |
| `Allergens` | Alérgenos | "CONTAINS: MILK PROTEINS." |
| `Expiration_Date` | Fecha de vencimiento | "04/15/2026" |
| `Imported_By` | Importado por | "Nombre, Dirección, Ciudad ZIP" |

### **Columnas Opcionales (Micronutrientes):**
- `Vitamin_D`, `Calcium`, `Iron`, `Potassium`

## 💻 Uso de la Aplicación

### **Flujo de Trabajo:**

1. **Abrir la aplicación:**
   - Windows: Doble clic en `generador_etiquetas_gui.py` o ejecutar desde CMD
   - Mac: `python3 generador_etiquetas_gui.py` en Terminal

2. **Seleccionar tipo de etiqueta:**
   - Elegir entre: Avery 8164, Lacteo Avery 8164, o PLS 504
   - ⚠️ **OBLIGATORIO** antes de generar PDF

3. **Buscar productos (opcional):**
   - Usar el campo de búsqueda para filtrar por nombre

4. **Seleccionar productos:**
   - Marcar checkbox de los productos deseados
   - Definir cantidad de etiquetas para cada uno
   - Botones "Seleccionar Todo" / "Deseleccionar Todo"

5. **Ver resumen:**
   - Productos seleccionados
   - Total de etiquetas
   - Hojas a imprimir

6. **Generar PDF:**
   - Clic en "GENERAR PDF"
   - PDF se abre automáticamente
   - Archivo guardado con timestamp: `Etiquetas_YYYYMMDD_HHMMSS.pdf`

## 🔧 Solución de Problemas

### **Error: "No se encontró el archivo Excel"**
- Verifica que `Base_Datos_Etiquetas_FDA.xlsx` esté en la carpeta correcta
- Windows: `C:\Sistema_Etiquetas\`
- Mac: `~/Sistema_Etiquetas/`

### **Error: "No module named 'PyQt5'"**
```bash
pip install PyQt5
# o en Mac:
pip3 install PyQt5
```

### **El PDF no se abre automáticamente**
- Busca el archivo en la carpeta `Sistema_Etiquetas`
- Nombre: `Etiquetas_YYYYMMDD_HHMMSS.pdf`

### **Las imágenes no aparecen en el PDF**
- Verifica que los archivos PNG estén en la carpeta correcta:
  - `Amaya_Imagen.png`
  - `Fondo_Superior.png`
  - `Fondo_Inferior.png`

## 📚 Tecnologías Utilizadas

- **Python 3.8+** - Lenguaje de programación
- **PyQt5** - Interfaz gráfica de usuario
- **ReportLab** - Generación de PDFs
- **OpenPyXL** - Lectura de archivos Excel
- **Pillow** - Procesamiento de imágenes

## 📝 Notas Importantes

### **Para Desarrolladores:**
- El código detecta automáticamente Windows/Mac y ajusta rutas
- `BASE_DIR` se crea automáticamente si no existe
- Los PDFs se generan con timestamp para evitar sobrescritura

### **Para Usuarios Finales:**
- La carpeta `Sistema_Etiquetas` se crea automáticamente
- PDFs generados quedan guardados en esa carpeta
- No es necesario tener conocimientos técnicos para usar la aplicación

## 🔐 Seguridad

⚠️ **IMPORTANTE:** 
- El archivo `Base_Datos_Etiquetas_FDA.xlsx` NO está incluido en Git por seguridad
- Contiene datos sensibles del negocio (productos, precios, ingredientes)
- Cada usuario debe mantener su propia copia local

## 📄 Licencia

**Privado** - Uso exclusivo de Amaya Express International

## 👨‍💻 Autor

**Sistema desarrollado para Amaya Express**  
📧 amayaexpress21@hotmail.com  
📞 (908) 405-5553

---

## 🚀 Próximas Mejoras

- [ ] Crear ejecutable (.exe) para Windows
- [ ] Agregar plantillas predefinidas
- [ ] Exportar a otros formatos
- [ ] Historial de etiquetas generadas

---

**Versión:** 1.0  
**Última actualización:** Abril 2026
