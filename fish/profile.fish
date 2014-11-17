set -x platform (uname)

# add to front of path
function prepand_to_path
  set -x PATH $argv[1] $PATH
end

# add to end of path
function append_to_path
  set -x PATH $PATH $argv[1]
end

if test -d "$HOME/bin"
  prepand_to_path "$HOME/bin"
end

switch (uname -s)
case Darwin
  set -x JAVA_HOME (/usr/libexec/java_home -v 1.7)
case Linux
  set -x JAVA_HOME "/usr/lib/jvm/jdk7"
end

prepand_to_path "$JAVA_HOME/bin"

if test -d "/opt/idea/bin"
  set -x IDEA_JDK "$JAVA_HOME"
  set -x IDEA_HOME "/opt/idea"
  append_to_path "$IDEA_HOME/bin"
end

if test -d "/opt/adt/sdk"
  set -x ANDROID_HOME "/opt/adt/sdk"
  append_to_path "$ANDROID_HOME/tools"
  append_to_path "$ANDROID_HOME/platform-tools"
end

if test -d "/opt/groovy/bin"
  set -x GROOVY_HOME "/opt/groovy"
  append_to_path "$GROOVY_HOME/bin"
end

if test -d "/opt/grails/bin"
  set -x GRAILS_HOME "/opt/grails"
  append_to_path "$GRAILS_HOME/bin"
end

if test -d "/opt/gradle/bin"
  set -x GRADLE_HOME "/opt/gradle"
  append_to_path "$GRADLE_HOME/bin"
end

