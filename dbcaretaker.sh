### BEGIN INIT INFO
# Provides:          dbcaretaker
# Required-Start:    mysql
# Required-Stop:     mysql
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Backup and restore database
# Description:       Backup and restore database
### END INIT INFO

# Using the lsb functions to perform the operations.
. /lib/lsb/init-functions


case $1 in
	start)
		# Checked the PID file exists and check the actual status of process
		if [ -e $PIDFILE ]; then
			status_of_proc -p $PIDFILE $DAEMON "$NAME process" && status="0" || status="$?"
			# If the status is SUCCESS then don't need to start again.
			if [ $status = "0" ]; then
				exit # Exit
			fi
		fi
		# Start the daemon.
		log_daemon_msg "Starting the process" "$NAME"
		# Start the daemon with the help of start-stop-daemon
		# Log the message appropriately
		if start-stop-daemon --start --quiet --oknodo --pidfile $PIDFILE --exec $DAEMON ; then
			log_end_msg 0
		else
			log_end_msg 1
		fi
		;;
	stop)
		# Stop the daemon.
		if [ -e $PIDFILE ]; then
			status_of_proc -p $PIDFILE $DAEMON "Stoppping the $NAME process" && status="0" || status="$?"
			if [ "$status" = 0 ]; then
				start-stop-daemon --stop --quiet --oknodo --pidfile $PIDFILE
				/bin/rm -rf $PIDFILE
			fi
		else
			log_daemon_msg "$NAME process is not running"
			log_end_msg 0
		fi
		;;
	restart)
		# Restart the daemon.
		$0 stop && sleep 2 && $0 start
		;;
	status)
		# Check the status of the process.
		if [ -e $PIDFILE ]; then
			status_of_proc -p $PIDFILE $DAEMON "$NAME process" && exit 0 || exit $?
		else
			log_daemon_msg "$NAME Process is not running"
			log_end_msg 0
		fi
		;;
	reload)
		# Reload the process. Basically sending some signal to a daemon to reload
		# it configurations.
		if [ -e $PIDFILE ]; then
			start-stop-daemon --stop --signal USR1 --quiet --pidfile $PIDFILE --name $NAME
			log_success_msg "$NAME process reloaded successfully"
		else
			log_failure_msg "$PIDFILE does not exists"
		fi
		;;
	*)
		echo "Usage: $0 {start|stop|restart|reload|status}"
		exit 2
		;;
esac