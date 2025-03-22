<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:masterdata:E58_MasterDataMPEvent:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:masterdata:E58_MasterDataMPEvent:elements:v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<urn17:MasterDataMPEventMessage>
			<urn17:MasterDataMPEvent>
				<urn17:Header>
					<xsl:if test="ExternalMessageID">
						<urn2:Identification>
							<xsl:value-of select="ExternalMessageID" />
						</urn2:Identification>
					</xsl:if>
					<xsl:if test="ExternalMessageType">
						<urn2:DocumentType>
							<xsl:value-of select="ExternalMessageType" />
						</urn2:DocumentType>
					</xsl:if>
					<xsl:if test="MessageTimestamp">
						<urn2:Creation>
							<xsl:value-of select="MessageTimestamp" />
						</urn2:Creation>
					</xsl:if>
					<urn2:PhysicalSenderEnergyParty>
						<xsl:if test="PhysicalSender">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="PhysicalSender" />
							</urn2:Identification>
						</xsl:if>
					</urn2:PhysicalSenderEnergyParty>
					<urn2:JuridicalSenderEnergyParty>
						<xsl:if test="JuridicalSender">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="JuridicalSender" />
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalSenderEnergyParty>
					<urn2:JuridicalRecipientEnergyParty>
						<xsl:if test="JuridicalReceiver">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="JuridicalReceiver" />
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalRecipientEnergyParty>
					<urn2:PhysicalRecipientEnergyParty>
						<xsl:if test="PhysicalReceiver">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="PhysicalReceiver" />
							</urn2:Identification>
						</xsl:if>
					</urn2:PhysicalRecipientEnergyParty>
					<!--No information on what to add to this senderRouting information yet
					<urn2:SenderRoutingInformation>?</urn2:SenderRoutingInformation>
					-->
				</urn17:Header>
				<urn17:ProcessEnergyContext>
					<xsl:if test=".//*[_type='TRANSACTION']/ExternalTransactionType">
						<urn3:EnergyBusinessProcess>
							<xsl:value-of select="./*/*/ExternalTransactionType" />
						</urn3:EnergyBusinessProcess>
					</xsl:if>
					<xsl:if test="ProcessRole">
						<urn3:EnergyBusinessProcessRole>
							<xsl:value-of select="ProcessRole" />
						</urn3:EnergyBusinessProcessRole>
					</xsl:if>
					<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
				</urn17:ProcessEnergyContext>
				<urn17:Transaction>
				    
					<xsl:if test=".//*[_type='OTB_TRP']/StartOfOccurrence">
						<urn18:StartOfOccurrence>
							<xsl:value-of select=".//*[_type='OTB_TRP']/StartOfOccurrence" />
						</urn18:StartOfOccurrence>
					</xsl:if>
				    <xsl:if test=".//*[_type='OTB_TRP']/OriginalMessageID">
						<urn18:OriginalBusinessDocumentReference>
							<xsl:value-of select=".//*[_type='OTB_TRP']/OriginalMessageID" />
						</urn18:OriginalBusinessDocumentReference>
					</xsl:if>
				    <xsl:if test=".//*[_type='OTB_TRP']/OriginalMessageSender">
						<urn18:OriginalBusinessDocumentSender schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='OTB_TRP']/OriginalMessageSender" />
						</urn18:OriginalBusinessDocumentSender>
					</xsl:if>
					<xsl:if test=".//*[_type='OTB_TRP']/Description">
						<urn18:Description>
							<xsl:value-of select=".//*[_type='OTB_TRP']/Description" />
						</urn18:Description>
					</xsl:if>
					<urn18:MeteringPointUsedDomainLocation>
						<urn18:Identification  schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='E58_ACP']/MeteringPointEAN" />
						</urn18:Identification>
						<xsl:if test=".//*[_type='E58_ACP']/MeteringPointStatus">
							<urn18:PhysicalStatusType listAgencyIdentifier="NFI">
								<xsl:value-of select=".//*[_type='E58_ACP']/MeteringPointStatus" />
							</urn18:PhysicalStatusType>
						</xsl:if>
						<xsl:if test=".//*[_type='E58_ACP']/AccountingPointType">
							<urn18:MeteringPointType listAgencyIdentifier="NFI">
								<xsl:value-of select=".//*[_type='E58_ACP']/AccountingPointType" />
							</urn18:MeteringPointType>
						</xsl:if>
						<xsl:if test=".//*[_type='E58_ACP']/AccountingPointSubtype">
							<urn18:MeteringPointSubType listAgencyIdentifier="NFI">
								<xsl:value-of select=".//*[_type='E58_ACP']/AccountingPointSubtype" />
							</urn18:MeteringPointSubType>
						</xsl:if>
						<xsl:if test=".//*[_type='E58_ACP']/IsRemotelyConnectable">
							<urn18:RemoteConnectable>
					            <xsl:choose>
								   <xsl:when test=".//*[_type='E58_ACP']/IsRemotelyConnectable='false'">0</xsl:when>
								   <xsl:otherwise>1</xsl:otherwise>
							   </xsl:choose>
							</urn18:RemoteConnectable>
						</xsl:if>
						<xsl:if test=".//*[_type='E58_ACP']/MeteringTimeDivision">
							<urn18:MeteringTimeDivision>
								<xsl:value-of select=".//*[_type='E58_ACP']/MeteringTimeDivision" />
							</urn18:MeteringTimeDivision>
						</xsl:if>
						<xsl:if test=".//*[_type='E58_ACP']/MeterNumber">
							<urn18:MeterIdentification>
								<xsl:value-of select=".//*[_type='E58_ACP']/MeterNumber" />
							</urn18:MeterIdentification>
						</xsl:if>
						<xsl:if test=".//*[_type='E58_ACP']/RelatedMeteringPointEAN">
							<urn18:RelatedMeteringPoint schemeAgencyIdentifier="9">
								<xsl:value-of select=".//*[_type='E58_ACP']/RelatedMeteringPointEAN" />
							</urn18:RelatedMeteringPoint>
						</xsl:if>
						<xsl:if test=".//*[_type='E58_ACP']/EnergyCommunityIdentifier">
							<urn18:CommunityIdentification>
								<xsl:value-of select=".//*[_type='E58_ACP']/EnergyCommunityIdentifier" />
							</urn18:CommunityIdentification>
						</xsl:if>					
						<xsl:if test=".//*[_type='E58_ACP']/EnergyCommunityName">
							<urn18:CommunityName>
								<xsl:value-of select=".//*[_type='E58_ACP']/EnergyCommunityName" />
							</urn18:CommunityName>
						</xsl:if>											
						<xsl:if test=".//*[_type='E58_ACP']/MeteringGridAreaCode">
							<urn18:MeteringGridAreaUsedDomainLocation>
								<urn18:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='E58_ACP']/MeteringGridAreaCode" />
								</urn18:Identification>
							</urn18:MeteringGridAreaUsedDomainLocation>
						</xsl:if>
						<!-- Loop for Metering Point Address -->
						<xsl:for-each select=".//*[_type='E58_MPA']">
							<urn18:MeteringPointAddress>
								<urn18:Type listAgencyIdentifier="NFI">
									<xsl:value-of select="AddressType" />
								</urn18:Type>
								<xsl:if test="StreetName">
									<urn18:StreetName>
										<xsl:value-of select="StreetName" />
									</urn18:StreetName>
								</xsl:if>
								<xsl:if test="BuildingNumber">
									<urn18:BuildingNumber>
										<xsl:value-of select="BuildingNumber" />
									</urn18:BuildingNumber>
								</xsl:if>
								<xsl:if test="StairwellIdentification">
									<urn18:FloorIdentification>
										<xsl:value-of select="StairwellIdentification" />
									</urn18:FloorIdentification>
								</xsl:if>
								<xsl:if test="Apartment">
									<urn18:RoomIdentification>
										<xsl:value-of select="Apartment" />
									</urn18:RoomIdentification>
								</xsl:if>
								<xsl:if test="PostalCode">
									<urn18:Postcode>
										<xsl:value-of select="PostalCode" />
									</urn18:Postcode>
								</xsl:if>
								<xsl:if test="PostOffice">
									<urn18:CityName>
										<xsl:value-of select="PostOffice" />
									</urn18:CityName>
								</xsl:if>
								<xsl:if test="CountryCode">
									<urn18:CountryCode schemeAgencyIdentifier="5">
										<xsl:value-of select="CountryCode" />
									</urn18:CountryCode>
								</xsl:if>

								<xsl:if test="AddressNote">
									<urn18:AddressFreeForm>
										<xsl:value-of select="AddressNote" />
									</urn18:AddressFreeForm>
								</xsl:if>
								<xsl:if test="Language">
									<urn18:Language schemeAgencyIdentifier="5">
										<xsl:value-of select="Language" />
									</urn18:Language>
								</xsl:if>
							</urn18:MeteringPointAddress>
						</xsl:for-each>
						<xsl:if test=".//*[_type='E58_ACP']/Latitude or .//*[_type='E58_ACP']/Longitude">
							<urn18:MPPositionMeteringPointGeographicalCoordinate>
								<xsl:if test=".//*[_type='E58_ACP']/Latitude">
									<urn18:Latitude>
										<xsl:value-of select=".//*[_type='E58_ACP']/Latitude" />
									</urn18:Latitude>
								</xsl:if>
								<xsl:if test=".//*[_type='E58_ACP']/Longitude">
									<urn18:Longitude>
										<xsl:value-of select=".//*[_type='E58_ACP']/Longitude" />
									</urn18:Longitude>
								</xsl:if>
							</urn18:MPPositionMeteringPointGeographicalCoordinate>
						</xsl:if>
						<urn18:MPDetailMeteringPointCharacteristic>
							<xsl:if test=".//*[_type='E58_ACP']/IsRemotelyReadable">
								<urn18:RemoteReadable>
									<xsl:choose>
									   <xsl:when test=".//*[_type='E58_ACP']/IsRemotelyReadable='false'">0</xsl:when>
									   <xsl:otherwise>1</xsl:otherwise>
								   </xsl:choose>
								</urn18:RemoteReadable>
							</xsl:if>
							<xsl:if test=".//*[_type='E58_ACP']/MeteringMethod">
								<urn18:MeteringMethod>
									<xsl:value-of select=".//*[_type='E58_ACP']/MeteringMethod" />
								</urn18:MeteringMethod>
							</xsl:if>
							<xsl:if test=".//*[_type='E58_ACP']/MeteringTimeStep">
								<urn18:ResolutionDuration>
									<xsl:value-of select=".//*[_type='E58_ACP']/MeteringTimeStep" />
								</urn18:ResolutionDuration>
							</xsl:if>
							<xsl:if test=".//*[_type='E58_ACP']/UserGroup">
								<urn18:UserGroup>
									<xsl:value-of select=".//*[_type='E58_ACP']/UserGroup" />
								</urn18:UserGroup>
							</xsl:if>
							<xsl:if test=".//*[_type='E58_ACP']/IsHeatingDependentOnElectricity">
								<urn18:HeatingMethodType>
									<xsl:choose>
									   <xsl:when test=".//*[_type='E58_ACP']/IsHeatingDependentOnElectricity='false'">0</xsl:when>
									   <xsl:otherwise>1</xsl:otherwise>
								   </xsl:choose>
								</urn18:HeatingMethodType>
							</xsl:if>
							<xsl:if test=".//*[_type='E58_ACP']/FuseSize">
								<urn18:FuseSize>
									<xsl:value-of select=".//*[_type='E58_ACP']/FuseSize" />
								</urn18:FuseSize>
							</xsl:if>
							<xsl:if test=".//*[_type='E58_ACP']/ElectricPower">
								<urn18:ContractedConnectionCapacity>
									<xsl:value-of select=".//*[_type='E58_ACP']/ElectricPower" />
								</urn18:ContractedConnectionCapacity>
							</xsl:if>
							<xsl:if test=".//*[_type='E58_AGR']/TaxCategory and //*[_type='E58_AGR']/TaxCategory!=''">								
								<urn18:TaxCategory>
									<xsl:value-of select=".//*[_type='E58_AGR']/TaxCategory" />
								</urn18:TaxCategory>
							</xsl:if>																
							<xsl:if test=".//*[_type='E58_EYU']/EstimatedYearlyUsage1">
								<urn18:EstimatedMetrics>
									<urn18:MeterTimeFrame>E11</urn18:MeterTimeFrame>
									<urn18:Total>
										<xsl:value-of select=".//*[_type='E58_EYU']/EstimatedYearlyUsage1" />
									</urn18:Total>
								</urn18:EstimatedMetrics>
							</xsl:if>							
							<xsl:if test=".//*[_type='E58_EYU']/EstimatedYearlyUsage2">
								<urn18:EstimatedMetrics>
									<urn18:MeterTimeFrame>E10</urn18:MeterTimeFrame>
									<urn18:Total>
										<xsl:value-of select=".//*[_type='E58_EYU']/EstimatedYearlyUsage2" />
									</urn18:Total>
								</urn18:EstimatedMetrics>
							</xsl:if>							
						</urn18:MPDetailMeteringPointCharacteristic>
						<!-- Loop for Controlled Load -->
						<xsl:for-each select=".//*[_type='E58_CTL']">
							<urn18:LoadUnit>
								<xsl:if test="ControlledLoadIdentification">
									<urn18:Identification>
										<xsl:value-of select="ControlledLoadIdentification" />
									</urn18:Identification>
								</xsl:if>
								<xsl:if test="ControlledLoadName">
									<urn18:Name>
										<xsl:value-of select="ControlledLoadName" />
									</urn18:Name>
								</xsl:if>
								<xsl:if test="Description">
									<urn18:Description>
										<xsl:value-of select="Description" />
									</urn18:Description>
								</xsl:if>
								<xsl:if test="Timing">
									<urn18:Timing>
										<xsl:value-of select="Timing" />
									</urn18:Timing>
								</xsl:if>
								<xsl:if test="ControlLimits">
									<urn18:Limits>
										<xsl:value-of select="ControlLimits" />
									</urn18:Limits>
								</xsl:if>
								<xsl:if test="MaximumPower and MaximumPower!=''">
									<urn18:MaxPower>
										<xsl:value-of select="MaximumPower" />
									</urn18:MaxPower>
								</xsl:if>
								<xsl:if test="MaximumPowerUnit and MaximumPowerUnit!=''">
									<urn18:UnitType>
										<xsl:value-of select="MaximumPowerUnit" />
									</urn18:UnitType>
								</xsl:if>
							</urn18:LoadUnit>
						</xsl:for-each>
						<!-- Loop for Storage Device -->
						<xsl:for-each select=".//*[_type='E58_SDV']">
							<urn18:StorageUnit>
								<xsl:if test="StorageDeviceIdentification">
									<urn18:Identification>
										<xsl:value-of select="StorageDeviceIdentification" />
									</urn18:Identification>
								</xsl:if>
								<xsl:if test="StorageDeviceName">
									<urn18:Name>
										<xsl:value-of select="StorageDeviceName" />
									</urn18:Name>
								</xsl:if>
								<xsl:if test="StorageDeviceType">
									<urn18:Type listAgencyIdentifier="NFI">
										<xsl:value-of select="StorageDeviceType" />
									</urn18:Type>
								</xsl:if>
								<xsl:if test="Capacity and Capacity!=''">
									<urn18:Capacity>
										<xsl:value-of select="Capacity" />
									</urn18:Capacity>
								</xsl:if>
								<xsl:if test="CapacityUnit and CapacityUnit!=''">
									<urn18:UnitType>
										<xsl:value-of select="CapacityUnit" />
									</urn18:UnitType>
								</xsl:if>
								<xsl:if test="MaximumPower and MaximumPower!=''">
									<urn18:MaxCapacity>
										<xsl:value-of select="MaximumPower" />
									</urn18:MaxCapacity>
								</xsl:if>
								<xsl:if test="MaximumPowerUnit and MaximumPowerUnit!=''">
									<urn18:MaxCapacityUnitType>
										<xsl:value-of select="MaximumPowerUnit" />
									</urn18:MaxCapacityUnitType>
								</xsl:if>
							</urn18:StorageUnit>
						</xsl:for-each>
						<!-- Loop for Production Device -->
						<xsl:for-each select=".//*[_type='E58_PDV']">
							<urn18:ProductionUnit>
								<xsl:if test="ProductionDeviceIdentification">
									<urn18:Identification>
										<xsl:value-of select="ProductionDeviceIdentification" />
									</urn18:Identification>
								</xsl:if>
								<xsl:if test="ProductionDeviceName">
									<urn18:Name>
										<xsl:value-of select="ProductionDeviceName" />
									</urn18:Name>
								</xsl:if>
								<xsl:if test="ProductionType">
									<urn18:Type>
										<xsl:value-of select="ProductionType" />
									</urn18:Type>
								</xsl:if>
								<xsl:if test="MaximumPower and MaximumPower!=''">
									<urn18:MaxCapacity>
										<xsl:value-of select="MaximumPower" />
									</urn18:MaxCapacity>
								</xsl:if>
								<xsl:if test="MaximumPowerUnit and MaximumPowerUnit!=''">
									<urn18:UnitType>
										<xsl:value-of select="MaximumPowerUnit" />
									</urn18:UnitType>
								</xsl:if>
							</urn18:ProductionUnit>
						</xsl:for-each>
					</urn18:MeteringPointUsedDomainLocation>
				</urn17:Transaction>
			</urn17:MasterDataMPEvent>
		</urn17:MasterDataMPEventMessage>
	</xsl:template>
</xsl:stylesheet>