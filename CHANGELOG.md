# CHANGELOG - Sistema de Etiquetas Amaya Express

Todos los cambios importantes del proyecto se documentan en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Versionamiento Semántico](https://semver.org/lang/es/).

---

## [1.3.1] - 2026-08-17

### 🐛 Fix: Desfase de impresión en Dulces (Avery 5260)

#### Corregido
- 🐛 **Desfase progresivo al imprimir en Windows**, visible desde la fila 7 en adelante (30 por hoja), tan grave que en la fila 10 el título se imprimía encima de la fila 9. Causa: el visor de PDF (Edge/Chrome) tenía seleccionado "Ajustar a la página", que aplica un pequeño escalado automático; como `AVERY_5260` tiene `v_spacing: 0` (sin margen de tolerancia entre filas), ese escalado se acumulaba fila por fila hasta volverse visible.
- ✅ **Solución de fondo:** se agregó `c.setViewerPreference('PrintScaling', 'None')` al generar el PDF (`generar_pdf()`), que le indica al visor que no debe escalar nada al imprimir — equivale a dejar preseleccionado "Tamaño real / Actual Size" en vez de "Ajustar a la página", para que el operario no tenga que cambiarlo manualmente cada vez.
- ⚠️ **Pendiente de confirmar en producción:** esta preferencia es parte del estándar PDF (`ViewerPreferences`) y Adobe Reader siempre la respeta; falta confirmar que el visor integrado de Edge/Chrome en la máquina de Windows de producción también la respete. Mientras tanto, seleccionar manualmente "Tamaño real / Actual Size" en el diálogo de impresión sigue siendo la solución que ya se probó y funcionó.

#### Cambiado
- Versión actualizada a 1.3.1

---

## [1.3.0] - 2026-08-16

### 🎉 Nueva Etiqueta: Dulces (Avery 5260)

#### Agregado
- ✅ **Nuevo tipo de etiqueta:** Dulces - Avery 5260 (30 por hoja - 1" x 2-5/8")
- ✅ **3 columnas x 10 filas por hoja** (specs oficiales Avery 5260: margin_left 0.1875", margin_top 0.5", h_spacing 0.125", v_spacing 0")
- ✅ **Nutrition Facts SIN la restricción de tamaño mínimo de fuente de la FDA** (21 CFR 101.9 exige 14pt) porque esta etiqueta no se usa para ese fin - texto en 3.6-6.5pt
- ✅ **Omisión automática de nutrientes en 0** (función `es_cero()`): valores como "0g"/"0mg" no ocupan espacio; celdas vacías también se omiten
- ✅ **Nutrition Facts a todo el alto de la etiqueta**, con letra que se achica automáticamente (mínimo 2.6pt) solo si hay demasiados nutrientes para 3.6pt
- ✅ **Columna izquierda (nombre/ingredientes/distribuidor) centrada verticalmente** dentro de la etiqueta - se mide el bloque antes de dibujarlo (función `wrap_texto()` con modo medición) para que no se corte el texto al despegar la etiqueta
- ✅ **Formato de fecha de vencimiento MM/AAAA** (función `formatear_exp()`) para que no salga con la hora pegada
- ✅ **Nueva función:** `dibujar_avery5260()`
- ✅ **Nueva configuración:** `AVERY_5260` en LABEL_CONFIGS
- ✅ Probado impreso en papel real (Epson ET-2988) sobre plantilla Avery 5260 antes de integrarse aquí

#### Cambiado
- Versión actualizada a 1.3.0
- Combo box de tipo de etiqueta: nueva opción en índice 5 ("Dulces - Avery 5260")
- Cálculo de hojas actualizado para incluir Dulces (30 por hoja)
- Mensajes de validación actualizados con el nuevo tipo

#### 📁 Unificación de carpeta del proyecto (Mac)
Antes de esta versión existían dos ubicaciones separadas: el repositorio Git real (`~/Documents/Sistema_Etiquetas/Win/`, con la app de escritorio PyQt5 que se usa en producción) y una carpeta aparte (`~/Documents/Python/Amaya_Labels`) usada para prototipar "Dulces" en una sesión de Cowork con un script independiente (reportlab + HTML). Como es un solo sistema, se unificaron en una sola carpeta:

- **Nueva ubicación única del proyecto en Mac:** `~/Documents/Python/Amaya_Labels` (ahí vive el repositorio Git completo desde ahora)
- `BASE_DIR` en `generador_etiquetas_gui.py` actualizado **solo en la rama Mac** de `platform.system()`: de `~/Documents/Sistema_Etiquetas` a `~/Documents/Python/Amaya_Labels`
- **En Windows no cambió nada:** `BASE_DIR` sigue siendo `C:/Sistema_Etiquetas` (decisión explícita, para no romper la ruta de producción)
- La carpeta vieja `~/Documents/Sistema_Etiquetas` se conservó como respaldo, renombrada a `Sistema_Etiquetas_NOACTUAL` (no se borró nada)
- Los 4 archivos del prototipo web original de Dulces (`README_SISTEMA.md`, `Selector_Etiquetas.html`, `generador_etiquetas.py`, `generar_pdf_etiquetas.py`) se archivaron sin borrar en la subcarpeta `Prototipo_Web_Dulces/`, solo como referencia histórica del diseño validado — ya no se usan ni se ejecutan
- Se agregaron a Git 4 imágenes que ya se usaban en la etiqueta San Julián pero que no estaban versionadas: `Flag_El_Salvador.png`, `Fondo_Azul_San_Julian.png`, `Logo_San_Julian_Vaca.png`, `Sello_Verde_San_Julian.png`

#### Origen
- Diseñado y validado primero como prototipo (servidor web local + HTML) en una sesión de Cowork, con el producto Coco Rallado como caso de prueba, antes de migrarlo a esta aplicación de escritorio.

#### 🪟 Script de actualización automática en Windows (`actualizar_sistema.bat`)
Se agregó `actualizar_sistema.bat` en la raíz del repositorio para automatizar la actualización en la máquina de producción (Windows), en un solo doble clic:

1. `git pull` — descarga el código más reciente desde GitHub
2. `pip install -r requirements.txt` — instala/actualiza dependencias si hay alguna nueva
3. `pyinstaller --onefile --windowed` — reconstruye `Generador_Etiquetas_Amaya.exe` con el código actualizado
4. Cierra el programa si estaba abierto (`taskkill`) y reemplaza el `.exe` de producción en `C:\Sistema_Etiquetas\Generador_Etiquetas_Amaya.exe`

Si cualquier paso falla (sin internet, error de pip, error de PyInstaller, o el `.exe` no se pudo reemplazar porque el programa seguía abierto), el script se detiene ahí mismo y muestra el motivo — no continúa con pasos a medias.

**Flujo de trabajo a partir de ahora:**
- Mac: `git push` cuando se termina una función nueva
- Windows: doble clic en `actualizar_sistema.bat` → queda el código y el `.exe` actualizados

Rutas configurables al inicio del script (`REPO_DIR`, `EXE_DESTINO`) por si algún día cambia la ubicación del repo o del ejecutable de producción en Windows.

#### Observaciones Técnicas
- Código agregado sin modificar funciones de dibujo existentes (`dibujar_avery`, `dibujar_lacteo_avery`, `dibujar_lacteo_san_julian`, `dibujar_pls`) ni la lógica de impresión (`mask`/`invariant`)
- `git pull` en Windows solo actualiza el código fuente — el `.exe` de producción **no se actualiza solo**, hay que regenerarlo con PyInstaller después de cada `pull` (esto es justamente lo que automatiza `actualizar_sistema.bat`)

---

## [1.2.0] - 2026-05-07

### 🎉 Nueva Etiqueta: Lacteo San Julian

#### Agregado
- ✅ **Nuevo tipo de etiqueta:** Lacteo San Julian (6 por hoja - Vertical rotada)
- ✅ **Diseño vertical rotado 90°** para aprovechar espacio horizontal tipo Lacteo Avery
- ✅ **Fondo degradado azul** (azul claro arriba → azul oscuro abajo)
- ✅ **Logo San Julián** (vaca con queso) en centro superior
- ✅ **Sello verde "Sabor San Julián"** con franja naranja "El Original - Desde 1986"
- ✅ **Nutrition Facts COMPLETA** (no compacta) con todos los nutrientes
- ✅ **Textos superiores:** "Keep refrigerated / Pasteurizado"
- ✅ **Tres nuevas imágenes:**
  - `Logo_San_Julian_Vaca.png` - Logo de la vaca
  - `Sello_Verde_San_Julian.png` - Sello circular verde
  - `Fondo_Azul_San_Julian.png` - Degradado azul
- ✅ **Nueva función:** `dibujar_lacteo_san_julian()` (320 líneas)
- ✅ **Nueva configuración:** `LACTEO_SAN_JULIAN` en LABEL_CONFIGS

#### Cambiado
- Versión actualizada a 1.2.0
- Índice de PLS504 cambió de 3 a 4 (por nuevo tipo en medio)
- Cálculo de hojas actualizado para incluir San Julián
- Mensajes de validación actualizados con nuevo tipo

#### Detalles de Diseño San Julián
- **Sección superior:** Logo + nombre producto (español e inglés)
- **Sección inferior dividida:**
  - Izquierda (45%): Sello verde + Ingredientes + Allergens + Peso + País + Fecha vencimiento
  - Derecha (55%): Nutrition Facts completa FDA
- **NO incluye:** Datos de contacto ni bandera El Salvador
- **Fecha de vencimiento:** Solo muestra fecha (sin hora), ubicada 2 líneas debajo de "Product of El Salvador"

#### Observaciones Técnicas
- Rotación implementada con `c.saveState()` / `c.restoreState()` / `c.rotate(90)`
- Usa mismas medidas físicas que Lacteo Avery 8164 (4" × 3.33")
- Código agregado sin modificar funciones existentes

---

## [1.1.0] - 2026-04-05

### 🎉 Mejoras en PLS-504

#### Agregado
- ✅ **Ingredientes completos** en etiqueta PLS-504
- ✅ **Allergens** después de ingredientes
- ✅ **Bandera de El Salvador** debajo de "Imported by"
- ✅ **Nutrition Facts COMPLETA** con todos los nutrientes:
  - Total Fat, Saturated Fat, Trans Fat
  - Cholesterol, Sodium
  - Total Carbohydrate, Dietary Fiber, Total Sugars, Added Sugars
  - Protein
  - Vitamin D, Calcium, Iron, Potassium
  - Leyenda del asterisco
- ✅ **Texto azul** en tabla nutricional (#0066B3)
- ✅ Redistribución de espacio: 40% izquierda, 60% derecha
- ✅ Letras más grandes (3.2pt) para mejor legibilidad
- ✅ Ajuste de filas 4 y 5 independiente

#### Cambiado
- Cuadro Nutrition Facts más ajustado (sin espacio vacío inferior)
- Mayor separación vertical entre nutrientes
- Correo electrónico en una sola línea
- Labels acortados ("Fat" en vez de "Total Fat", etc.)

#### Corregido
- 🐛 Bug de variable "dv" en sección Protein
- 🐛 Allergens ahora muestra título correcto

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
**Versión actual:** 1.1.0