begin
  require File.expand_path('../../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
end

# ruby-debug, not necessary, but useful if we have it
begin
  require 'ruby-debug'
rescue LoadError; end

require 'contest'
require 'mocha'

# The actual library
require File.join(File.dirname(__FILE__), '..', 'lib', 'virtualbox')

# Data
class Test::Unit::TestCase
  def mock_xml_doc
    Nokogiri::XML(mock_xml)
  end

  def mock_xml
    <<-xml
<?xml version="1.0"?>
<VirtualBox xmlns="http://www.innotek.de/VirtualBox-settings" version="1.9-macosx">
  <Machine uuid="{8710d3db-d96a-46ed-9004-59fa891fda90}" name="foo" OSType="Ubuntu" currentSnapshot="{f1e6edb3-6e12-4615-9642-a80a3a1ad115}" lastStateChange="2010-02-07T20:01:20Z">
    <Description>This is a description</Description>
    <ExtraData>
      <ExtraDataItem name="GUI/AutoresizeGuest" value="on"/>
      <ExtraDataItem name="GUI/Fullscreen" value="off"/>
      <ExtraDataItem name="GUI/LastWindowPostion" value="1040,171,720,422"/>
      <ExtraDataItem name="GUI/MiniToolBarAlignment" value="bottom"/>
      <ExtraDataItem name="GUI/MiniToolBarAutoHide" value="on"/>
      <ExtraDataItem name="GUI/SaveMountedAtRuntime" value="yes"/>
      <ExtraDataItem name="GUI/Seamless" value="off"/>
      <ExtraDataItem name="GUI/ShowMiniToolBar" value="yes"/>
      <ExtraDataItem name="VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/GuestPort" value="23"/>
      <ExtraDataItem name="VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/HostPort" value="2222"/>
      <ExtraDataItem name="VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/Protocol" value="TCP"/>
    </ExtraData>
    <Hardware version="2">
      <CPU count="1">
        <HardwareVirtEx enabled="true" exclusive="false"/>
        <HardwareVirtExNestedPaging enabled="false"/>
        <HardwareVirtExVPID enabled="false"/>
        <PAE enabled="true"/>
      </CPU>
      <Memory RAMSize="360"/>
      <Boot>
        <Order position="1" device="Floppy"/>
        <Order position="2" device="DVD"/>
        <Order position="3" device="HardDisk"/>
        <Order position="4" device="None"/>
      </Boot>
      <Display VRAMSize="12" monitorCount="1" accelerate3D="false" accelerate2DVideo="false"/>
      <RemoteDisplay enabled="false" port="3389" authType="Null" authTimeout="5000"/>
      <BIOS>
        <ACPI enabled="true"/>
        <IOAPIC enabled="false"/>
        <Logo fadeIn="true" fadeOut="true" displayTime="0"/>
        <BootMenu mode="MessageAndMenu"/>
        <TimeOffset value="0"/>
        <PXEDebug enabled="false"/>
      </BIOS>
      <USBController enabled="true" enabledEhci="true">
        <DeviceFilter name="Apple, Inc Apple Keyboard [0069]" active="true" vendorId="05ac" productId="0220" revision="0069" manufacturer="Apple, Inc" product="Apple Keyboard" remote="no"/>
        <DeviceFilter name="Micron Built-in iSight [0189]" active="false" vendorId="05ac" productId="8501" revision="0189" manufacturer="Micron" product="Built-in iSight" remote="no"/>
      </USBController>
      <Network>
        <Adapter slot="0" enabled="true" MACAddress="0800279C2E41" cable="true" speed="0" type="Am79C973">
          <NAT/>
        </Adapter>
        <Adapter slot="1" enabled="false" MACAddress="0800277D1707" cable="true" speed="0" type="Am79C973"/>
        <Adapter slot="2" enabled="false" MACAddress="080027FB5229" cable="true" speed="0" type="Am79C973"/>
        <Adapter slot="3" enabled="false" MACAddress="080027DE7343" cable="true" speed="0" type="Am79C973"/>
        <Adapter slot="4" enabled="false" MACAddress="0800277989CB" cable="true" speed="0" type="Am79C973"/>
        <Adapter slot="5" enabled="false" MACAddress="08002768E43B" cable="true" speed="0" type="Am79C973"/>
        <Adapter slot="6" enabled="false" MACAddress="080027903DF3" cable="true" speed="0" type="Am79C973"/>
        <Adapter slot="7" enabled="false" MACAddress="0800276A0A7D" cable="true" speed="0" type="Am79C973"/>
      </Network>
      <UART>
        <Port slot="0" enabled="false" IOBase="0x3f8" IRQ="4" hostMode="Disconnected"/>
        <Port slot="1" enabled="false" IOBase="0x3f8" IRQ="4" hostMode="Disconnected"/>
      </UART>
      <LPT>
        <Port slot="0" enabled="false" IOBase="0x378" IRQ="4"/>
        <Port slot="1" enabled="false" IOBase="0x378" IRQ="4"/>
      </LPT>
      <AudioAdapter controller="AC97" driver="CoreAudio" enabled="false"/>
      <SharedFolders>
        <SharedFolder name="foo" hostPath="/foo" writable="true"/>
        <SharedFolder name="bar" hostPath="/bar" writable="true"/>
      </SharedFolders>
      <Clipboard mode="Bidirectional"/>
      <Guest memoryBalloonSize="0" statisticsUpdateInterval="0"/>
      <GuestProperties>
        <GuestProperty name="/VirtualBox/GuestInfo/OS/Product" value="Linux" timestamp="1265440664974640000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/OS/Release" value="2.6.24-26-virtual" timestamp="1265440664974987000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/OS/Version" value="#1 SMP Tue Dec 1 20:00:30 UTC 2009" timestamp="1265440664975592000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/OS/ServicePack" value="" timestamp="1265440664976342000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestAdd/Revision" value="3.1.2" timestamp="1265440664977228000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestAdd/Version" value="56127" timestamp="1265440664977917000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/OS/LoggedInUsers" value="1" timestamp="1265441395765168000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/Net/Count" value="1" timestamp="1265441395765770000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/Net/0/V4/IP" value="10.0.2.15" timestamp="1265441395765987000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/Net/0/V4/Broadcast" value="10.0.2.255" timestamp="1265441395766412000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/Net/0/V4/Netmask" value="255.255.255.0" timestamp="1265441395766827000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/Net/0/Status" value="Up" timestamp="1265441395767109000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/OS/NoLoggedInUsers" value="false" timestamp="1265440815142014000" flags=""/>
        <GuestProperty name="/VirtualBox/HostInfo/GUI/LanguageID" value="en_US" timestamp="1265440628402728000" flags=""/>
        <GuestProperty name="/VirtualBox/GuestInfo/OS/LoggedInUsersList" value="hobo" timestamp="1265441395763755000" flags=""/>
      </GuestProperties>
    </Hardware>
    <StorageControllers>
      <StorageController name="foo" type="PIIX4" PortCount="2">
        <AttachedDevice type="HardDisk" port="0" device="0">
          <Image uuid="{2c16dd48-4cf1-497e-98fa-84ed55cfe71f}"/>
        </AttachedDevice>
        <AttachedDevice type="DVD" port="1" device="0"/>
      </StorageController>
    </StorageControllers>
  </Machine>
</VirtualBox>
xml
  end

  def mock_bridged_ifs_list
    <<-TXT
Sun VirtualBox Command Line Management Interface Version 3.1.4
(C) 2005-2010 Sun Microsystems, Inc.
All rights reserved.

Name:            en0: Ethernet
GUID:            0000000f-0000-f000-f000-00fffffffff1
Dhcp:            Disabled
IPAddress:       192.168.0.2
NetworkMask:     255.255.255.0
IPV6Address:     ffff:0000:0000:0000:0000:0000:0000:0001
IPV6NetworkMaskPrefixLength: 64
HardwareAddress: 00:ff:00:00:00:01
MediumType:      Ethernet
Status:          Up
VBoxNetworkName: HostInterfaceNetworking-en0: Ethernet

Name:            en1: AirPort
GUID:            0000000f-0000-f000-f000-00fffffffff2
Dhcp:            Enabled
IPAddress:       192.168.0.3
NetworkMask:     255.255.255.0
IPV6Address:     ffff:0000:0000:0000:0000:0000:0000:0002
IPV6NetworkMaskPrefixLength: 64
HardwareAddress: 00:ff:00:00:00:02
MediumType:      Ethernet
Status:          Down
VBoxNetworkName: HostInterfaceNetworking-en1: AirPort
TXT
  end
  
  def mock_host_only_ifs_list
    <<-TXT
Sun VirtualBox Command Line Management Interface Version 3.1.6
(C) 2005-2010 Sun Microsystems, Inc.
All rights reserved.

Name:            vboxnet0
GUID:            0000000f-0000-f000-f000-00fffffffff3
Dhcp:            Disabled
IPAddress:       192.168.56.1
NetworkMask:     255.255.255.0
IPV6Address:     
IPV6NetworkMaskPrefixLength: 0
HardwareAddress: 00:ff:00:00:00:03
MediumType:      Ethernet
Status:          Down
VBoxNetworkName: HostInterfaceNetworking-vboxnet0
TXT
  end
end