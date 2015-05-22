<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="AzureEmailService" generation="1" functional="0" release="0" Id="d5146312-1024-429f-957e-231c9408353f" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="AzureEmailServiceGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="MvcWebRole:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/AzureEmailService/AzureEmailServiceGroup/LB:MvcWebRole:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="MvcWebRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapMvcWebRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="MvcWebRole:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapMvcWebRole:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="MvcWebRoleInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapMvcWebRoleInstances" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleA:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleA:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleA:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleA:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleAInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleAInstances" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleB:AzureMailServiceURL" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleB:AzureMailServiceURL" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleB:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleB:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleB:SendGridPassword" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleB:SendGridPassword" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleB:SendGridUserName" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleB:SendGridUserName" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleB:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleB:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleBInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureEmailService/AzureEmailServiceGroup/MapWorkerRoleBInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:MvcWebRole:Endpoint1">
          <toPorts>
            <inPortMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRole/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapMvcWebRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRole/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapMvcWebRole:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRole/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapMvcWebRoleInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRoleInstances" />
          </setting>
        </map>
        <map name="MapWorkerRoleA:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleA/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleA:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleA/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleAInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleAInstances" />
          </setting>
        </map>
        <map name="MapWorkerRoleB:AzureMailServiceURL" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleB/AzureMailServiceURL" />
          </setting>
        </map>
        <map name="MapWorkerRoleB:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleB/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleB:SendGridPassword" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleB/SendGridPassword" />
          </setting>
        </map>
        <map name="MapWorkerRoleB:SendGridUserName" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleB/SendGridUserName" />
          </setting>
        </map>
        <map name="MapWorkerRoleB:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleB/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleBInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleBInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="MvcWebRole" generation="1" functional="0" release="0" software="C:\Users\Ts\Documents\Visual Studio 2013\Projects\Azure\AzureEmailService\csx\Debug\roles\MvcWebRole" entryPoint="base\x86\WaHostBootstrapper.exe" parameters="base\x86\WaIISHost.exe " memIndex="1792" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;MvcWebRole&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;MvcWebRole&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRoleA&quot; /&gt;&lt;r name=&quot;WorkerRoleB&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRoleInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRoleUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRoleFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="WorkerRoleA" generation="1" functional="0" release="0" software="C:\Users\Ts\Documents\Visual Studio 2013\Projects\Azure\AzureEmailService\csx\Debug\roles\WorkerRoleA" entryPoint="base\x86\WaHostBootstrapper.exe" parameters="base\x86\WaWorkerHost.exe " memIndex="1792" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WorkerRoleA&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;MvcWebRole&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRoleA&quot; /&gt;&lt;r name=&quot;WorkerRoleB&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleAInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleAUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleAFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="WorkerRoleB" generation="1" functional="0" release="0" software="C:\Users\Ts\Documents\Visual Studio 2013\Projects\Azure\AzureEmailService\csx\Debug\roles\WorkerRoleB" entryPoint="base\x86\WaHostBootstrapper.exe" parameters="base\x86\WaWorkerHost.exe " memIndex="1792" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="AzureMailServiceURL" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="SendGridPassword" defaultValue="" />
              <aCS name="SendGridUserName" defaultValue="" />
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WorkerRoleB&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;MvcWebRole&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRoleA&quot; /&gt;&lt;r name=&quot;WorkerRoleB&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleBInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleBUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AzureEmailService/AzureEmailServiceGroup/WorkerRoleBFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="MvcWebRoleUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="WorkerRoleAUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="WorkerRoleBUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="MvcWebRoleFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="WorkerRoleAFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="WorkerRoleBFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="MvcWebRoleInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="WorkerRoleAInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="WorkerRoleBInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="1b484499-f62b-47be-87fa-0c0301b398c2" ref="Microsoft.RedDog.Contract\ServiceContract\AzureEmailServiceContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="f6a6bd3c-8b50-48a2-92a4-cf44d61544b1" ref="Microsoft.RedDog.Contract\Interface\MvcWebRole:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/AzureEmailService/AzureEmailServiceGroup/MvcWebRole:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>