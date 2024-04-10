#include <QGuiApplication>
#include <QQmlApplicationEngine>

auto main(int argc, char *argv[]) -> int {
    const QGuiApplication application{argc, argv};

    const QQmlApplicationEngine engine{"src/main.qml"};

    return QGuiApplication::exec();
}
