#import mouse_event
Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace W;
Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void SetCursorPos(int x, int y);' -Name POS -Namespace W;

# These are starting variables to move the mouse to. They were correct on the computer I was on at the time, 
# but different computers have different dimentions and aspect ratios so we need to manipulate them
$x1 = 803
$x2 = 950
$y = 700

$mouse_pos1 = "n"
$mouse_pos2 = "n"

# Here is where you set the mouse position to click on the progress bar to move it to the end. Moves 5 pixels at a time so you can 
# get it as close to the end as possible. You can also just move the window to the correct spot.
do {
	[W.POS]::SetCursorPos($x1, $y);
	$mouse_pos1 = Read-Host "Is the first mouse position good? ([u]p, [d]own, [l]eft, [r]ight, [y]es)"
	switch ($mouse_pos1) 
	{
		"u" { $y -= 5 }
		"d" { $y += 5 }
		"l" { $x1 -= 5 }
		"r" { $x1 += 5 }
		"y" { "First position set" }
		Default { "Not accepted, try again" }
	}
}
until($mouse_pos1 -eq "y")

# Here is where you move the mouse to the "Next" button
do {
	[W.POS]::SetCursorPos($x2, $y);
	$mouse_pos2 = Read-Host "Is the second mouse position good? ([u]p, [d]own, [l]eft, [r]ight, [y]es)"
	switch ($mouse_pos2) 
	{
		"u" { $y -= 5 }
		"d" { $y += 5 }
		"l" { $x2 -= 5 }
		"r" { $x2 += 5 }
		"y" { "Second position set" }
		Default { "Not accepted, try again" }
	}
}
until($mouse_pos2 -eq "y")


# This will continue to click those 2 spots until told to stop
while($true)
{
	[W.POS]::SetCursorPos($x1, $y);
	[W.U32]::mouse_event(6,0,0,0,0);
	Start-Sleep -s 0.8;
	[W.POS]::SetCursorPos($x2, $y);
	[W.U32]::mouse_event(6,0,0,0,0);
	Start-Sleep -s 0.4;
	
}

