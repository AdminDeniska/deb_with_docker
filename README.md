Образ для сборки питоновского модуля в DEB-пакет для Ubuntu 20.04
Результат сборки - DEB-пакет, который возможно установить командой apt-get install -f <packet.deb>
Для создания полноценного пакета достаточно контрольного файла «control»
В тз используется только обязательный DEBIAN/control.
control — центральный файл пакета, описывающего все основные свойства. control file - текстовый, состоящий из пар «Атрибут: значение»
По сути файл не выполняет важной функции, однако без него образ не сбилдится, в нем указаны только обязательные параметры, это: имя, версия, назначение, архитектура, владелец, описание.
Реализация предполагает возможность изменения состава пакета через enviroments и reqirements.
Основную функцию выполняет утилита dpkg-deb, она собирает из исходников deb package.
В проекте настроен Github Actions с триггером на коммит в main ветку, настройки можно посмотреть в .github/workflows/docker-publish.yml
Запуск сборщика deb пакета.
docker build . -t <image_name>
docker run -it --name <name> -e PY_MODUL=<url на python модуль> DEB_FORM=<version and architecture> -v ~<ProjectDir>:/var/modul <image_name>
Далее в контейнере cp /var/<modul_name>.deb /var/modul/<module_name>.deb и deb пакет появится в проекте.
Остается только выполнить apt-get install -f <packet.deb>


