# avitoTest

Приложение для поиска изображений на основе API Unsplash.

## Установка приложения

### Требования
- macOS
- Xcode (последняя версия)
- Действующий API ключ Unsplash

### Установка и настройка

1. **Клонируйте репозиторий**:
```bash
git clone https://gitverse.ru/aalikorn/avitoTest.git
```
2. **Перейдите в папку с проектом и откройте файл .xcodeproj в Xcode**:
```bash
cd avitoTest
open media-search-app.xcodeproj
```
3. **Вставьте свой API ключ**

Откройте файл avitoTest/Utils/APIKey и поменяйте значение перемнной APIKey на строку с вашим ключом.

### Запуск

1. В Xcode выберите устройство или симулятор, на котором хотите запустить приложение (в верхней панели).
2. Нажмите Command + R или кнопку Run в Xcode.
3. Приложение запустится на выбранном симуляторе или физическом устройстве.


## Использование приложения

При запуске приложения вы увидите случайные изображения. Для поиска изображений необходимо ввести запрос в поисковую строку, расположенную в верхней части экрана. В процессе ввода вы увидите подсказки на основе предыдущих запросов.

После завершения ввода вы получите результаты поиска изображений, соответствующих запросу. Если подходящих изображений не найдено, будет отображено сообщение об ошибке.

При нажатии на изображение из результатов поиска откроется экран с детальной информацией о выбранной картинке.



