# JDK11: 'var' is not an allowed annotation name
function suppressJdk11VarIsNotAnAllowedAnnotationName() {
	if [ ${JDK_VERSION} -ge 11 ]; then
		cat < /dev/stdin \
		| grep --invert-match --perl-regexp "^\\[ERROR\\] Error while creating javadoc report: $"
		| grep --invert-match --perl-regexp "^\\[ERROR\\] MavenReportException: Error while generating Javadoc: $"
	else
		cat < /dev/stdin
	fi
}

# JDK14: The JavaDoc creation logs errors about missing "javadoc-bundle-option" folders.
function suppressJdk14Warnings() {
	if [ ${JDK_VERSION} -eq 14 ]; then
		cat < /dev/stdin \
		| grep --invert-match --perl-regexp "^\\[ERROR\\] Error fetching link: .*[/\\\\]target[/\\\\]javadoc-bundle-options\\. Ignored it\\.$"
	else
		cat < /dev/stdin
	fi
}

JDK_VERSION=`echo ${TRAVIS_JDK_VERSION} | grep --only-matching --perl-regexp \\\\d+`

cat < /dev/stdin \
| suppressJdk11VarIsNotAnAllowedAnnotationName \
| suppressJdk14Warnings
