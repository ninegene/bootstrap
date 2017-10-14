function add_to_front_of_path
  set -x PATH $argv[1] $PATH
end

function add_to_end_of_path
  set -x PATH $PATH $argv[1]
end

# Custom User Scripts
if test -d "$HOME/bin"
  add_to_front_of_path "$HOME/bin"
end

# Homebrew
if test -d "/usr/local/sbin"
  add_to_end_of_path "/usr/local/sbin"
end
if test -d "/usr/local/bin"
  add_to_end_of_path "/usr/local/bin"
end

# if test -d "/opt/adt/sdk"
#   set -x ANDROID_HOME "/opt/adt/sdk"
#   add_to_end_of_path "$ANDROID_HOME/tools"
#   add_to_end_of_path "$ANDROID_HOME/platform-tools"
# end

# if test -d "/usr/local/scala/bin"
#   set -x SCALA_HOME "/usr/local/scala"
#   add_to_front_of_path "$SCALA_HOME/bin"
# end

# if test -d "/usr/local/groovy/bin"
#   set -x GROOVY_HOME "/usr/local/groovy"
#   add_to_front_of_path "$GROOVY_HOME/bin"
# end

# if test -d "/usr/local/grails/bin"
#   set -x GRAILS_HOME "/usr/local/grails"
#   add_to_front_of_path "$GRAILS_HOME/bin"
# end

if test -d "/usr/local/gradle/bin"
   set -x GRADLE_HOME "/usr/local/gradle"
   add_to_front_of_path "$GRADLE_HOME/bin"
 end

# if test -d "$HOME/.local/share/umake"
#   set -x UMAKE_HOME "$HOME/.local/share/umake"
#   add_to_front_of_path "$UMAKE_HOME/bin"
# end

switch (uname -s)
case Darwin
  set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
  add_to_front_of_path "$JAVA_HOME/bin"
case Linux
  set -x JAVA_HOME "/usr/lib/jvm/jdk8"
  add_to_front_of_path "$JAVA_HOME/bin"
end
