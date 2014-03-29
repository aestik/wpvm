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
		if [ -f /db/wordpress.sql ]
		then
			echo "Restore saved database"
			/usr/bin/mysql -u root -pmysqlhehehe --database wordpress < /db/wordpress.sql;
		fi
		;;
	stop)
		echo "Saving database"
		/usr/bin/mysqldump -u root -pmysqlhehehe wordpress > /db/wordpress.sql;
		;;
	restart)
		echo "this is restart"
		;;
	status)
		echo "this is status"
		;;
	reload)
		echo "this is reload"
		;;
	*)
		echo "Usage: $0 {start|stop|restart|reload|status}"
		exit 2
		;;
esac
