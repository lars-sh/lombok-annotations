# JDK11: 'var' is not an allowed annotation name
function suppressJdk11VarIsNotAnAllowedAnnotationName() {
	if [ ${JDK_VERSION} -ge 11 ]; then
		cat < /dev/stdin \
		| grep --invert-match --perl-regexp "^\\[ERROR\\] MavenReportException: Error while generating Javadoc: $"
	else
		cat < /dev/stdin
	fi
}

cat < /dev/stdin \
| suppressJdk11VarIsNotAnAllowedAnnotationName
