import com.android.build.api.dsl.CommonExtension
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

val githubUser = providers.gradleProperty("gpr.user").orNull ?: System.getenv("GITHUB_ACTOR")
val githubToken = providers.gradleProperty("gpr.key").orNull ?: System.getenv("GITHUB_TOKEN")

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            name = "GitHubPackages"
            url = uri("https://maven.pkg.github.com/inotia00/registry")
            credentials {
                username = githubUser
                password = githubToken
            }
        }
        maven {
            name = "GitHubPackages"
            url = uri("https://maven.pkg.github.com/revanced/registry")
            credentials {
                username = githubUser
                password = githubToken
            }
        }
    }
}

layout.buildDirectory = File("../build")

project(":screenshot_callback") {
    tasks.withType<KotlinCompile>().configureEach {
        kotlinOptions {
            jvmTarget = "17"
        }
    }
}

subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let {
            it as CommonExtension<*, *, *, *, *, *>
            if (it.compileSdk != null && it.compileSdk!! < 31)
                it.compileSdk = 34
        }
    }

    layout.buildDirectory = rootProject.layout.buildDirectory.file(name).get().asFile
    evaluationDependsOn(":app")
}
