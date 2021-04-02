# JDK11 and later: 'var' is not an allowed annotation name
function suppressJdk11AndLaterVarIsNotAnAllowedAnnotationName() {
	if [ ${JDK_VERSION} -ge 11 ]; then
		cat < /dev/stdin \
		| grep --invert-match --perl-regexp "^\\[ERROR\\] Error while creating javadoc report: $"
		| grep --invert-match --perl-regexp "^\\[ERROR\\] MavenReportException: Error while generating Javadoc: $"
	else
		cat < /dev/stdin
	fi
}

JDK_VERSION=`echo "$1" | grep --only-matching --perl-regexp "^(1\\\\.)?\\\\K\\\\d+$"`
if [ -z "${JDK_VERSION}" ]; then
	echo "[ERROR] The given JDK version is empty. Given value: \"$1\"" >&2
	false
else
	cat < /dev/stdin \
	| suppressJdk11AndLaterVarIsNotAnAllowedAnnotationName
fi