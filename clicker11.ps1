#import mouse_event
Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace W;

# Let's get the foreground window so we know when it closes
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public class Tricks {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
}
"@


# This gets the foreground window as a variable and sets p equal to the process name
DO {
	$a = [tricks]::GetForegroundWindow()
	$p = Get-Process | Where-Object { $_.mainWindowHandle -eq $a } | Select-Object processName | Out-String 
	
	#This will continue until powershell is deselected
} while ($p | Select-String -Pattern "terminal")


#left mouse clicks until the window loses focus
while($true)
{
	$b = [tricks]::GetForegroundWindow()
	if ($b -eq $a) {
		[W.U32]::mouse_event(6,0,0,0,0);
		Start-Sleep -s 0.6;
	}
	else {
		break;
	}
}
