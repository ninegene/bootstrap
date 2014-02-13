set -x platform (uname)

# add to front of path
function prepand_to_path
  set -x PATH $argv[1] $PATH
end

# add to end of path
function append_to_path
  set -x PATH $PATH $argv[1]
end

### Linux

if test -d "$HOME/bin"
  prepand_to_path "$HOME/bin"
end

if test -d "/usr/lib/jvm/jdk7/bin"
  set -x JAVA_HOME "/usr/lib/jvm/jdk7"
  prepand_to_path "$JAVA_HOME/bin"
end

if test -d "/opt/idea/bin"
  set -x IDEA_JDK "$JAVA_HOME"
  set -x IDEA_HOME "/opt/idea"
  append_to_path "$IDEA_HOME/bin"
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

# SmartGitHg git/hg ui client for Linux
if test -d "/opt/smartgithg/bin"
  set -x SMARTGIT_JAVA_HOME "$JAVA_HOME"
  append_to_path /opt/smartgithg/bin
end

### Mac

# MacPorts path
if test -d "/opt/local/bin"
  prepand_to_path /opt/local/bin
end
if test -d "/opt/local/sbin"
  prepand_to_path /opt/local/sbin
end

if test -d "/opt/local/lib/mysql55/bin"
  prepand_to_path /opt/local/lib/mysql55/bin
end

if test -d "/opt/local/lib/mariadb/bin"
  prepand_to_path /opt/local/lib/mariadb/bin
end
