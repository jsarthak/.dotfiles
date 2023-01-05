#!/bin/env bash

status=`xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -v`
if [ $status == 'false' ];
then
	  polybar-msg hook caffeine 2
	    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T && \
		      notify-send --icon=gtk Test 'Caffeine Enabled!'
			  else
				    polybar-msg hook caffeine 1
				      xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T && \
					        notify-send --icon=gtk Test 'Caffeine Disabled!'
fi
