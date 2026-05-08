# 📦 GUÍA PARA ACTUALIZAR GIT - VERSIÓN 1.2.0

## 🎯 Objetivo
Subir todos los cambios de la versión 1.2.0 al repositorio de GitHub.

---

## 📋 ARCHIVOS QUE DEBES ACTUALIZAR

### 1. **Archivos de código (carpeta Win):**
   - ✅ `generador_etiquetas_gui.py` (actualizado a v1.2.0)
   - ✅ `README.md` (actualizado)
   - ✅ `CHANGELOG.md` (actualizado)

### 2. **Imágenes nuevas (carpeta Win):**
   - 🆕 `Logo_San_Julian_Vaca.png`
   - 🆕 `Sello_Verde_San_Julian.png`
   - 🆕 `Fondo_Azul_San_Julian.png`

---

## 🚀 PASOS PARA ACTUALIZAR GIT

### **Opción A: Desde Mac (Terminal)**

#### 1. Abrir Terminal y navegar a la carpeta del proyecto
```bash
cd ~/Documents/Sistema_Etiquetas/Win
```

#### 2. Verificar que estás en el repositorio correcto
```bash
pwd
# Debe mostrar: /Users/TU_USUARIO/Documents/Sistema_Etiquetas/Win

git status
# Debe mostrar los archivos modificados
```

#### 3. Copiar las imágenes nuevas a la carpeta Win
```bash
# Si las imágenes están en otra ubicación, cópialas:
cp ~/ruta/donde/descargaste/Logo_San_Julian_Vaca.png .
cp ~/ruta/donde/descargaste/Sello_Verde_San_Julian.png .
cp ~/ruta/donde/descargaste/Fondo_Azul_San_Julian.png .
```

#### 4. Ver qué archivos han cambiado
```bash
git status
```

Deberías ver algo como:
```
Modified:
    generador_etiquetas_gui.py
    README.md
    CHANGELOG.md
    
Untracked files:
    Logo_San_Julian_Vaca.png
    Sello_Verde_San_Julian.png
    Fondo_Azul_San_Julian.png
```

#### 5. Agregar todos los cambios al staging
```bash
# Opción 1: Agregar todos los archivos modificados
git add .

# Opción 2: Agregar archivos específicos
git add generador_etiquetas_gui.py
git add README.md
git add CHANGELOG.md
git add Logo_San_Julian_Vaca.png
git add Sello_Verde_San_Julian.png
git add Fondo_Azul_San_Julian.png
```

#### 6. Verificar que los archivos están listos para commit
```bash
git status
```

Deberías ver:
```
Changes to be committed:
    modified:   generador_etiquetas_gui.py
    modified:   README.md
    modified:   CHANGELOG.md
    new file:   Logo_San_Julian_Vaca.png
    new file:   Sello_Verde_San_Julian.png
    new file:   Fondo_Azul_San_Julian.png
```

#### 7. Hacer commit con mensaje descriptivo
```bash
git commit -m "Release v1.2.0 - Agregar etiqueta Lacteo San Julian

- Nueva etiqueta: Lacteo San Julian (vertical rotada)
- Función dibujar_lacteo_san_julian() con 320 líneas
- Fondo degradado azul personalizado
- Logo y sello San Julián
- Nutrition Facts completa
- Fecha de vencimiento sin hora
- Actualización README y CHANGELOG"
```

#### 8. Crear tag para la versión
```bash
git tag -a v1.2.0 -m "Versión 1.2.0 - Etiqueta San Julián"
```

#### 9. Subir cambios a GitHub
```bash
# Subir commits
git push origin main

# Subir tags
git push origin --tags
```

#### 10. Verificar en GitHub
Abre tu navegador y ve a:
```
https://github.com/InversionesVG/sistema-etiquetas-amaya
```

Deberías ver:
- ✅ Los archivos actualizados
- ✅ El tag v1.2.0 en "Releases"
- ✅ Las 3 imágenes nuevas

---

### **Opción B: Desde GitHub Desktop (GUI)**

#### 1. Abrir GitHub Desktop

#### 2. Seleccionar el repositorio
   - Menú: "Current Repository" → "sistema-etiquetas-amaya"

#### 3. Ver cambios
   - En el panel izquierdo verás todos los archivos modificados
   - Marca los checkboxes de los archivos que quieres incluir

#### 4. Escribir mensaje de commit
   ```
   Release v1.2.0 - Agregar etiqueta Lacteo San Julian
   ```
   
   Descripción (opcional):
   ```
   - Nueva etiqueta: Lacteo San Julian (vertical rotada)
   - Función dibujar_lacteo_san_julian() con 320 líneas
   - Fondo degradado azul personalizado
   - Logo y sello San Julián
   - Nutrition Facts completa
   - Actualización README y CHANGELOG
   ```

#### 5. Hacer commit
   - Click en "Commit to main"

#### 6. Push a GitHub
   - Click en "Push origin"

#### 7. Crear tag (opcional)
   - Menú: "Repository" → "Create Tag"
   - Tag name: `v1.2.0`
   - Description: `Versión 1.2.0 - Etiqueta San Julián`
   - Click "Create Tag"
   - Click "Push origin" nuevamente

---

## 🔍 VERIFICACIÓN POST-PUSH

### 1. Verificar en GitHub (web)
```
https://github.com/InversionesVG/sistema-etiquetas-amaya
```

Debes ver:
- ✅ "Latest commit" con tu mensaje
- ✅ Badge de versión mostrando 1.2.0
- ✅ 3 archivos nuevos de imágenes
- ✅ Tag v1.2.0 en "Releases"

### 2. Verificar desde Terminal
```bash
cd ~/Documents/Sistema_Etiquetas/Win

# Ver último commit
git log -1

# Ver tags
git tag

# Ver estado limpio
git status
```

Debería mostrar:
```
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

---

## ⚠️ PROBLEMAS COMUNES Y SOLUCIONES

### Problema 1: "fatal: not a git repository"
**Solución:**
```bash
cd ~/Documents/Sistema_Etiquetas/Win
# Asegúrate de estar en la carpeta correcta que tiene el .git
```

### Problema 2: "Please tell me who you are"
**Solución:**
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### Problema 3: "Updates were rejected"
**Solución:**
```bash
# Primero traer cambios remotos
git pull origin main

# Luego subir tus cambios
git push origin main
```

### Problema 4: "Merge conflict"
**Solución:**
```bash
# Ver archivos en conflicto
git status

# Resolver conflictos manualmente en los archivos
# Luego:
git add .
git commit -m "Resolver conflictos de merge"
git push origin main
```

### Problema 5: Las imágenes son muy grandes
**Solución:**
```bash
# Ver tamaño de archivos
ls -lh *.png

# Si son mayores a 5MB, GitHub puede rechazarlas
# Optimiza las imágenes antes de subirlas
```

---

## 📝 CHECKLIST FINAL

Antes de cerrar, verifica:

- [ ] Todos los archivos están en `~/Documents/Sistema_Etiquetas/Win/`
- [ ] `git status` muestra "working tree clean"
- [ ] El commit aparece en GitHub
- [ ] Las 3 imágenes nuevas están en el repositorio
- [ ] El README.md muestra versión 1.2.0
- [ ] El CHANGELOG.md tiene la entrada de v1.2.0
- [ ] El tag v1.2.0 existe en GitHub

---

## 🎉 ¡LISTO!

Tu versión 1.2.0 está ahora en GitHub y disponible para:
- ✅ Clonar en otros equipos
- ✅ Colaboradores del equipo
- ✅ Historial de versiones
- ✅ Rollback si es necesario

---

## 📞 SIGUIENTE PASO RECOMENDADO

Después de subir a Git, deberías:

1. **Probar en otro equipo** (para verificar que todo funciona)
2. **Generar nuevo .exe** (para Windows, si es necesario)
3. **Actualizar documentación** de usuario final (si la tienes)

---

**Fecha de creación:** 2026-05-07  
**Versión:** 1.2.0  
**Autor:** Sistema de Etiquetas Amaya Express
