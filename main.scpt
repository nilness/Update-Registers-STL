
update_register("afp://mhq@register1.local/mhq", "/Volumes/mhq/", "/Volumes/mhq/Library/Application Support/fake/Workflows/")

update_register("afp://mhq@register1a.local/mhq", "/Volumes/mhq/", "/Volumes/mhq/Library/Application Support/fake/Workflows/")

update_register("afp://mhq@register2.local/mhq", "/Volumes/mhq/", "/Volumes/mhq/Library/Application Support/fake/Workflows/")

update_register("afp://mhq@register2a.local/mhq", "/Volumes/mhq/", "/Volumes/mhq/Library/Application Support/fake/Workflows/")

on update_register(volume_name, mount_point, destination)
	
	mount_register(volume_name)
	
	sync_workflows(destination)
	
	do shell script "/usr/sbin/diskutil unmount " & mount_point & ";"
	
end update_register

on mount_register(register_volume)
	tell application "Finder"
		try
			mount volume register_volume
		on error
			return "Error mounting " & register_volume & ". Please check network connection."
		end try
	end tell
end mount_register

on sync_workflows(target)
	set source to "/Volumes/RAID002/Shared/Retail/Current Workflows"
	try
		do shell script "#!/bin/bash;¬
		 /usr/bin/rsync -a '" & source & "' '" & target & "'"
		
	on error
		return "Error syncronizing " & source & " to " & target & "."
	end try
end sync_workflows
