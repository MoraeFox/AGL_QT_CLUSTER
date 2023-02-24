/*
 * Copyright 2020,2021 Panasonic Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSurfaceFormat>
#include <QDir>
#include <QQmlContext>
#include <QDebug>

//Fox added start
#include <QString>
//Fox added end

int main(int argc, char *argv[])
{

    QSurfaceFormat defaultFormat;
    defaultFormat.setSwapBehavior(QSurfaceFormat::TripleBuffer);
    defaultFormat.setRenderableType(QSurfaceFormat::OpenGLES);
    defaultFormat.setProfile(QSurfaceFormat::NoProfile);
    defaultFormat.setVersion(2,0);
    defaultFormat.setSwapInterval(1);
    defaultFormat.setDepthBufferSize(8);
    defaultFormat.setAlphaBufferSize(8);
    QSurfaceFormat::setDefaultFormat(defaultFormat);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("CurDirPath", QString(QCoreApplication::applicationDirPath()));
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
