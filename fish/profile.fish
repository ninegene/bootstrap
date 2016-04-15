# add to front of path
function prepand_to_path
  set -x PATH $argv[1] $PATH
end

# add to end of path
function append_to_path
  set -x PATH $PATH $argv[1]
end

if test -d "/usr/local/sbin"
  prepand_to_path "/usr/local/sbin"
end

if test -d "$HOME/bin"
  prepand_to_path "$HOME/bin"
end

switch (uname -s)
case Darwin
  set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
case Linux
  set -x JAVA_HOME "/usr/lib/jvm/jdk8"
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

if test -d "/usr/local/groovy/bin"
  set -x GROOVY_HOME "/usr/local/groovy"
  append_to_path "$GROOVY_HOME/bin"
end

if test -d "/usr/local/grails/bin"
  set -x GRAILS_HOME "/usr/local/grails"
  append_to_path "$GRAILS_HOME/bin"
end

if test -d "/usr/local/gradle/bin"
  set -x GRADLE_HOME "/usr/local/gradle"
  append_to_path "$GRADLE_HOME/bin"
end

if test -d "$HOME/.local/share/umake"
  set -x UMAKE_HOME "$HOME/.local/share/umake"
  prepand_to_path "$UMAKE_HOME/bin"
end
