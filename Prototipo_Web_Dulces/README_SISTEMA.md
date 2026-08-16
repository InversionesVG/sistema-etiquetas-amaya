# SISTEMA DE ETIQUETAS FDA - AMAYA EXPRESS
## Documento maestro (v3.0 — listo para Cowork)

**Ubicación del proyecto:** `~/Documents/Python/Amaya_Labels`
**Nombre de carpeta/proyecto:** Amaya_Labels
**Estado:** Funcional. Imprime correctamente. Listo para nuevas features.

---

## 📁 ARCHIVOS EN ESTA CARPETA

| Archivo | Función |
|---|---|
| `Base_Datos_Etiquetas_FDA.xlsx` | **(agrégalo tú)** Excel maestro de productos |
| `Selector_Etiquetas.html` | Interfaz web para elegir productos/tipo etiqueta |
| `generador_etiquetas.py` | Servidor local + genera Excel temporal |
| `generar_pdf_etiquetas.py` | Genera el PDF final |
| `Amaya_Imagen.png` | Logo |
| `Fondo_Superior.png` | Fondo lácteo (amarillo+vacas, sin texto grande) |
| `Fondo_Inferior.png` | Fondo lácteo (azul) |

`Base_Datos_Etiquetas_FDA.xlsx` ya está en la carpeta (resuelto - antes solo existía `Base_Datos_Etiquetas_FDAOLD.xlsx`, un respaldo viejo que no se usa).

---

## 🚀 CÓMO CORRER

```bash
cd ~/Documents/Python/Amaya_Labels
python3 generador_etiquetas.py
# → http://localhost:8000, elegir tipo, generar Excel
python3 generar_pdf_etiquetas.py
```

---

## 🏷️ TIPOS DE ETIQUETA

| Tipo (Label_Type) | Papel | Por hoja | Orientación |
|---|---|---|---|
| `AVERY_8164` | Avery 8164 | 6 | Vertical 3.33"×4" |
| `LACTEO_AVERY_8164` | Avery 8164 (mismo papel) | 6 | Horizontal 4"×3.33" (girada), fondos decorativos |
| `PLS504` | PLS504 | 10 | 3"×2" |
| `AVERY_5260` | Avery 5260 | 30 (3 col × 10 fila) | 1"×2⅝", nombre visible en el combo box: **"Dulces"** |

---

## ✅ PROBLEMAS RESUELTOS (no reabrir)

- **PDF no imprimía (jalaba hoja, no imprimía la 2da vez):** resuelto quitando `mask='auto'` de `drawImage` en todas las imágenes, y forzando `invariant=0` + metadata única (`setAuthor`/`setTitle` con timestamp) en `generar_pdf()` para evitar caché de la impresora. **No revertir estos dos cambios.**
- Duplicado de "Salvadoreña": se debía a texto quemado en el PNG viejo. `Fondo_Superior.png` actual YA está limpio (sin texto grande).
- Nutrition Facts en LACTEO: se corta si se agregan micronutrientes/leyenda — **se decidió cortar después de Protein a propósito** (limitación de espacio, 1.05" de ancho).

---

## ⚠️ AJUSTES DE LAYOUT PENDIENTES (LACTEO_AVERY_8164)

Últimos comentarios del usuario sin confirmar si quedaron bien:
1. Fila 1: "KEEP REFRIGERATED" se bajó 8pt; verificar que no choque con Product_Name (20pt).
2. Fila 2: verificar que teléfono/correo/tel. inferior no se corten.
3. Fila 3: verificar que no quede muy abajo respecto al margen de la etiqueta.

Config actual en `LABEL_CONFIGS['LACTEO_AVERY_8164']`:
```python
'margin_left': 0.16 * inch,
'margin_top': 0.48 * inch,
'h_spacing': 0.18 * inch,
'v_spacing': 0.05 * inch,
```
Si hay que mover filas: ajustar `v_spacing` (y no tocar `mask`/`invariant`).

---

## 🎨 DISEÑO LACTEO_AVERY_8164 (referencia rápida)

División 60% amarillo (arriba) / 40% azul (abajo).
- Amarillo: KEEP REFRIGERATED (8pt, esq. der.) → Product_Name (20pt, centrado) → Product_Name_English (13pt, centrado, cursiva) → vacas (ya en el PNG).
- Azul, de arriba a abajo: INGREDIENTS (6pt) → texto ingredientes (5pt) → CONTAINS: MILK PROTEINS (6pt) → EXP (6pt) → Logo (0.35") + cuadro peso azul #003366 + Distributed/Imported by (4.5-5pt) → teléfonos/correo (4.5pt) abajo.
- Derecha, todo el alto de la sección azul: Nutrition Facts (fondo blanco, ancho 1.05", corta después de Protein).

Textos fijos (NO vienen del Excel): "KEEP REFRIGERATED", "CONTAINS: MILK PROTEINS.", "Distributed by: Amaya Express International / 472 Somerset St. / North Plainfield, NJ 06070", "(908) 405-5553", "amayaexpress21@hotmail.com", "(908) 405-3072".

---

## 🍬 DISEÑO AVERY_5260 / "Dulces" (referencia rápida)

Etiqueta de identificación + Nutrition Facts compacta, 1" alto × 2⅝" ancho. Se agregó en agosto 2026, empezando con el producto Coco Rallado. **No confundir con LACTEO_AVERY_8164** - es un diseño aparte, sin fondos ni logo.

- Esta etiqueta **NO tiene que cumplir la restricción de tamaño mínimo de fuente de la FDA** (21 CFR 101.9 exige 14pt mínimo en el panel de Nutrition Facts) porque no se usa para ese fin. Por eso el texto va en 3.6-6.5pt.
- Layout: columna izquierda (nombre, `INGREDIENTS`, `Distributed by` fijo + `Imported_By` del Excel, `Net Wt`/`EXP`, teléfonos/correo) + columna derecha con Nutrition Facts, separadas por 2 líneas verticales delgadas (0.4pt) + 1 línea horizontal arriba cerrando el cuadro. Ninguna línea llega al borde físico de la etiqueta (para que no se corte al imprimir/recortar).
- **Nutrientes en 0 se omiten** (función `es_cero()`): si el valor empieza en "0" (ej. `"0g"`, `"0mg"`) no se muestra esa fila; si empieza con un número distinto de cero (ej. `"<1g"`) sí se muestra. Celdas vacías/`None` también se omiten.
- Las filas de nutrientes que sí quedan se reparten para ocupar todo el alto de la columna de Nutrition Facts (de borde a borde de la etiqueta), reduciendo el tamaño de letra automáticamente (mínimo 2.6pt) solo si hay demasiados nutrientes para que quepan a 3.6pt.
- La **columna izquierda sí va centrada verticalmente** dentro de la etiqueta (se mide el bloque de texto antes de dibujarlo y se reparte el margen arriba/abajo) - esto se pidió explícitamente porque el texto se cortaba al despegar la etiqueta cuando iba pegado al borde superior. La columna de Nutrition Facts se probó centrada igual, pero **se descartó** porque obligaba a achicar más la letra; se dejó a todo el alto como estaba.
- `Expiration_Date` se formatea como `MM/AAAA` (función `formatear_exp()`) para que no salga con la hora pegada (Excel guarda esas celdas como fecha completa).

---

## 📊 EXCEL — Columnas esperadas

Product_Name, Product_Name_English, Serving_Size, Servings_Per_Container, Calories, Total_Fat, Saturated_Fat, Trans_Fat, Cholesterol, Sodium, Total_Carbohydrate, Dietary_Fiber, Total_Sugars, Added_Sugars, Protein, Vitamin_D, Calcium, Iron, Potassium, Ingredients, Allergens, Net_Weight, Expiration_Date, Imported_By, Cantidad_a_Imprimir.

`Imported_By` formato: `Nombre, Dirección, Ciudad ZIP` (se divide por comas en 3 líneas).
`Net_Weight` formato recomendado: `16oz (453g)` (el código separa oz de gramos si detecta "oz").

---

## 🖥️ ENTORNO

Mac (desarrollo) + Windows (producción, según preferencia previa del usuario).
```bash
pip3 install openpyxl reportlab pillow --break-system-packages
```

---

## 🧭 CÓMO ACTIVAR COWORK PARA ESTA CARPETA

1. Abre Claude Desktop → pestaña **Cowork**.
2. "Nuevo proyecto/carpeta" → selecciona `~/Documents/Python/Amaya_Labels`.
3. Sube este README a esa carpeta si no quedó ya dentro (debe quedar junto a los .py/.html/.png).
4. Empieza el próximo chat DENTRO de ese proyecto — así Claude ve todos los archivos sin que tengas que resubirlos.

*(Si tu versión de Claude usa "Projects" en vez de "Cowork": Settings → Projects → Add → apuntar a la carpeta. Es el mismo concepto: darle contexto persistente de archivos.)*

---

## 🆕 PARA EL PRÓXIMO CHAT

Pega esto como primer mensaje:
> "Este es mi Sistema de Etiquetas FDA (Amaya Express), ya funcional e imprimiendo bien. Está documentado en README_SISTEMA.md dentro de esta carpeta. Quiero agregar nuevas funciones: [dime cuáles]. No toques la lógica de impresión (mask/invariant) que ya está resuelta."
