export JAVA_HOME=$(/usr/libexec/java_home)
export JDK_HOME=$(/usr/libexec/java_home)
export PYTHONPATH=$(python -c 'import sys;print ":".join(sys.path)')
eval $(docker-machine env dev)
export PATH="/usr/local/sbin:$PATH"
