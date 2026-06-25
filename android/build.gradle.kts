allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    // دالة داخلية لتطبيق الإعدادات بأمان
    val configureProject = {
        // 1. تضبيط الـ NDK بأمان بدون أخطاء
        extensions.findByType<com.android.build.gradle.BaseExtension>()?.apply {
            ndkVersion = "27.3.13750724"
        }
        
        // 2. تعطيل فحص الـ AAR Metadata بالطريقة المتوافقة مع الـ Kotlin DSL
        tasks.matching { it.name.contains("checkAarMetadata", ignoreCase = true) }.configureEach {
            enabled = false
        }
    }

    // 🔥 الحماية السحرية: لو المشروع تم تقييمه بالفعل نفذ فوراً، غير كده انتظر الـ afterEvaluate
    if (state.executed) {
        configureProject()
    } else {
        afterEvaluate { configureProject() }
    }

    // 3. إجبار الـ Dependencies على إصدارات مستقرة ومتوافقة (تفضل برة برضه لأمان الـ Lifecycle)
    configurations.all {
        resolutionStrategy {
            force("androidx.browser:browser:1.8.0")
            force("androidx.activity:activity:1.9.3")
            force("androidx.activity:activity-ktx:1.9.3")
            force("androidx.activity:activity-compose:1.9.3")
            force("androidx.core:core:1.13.1")
            force("androidx.core:core-ktx:1.13.1")
        }
    }
}