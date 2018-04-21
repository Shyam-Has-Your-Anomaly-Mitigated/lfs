'
#│paused tasks│@
═╪════════════╪═══════════════════════
1│task a      │YYYY-MM-DD HH:mm:SS.sss
2│task b      │YYYY-MM-DD HH:mm:SS.sss
3│task c      │YYYY-MM-DD HH:mm:SS.sss

#│started tasks in progress│@
═╪═════════════════════════╪═══════════════════════
1│task a                   │YYYY-MM-DD HH:mm:SS.sss
2│task b                   │YYYY-MM-DD HH:mm:SS.sss
3│task c                   │YYYY-MM-DD HH:mm:SS.sss

...

dislpay all active tasks?
	$ cronmonitor display
dislpay paused tasks?
	$ cronmonitor display paused
display non-terminated tasks?
	$ cronmonitor display started
start a new task?
	$ cronmonitor start $job
stop a task?
	$ cronmonitor stop $task
pause a task?
	$ cronmonitor pause $#
restart a task?
	$ cronmonitor continue $id
complete a task?
	$ cronmonitor complete $nth
'
