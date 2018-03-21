CLASSPATH=$(JARS=($JENKINS_FETCHER_HOME/lib/*.jar); IFS=:; echo "${JARS[*]}")
TMP=$(mktemp)
java -cp $CLASSPATH groovy.lang.GroovyShell $JENKINS_FETCHER_HOME/main.groovy | tee $TMP
# Last line of the stdout will be the location of the archive
WAR=$(tail -1 $TMP)
java -jar -Duser.home="$JENKINS_HOME" $JAVA_OPTS $WAR $JENKINS_OPTS || echo "Arrgg!! Looks like something went wrong. Check you have defined a jenkins version in your config - it's usually that."
