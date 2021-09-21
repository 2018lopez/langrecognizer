using build

class Build : BuildPod {

	new make() {
		podName = "hello"
		summary = "My Awesome Hello Project"
		version = Version("1.0")

		meta = [
			"proj.name" : "Hello"
		]

		depends = [
			"sys 1.0",
			"afPegger 1.1.4 - 1.1"
		]

		srcDirs = [`fan/`]
		resDirs = [,]

		docApi = true
		docSrc = true
	}
}
