# CHANGELOG - Sistema de Etiquetas Amaya Express

Todos los cambios importantes del proyecto se documentan en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Versionamiento Semántico](https://semver.org/lang/es/).

---

## [1.0.0] - 2026-04-05

### 🎉 Versión Inicial - Lanzamiento

#### Agregado
- ✅ Interfaz gráfica completa con PyQt5
- ✅ Soporte para 3 tipos de etiquetas:
  - Avery 8164 (vertical 3.33" × 4")
  - Lacteo Avery 8164 (horizontal 4" × 3.33")
  - PLS 504 (pequeña 3" × 2")
- ✅ Logo de Amaya en header
- ✅ Buscador de productos en tiempo real
- ✅ Validación de tipo de etiqueta obligatorio
- ✅ Selector de cantidades por producto
- ✅ Resumen en tiempo real (productos, etiquetas, hojas)
- ✅ Generación de PDF con ReportLab
- ✅ Apertura automática de PDF
- ✅ PDFs en carpeta temporal (no se acumulan)
- ✅ Ventana maximizada al inicio
- ✅ Detección automática de sistema operativo (Windows/Mac)
- ✅ Control de versiones visible en interfaz
- ✅ Ejecutable .exe para Windows

#### Características Etiqueta Láctea
- Fondos decorativos amarillo (60%) y azul (40%)
- Product_Name grande (20pt)
- Product_Name_English cursiva (13pt)
- "KEEP REFRIGERATED" en esquina superior derecha
- Ingredients en sección azul
- Logo Amaya + cuadro de peso azul oscuro
- Distributed by / Imported by
- Nutrition Facts compacto (solo hasta Protein)
- Información de contacto en footer

#### Corregido
- 🐛 Bug del buscador que cerraba el programa
- 🐛 Ventana no se maximizaba correctamente
- 🐛 Mensaje molesto de "productos cargados"

---

## Formato de Versiones

### [X.Y.Z] - YYYY-MM-DD

**X (MAYOR):** Cambios incompatibles o rediseño completo
- Ejemplo: Cambiar de PyQt5 a otra tecnología
- Ejemplo: Rediseño completo de la interfaz

**Y (MENOR):** Nuevas funcionalidades compatibles
- Ejemplo: Agregar nuevo tipo de etiqueta
- Ejemplo: Agregar exportación a Excel
- Ejemplo: Agregar historial de impresiones

**Z (PARCHE):** Correcciones de bugs
- Ejemplo: Arreglar buscador
- Ejemplo: Corregir error en PDF
- Ejemplo: Ajustar márgenes

---

## Plantilla para futuras versiones

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Agregado
- Nueva funcionalidad 1
- Nueva funcionalidad 2

### Cambiado
- Mejora en funcionalidad existente
- Optimización de rendimiento

### Corregido
- 🐛 Bug específico arreglado
- 🐛 Otro bug arreglado

### Eliminado
- Funcionalidad obsoleta removida
```

---

## Instrucciones para actualizar versión

### 1. Modificar código
Edita `generador_etiquetas_gui.py`:

```python
# Líneas 21-22
VERSION = "1.0.1"  # ← Cambiar aquí
VERSION_DATE = "Abril 2026"
```

### 2. Documentar en CHANGELOG
Agrega entrada en este archivo arriba de la versión 1.0.0.

### 3. Commit en Git
```bash
git add generador_etiquetas_gui.py CHANGELOG.md
git commit -m "Bump version to 1.0.1 - Descripción del cambio"
git tag -a v1.0.1 -m "Versión 1.0.1"
git push origin main --tags
```

### 4. Generar nuevo .exe
```cmd
cd C:\Sistema_Etiquetas\Win
pyinstaller --onefile --windowed --name="Generador_Etiquetas_Amaya" generador_etiquetas_gui.py
copy dist\Generador_Etiquetas_Amaya.exe C:\Sistema_Etiquetas\
```

### 5. Probar
- Verificar que muestra la versión correcta en el título y header
- Probar todas las funcionalidades
- Confirmar que el cambio funciona

---

## Historial de Tags Git

```bash
# Ver todas las versiones
git tag

# Ver detalles de una versión
git show v1.0.0

# Volver a una versión anterior
git checkout v1.0.0
```

---

**Última actualización:** 2026-04-05  
**Versión actual:** 1.0.0
