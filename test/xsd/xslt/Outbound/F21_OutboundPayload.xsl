<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:query:F21_ResponseMPInfo:v1" 
    xmlns:urn18="urn:fi:Datahub:mif:query:F21_ResponseMPInfo:elements:v1">
	<xsl:import href="AcknowledgementTransaction.xsl" />		
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">

	<!-- In case of reject or Accept transaction import the AcknowledgementTransaction XSLT otherwise perform the F20 XSLT -->
	<xsl:choose>
		<xsl:when test=".//*[_type='REJECT_TRANSACTION'] or .//*[_type='ACCEPT_TRANSACTION']">
				<xsl:apply-imports/>
		</xsl:when>
	    <xsl:otherwise>
			<urn17:ResponseMPInfoMessage>
				<urn17:ResponseMPInfo>
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
						<xsl:if test="./*/*/ExternalTransactionType">
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
						<xsl:if test=".//*[_type='F21_ACP']/StartOfOccurrence">
							<urn18:StartOfOccurrence>
								<xsl:value-of select=".//*[_type='F21_ACP']/StartOfOccurrence" />
							</urn18:StartOfOccurrence>
						</xsl:if>

						<urn18:MeteringPointUsedDomainLocation>
								<urn18:Identification schemeAgencyIdentifier="9">
									<xsl:value-of select=".//*[_type='F21_ACP']/MeteringPointEAN" />
								</urn18:Identification>
								<urn18:PhysicalStatusType listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F21_ACP']/MeteringPointStatus" />
								</urn18:PhysicalStatusType>
								<urn18:MeteringPointType listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F21_ACP']/AccountingPointType" />
								</urn18:MeteringPointType>
								<urn18:MeteringPointSubType listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F21_ACP']/AccountingPointSubtype" />
								</urn18:MeteringPointSubType>
								<urn18:RemoteConnectable>
									<xsl:choose>
									   <xsl:when test=".//*[_type='F21_ACP']/IsRemotelyConnectable='true'">1</xsl:when>
									   <xsl:otherwise>0</xsl:otherwise>
								   </xsl:choose>
								</urn18:RemoteConnectable>
								<xsl:if test=".//*[_type='F21_ACP']/MeteringTimeDivision">
									<urn18:MeteringTimeDivision>
										<xsl:value-of select=".//*[_type='F21_ACP']/MeteringTimeDivision" />
									</urn18:MeteringTimeDivision>
								</xsl:if>
								<xsl:if test=".//*[_type='F21_ACP']/MeterNumber">							
									<urn18:MeterIdentification>
										<xsl:value-of select=".//*[_type='F21_ACP']/MeterNumber" />
									</urn18:MeterIdentification>
								</xsl:if>
								<xsl:if test=".//*[_type='F21_ACP']/RelatedMeteringPointEAN">							
									<urn18:RelatedMeteringPoint schemeAgencyIdentifier="9">
										<xsl:value-of select=".//*[_type='F21_ACP']/RelatedMeteringPointEAN" />
									</urn18:RelatedMeteringPoint>
								</xsl:if>
								<xsl:if test=".//*[_type='F21_ACP']/EnergyCommunityIdentifier">							
									<urn18:CommunityIdentification>
										<xsl:value-of select=".//*[_type='F21_ACP']/EnergyCommunityIdentifier" />
									</urn18:CommunityIdentification>
								</xsl:if>								
								<xsl:if test=".//*[_type='F21_ACP']/EnergyCommunityName">							
									<urn18:CommunityName>
										<xsl:value-of select=".//*[_type='F21_ACP']/EnergyCommunityName" />
									</urn18:CommunityName>
								</xsl:if>								
								<xsl:if test=".//*[_type='F21_ACP']/IsNettingApplied">							
									<urn18:Netting>
										<xsl:choose>
									   <xsl:when test=".//*[_type='F21_ACP']/IsNettingApplied='true'">1</xsl:when>
									   <xsl:otherwise>0</xsl:otherwise>
								   </xsl:choose>
									</urn18:Netting>
								</xsl:if>								

								<!-- F20_MGA -->
								<urn18:MeteringGridAreaUsedDomainLocation>
									<urn18:Identification schemeAgencyIdentifier="305">
										<xsl:value-of select=".//*[_type='F21_MGA']/MeteringGridAreaCode" />
									</urn18:Identification>
								</urn18:MeteringGridAreaUsedDomainLocation>

								<!-- F21_MPA -->

								<xsl:for-each select=".//*[_type='F21_MPA']">
									<urn18:MeteringPointAddress>
										<urn18:Type listAgencyIdentifier="NFI">
											<xsl:value-of select="AddressType" />
										</urn18:Type>
										<urn18:StreetName>
											<xsl:value-of select="StreetName" />
										</urn18:StreetName>
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
										<urn18:Postcode>
											<xsl:value-of select="PostalCode" />
										</urn18:Postcode>
										<urn18:CityName>
											<xsl:value-of select="PostOffice" />
										</urn18:CityName>
										<urn18:CountryCode schemeAgencyIdentifier="5">
											<xsl:value-of select="CountryCode" />
										</urn18:CountryCode>
										<xsl:if test="AddressNote">							
											<urn18:AddressFreeForm>
												<xsl:value-of select="AddressNote" />
											</urn18:AddressFreeForm>
										</xsl:if>
										<urn18:Language schemeAgencyIdentifier="5">
											<xsl:value-of select="Language" />
										</urn18:Language>
									</urn18:MeteringPointAddress>
								</xsl:for-each>

								<!-- F21_ACP -->
								<xsl:if test=".//*[_type='F21_ACP']/Latitude">
									<urn18:MPPositionMeteringPointGeographicalCoordinate>							
										<urn18:Latitude>
											<xsl:value-of select=".//*[_type='F21_ACP']/Latitude" />
										</urn18:Latitude>						
										<urn18:Longitude>
											<xsl:value-of select=".//*[_type='F21_ACP']/Longitude" />
										</urn18:Longitude>
									</urn18:MPPositionMeteringPointGeographicalCoordinate>
								</xsl:if>
								
								<!-- F21_MGA -->
								<xsl:if test=".//*[_type='F21_ACP']/IsRemotelyReadable or .//*[_type='F21_ACP']/MeteringMethod or .//*[_type='F21_ACP']/UserGroup or .//*[_type='F21_ACP']/IsHeatingDependentOnElectricity or .//*[_type='F21_ACP']/FuseSize or .//*[_type='F21_ACP']/ElectricPower or .//*[_type='F21_ACP']/IsReactiveEnergyTimeSeriesAvailable or .//*[_type='F21_EYU']/EstimatedYearlyUsage1 or .//*[_type='F21_EYU']/EstimatedYearlyUsage2">
									<urn18:MPDetailMeteringPointCharacteristic>
										<xsl:if test=".//*[_type='F21_ACP']/IsRemotelyReadable">
											<urn18:RemoteReadable>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_ACP']/IsRemotelyReadable='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:RemoteReadable>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_ACP']/MeteringMethod">
											<urn18:MeteringMethod>
												<xsl:value-of select=".//*[_type='F21_ACP']/MeteringMethod" />
											</urn18:MeteringMethod>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_ACP']/MeteringTimeStep">
											<urn18:ResolutionDuration>
												<xsl:value-of select=".//*[_type='F21_ACP']/MeteringTimeStep" />
											</urn18:ResolutionDuration>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_ACP']/UserGroup">
											<urn18:UserGroup>
												<xsl:value-of select=".//*[_type='F21_ACP']/UserGroup" />
											</urn18:UserGroup>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_ACP']/IsHeatingDependentOnElectricity">
											<urn18:HeatingMethodType>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_ACP']/IsHeatingDependentOnElectricity='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:HeatingMethodType>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_ACP']/FuseSize">
											<urn18:FuseSize>
												<xsl:value-of select=".//*[_type='F21_ACP']/FuseSize" />
											</urn18:FuseSize>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_ACP']/ElectricPower">
											<urn18:ContractedConnectionCapacity>
												<xsl:value-of select=".//*[_type='F21_ACP']/ElectricPower" />
											</urn18:ContractedConnectionCapacity>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_ACP']/IsReactiveEnergyTimeSeriesAvailable">
											<urn18:ReactiveEnergy>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_ACP']/IsReactiveEnergyTimeSeriesAvailable='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:ReactiveEnergy>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_EYU']/EstimatedYearlyUsage1">
											<urn18:EstimatedMetrics>
												<urn18:MeterTimeFrame>E11</urn18:MeterTimeFrame>
												<urn18:Total>
													<xsl:value-of select=".//*[_type='F21_EYU']/EstimatedYearlyUsage1" />
												</urn18:Total>
											</urn18:EstimatedMetrics>
										</xsl:if>							
										<xsl:if test=".//*[_type='F21_EYU']/EstimatedYearlyUsage2">
											<urn18:EstimatedMetrics>
												<urn18:MeterTimeFrame>E10</urn18:MeterTimeFrame>
												<urn18:Total>
													<xsl:value-of select=".//*[_type='F21_EYU']/EstimatedYearlyUsage2" />
												</urn18:Total>
											</urn18:EstimatedMetrics>
										</xsl:if>							
									</urn18:MPDetailMeteringPointCharacteristic>
								</xsl:if>									
								<!-- Loop for Controlled Load -->
								<xsl:for-each select=".//*[_type='F21_CTL']">
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
										<xsl:if test="Timings">
											<urn18:Timing>
												<xsl:value-of select="Timings" />
											</urn18:Timing>
										</xsl:if>
										<xsl:if test="ControlLimits">
											<urn18:Limits>
												<xsl:value-of select="ControlLimits" />
											</urn18:Limits>
										</xsl:if>
										<xsl:if test="MaximumPower">
											<urn18:MaxPower>
												<xsl:value-of select="MaximumPower" />
											</urn18:MaxPower>
										</xsl:if>
										<xsl:if test="MaximumPowerUnit">
											<urn18:UnitType>
												<xsl:value-of select="MaximumPowerUnit" />
											</urn18:UnitType>
										</xsl:if>
									</urn18:LoadUnit>
								</xsl:for-each>
								<!-- Loop for Storage Device -->
								<xsl:for-each select=".//*[_type='F21_SDV']">
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
										<xsl:if test="Capacity">
											<urn18:Capacity>
												<xsl:value-of select="Capacity" />
											</urn18:Capacity>
										</xsl:if>
										<xsl:if test="CapacityUnit">
											<urn18:UnitType>
												<xsl:value-of select="CapacityUnit" />
											</urn18:UnitType>
										</xsl:if>
										<xsl:if test="MaximumPower">
											<urn18:MaxCapacity>
												<xsl:value-of select="MaximumPower" />
											</urn18:MaxCapacity>
										</xsl:if>
										<xsl:if test="MaximumPowerUnit">
											<urn18:MaxCapacityUnitType>
												<xsl:value-of select="MaximumPowerUnit" />
											</urn18:MaxCapacityUnitType>
										</xsl:if>
									</urn18:StorageUnit>
								</xsl:for-each>
								<!-- Loop for Production Device -->
								<xsl:for-each select=".//*[_type='F21_PDV']">
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
										<xsl:if test="MaximumPower">
											<urn18:MaxCapacity>
												<xsl:value-of select="MaximumPower" />
											</urn18:MaxCapacity>
										</xsl:if>
										<xsl:if test="MaximumPowerUnit">
											<urn18:UnitType>
												<xsl:value-of select="MaximumPowerUnit" />
											</urn18:UnitType>
										</xsl:if>
									</urn18:ProductionUnit>
								</xsl:for-each>

								
								
						        <!-- GridAgreement -->							
								<xsl:if test=".//*[_type='F21_AGR_GRD']">									
									<urn18:TransferContract>
										<xsl:if test=".//*[_type='F21_AGR_GRD']/CustomerNote">
											<urn18:CustomerNote>
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/CustomerNote" />
											</urn18:CustomerNote>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/ContactMethod">
											<urn18:ContactType listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/ContactMethod" />
											</urn18:ContactType>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/IsInterruptionCritical">
											<urn18:Priority>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_AGR_GRD']/IsInterruptionCritical='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:Priority>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_AGR_GRD']/InvoicingChannel">
											<urn18:InvoicingChannel listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/InvoicingChannel" />
											</urn18:InvoicingChannel>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/InvoicingMethod">
											<urn18:InvoicingMethod listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/InvoicingMethod" />
											</urn18:InvoicingMethod>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/ReasonForAgreementStart">
											<urn18:ContractReason listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/ReasonForAgreementStart" />
											</urn18:ContractReason>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/AgreementStartDate">
											<urn18:ContractStart>
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/AgreementStartDate" />
											</urn18:ContractStart>
										</xsl:if>			
										<xsl:if test=".//*[_type='F21_AGR_GRD']/ReasonForAgreementEnd">
											<urn18:Reason listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/ReasonForAgreementEnd" />
											</urn18:Reason>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/AgreementEndDate">
											<urn18:EndOfOccurrence>
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/AgreementEndDate" />
											</urn18:EndOfOccurrence>
										</xsl:if>			
										<xsl:if test=".//*[_type='F21_AGR_GRD']/AgreementType">
											<urn18:ContractType>
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/AgreementType" />
											</urn18:ContractType>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/AgreementIdentification">
											<urn18:Identification>
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/AgreementIdentification" />
											</urn18:Identification>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_GRD']/IsDeliveryAgreement">
											<urn18:DeliveryContract>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_AGR_GRD']/IsDeliveryAgreement='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:DeliveryContract>
										</xsl:if>			
										<xsl:if test=".//*[_type='F21_AGR_GRD']/TaxCategory">
											<urn18:TaxCategory>
												<xsl:value-of select=".//*[_type='F21_AGR_GRD']/TaxCategory" />
											</urn18:TaxCategory>
										</xsl:if>															
										
										<!-- Loop for GridProduct -->
										<xsl:for-each select=".//*[_type='F21_PRD_GRD']">
											<urn18:GridProductData>
												<urn18:TransferContractCode>
													<xsl:value-of select="ProductCode" />
												</urn18:TransferContractCode>
											</urn18:GridProductData>											
										</xsl:for-each>
									</urn18:TransferContract>
								</xsl:if>
								
						        <!-- SalesAgreement -->							
								<xsl:if test=".//*[_type='F21_AGR_SLS']">									
									<urn18:MasterDataContract>
										<xsl:if test=".//*[_type='F21_AGR_SLS']/CustomerNote">
											<urn18:CustomerNote>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/CustomerNote" />
											</urn18:CustomerNote>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/ContactMethod">
											<urn18:ContactType listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/ContactMethod" />
											</urn18:ContactType>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/IsInterruptionCritical">
											<urn18:Priority>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_AGR_SLS']/IsInterruptionCritical='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:Priority>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_AGR_SLS']/InvoicingChannel">
											<urn18:InvoicingChannel listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/InvoicingChannel" />
											</urn18:InvoicingChannel>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/InvoicingMethod">
											<urn18:InvoicingMethod listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/InvoicingMethod" />
											</urn18:InvoicingMethod>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/IsFixedTermAgreement">
											<urn18:TimeLimited>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_AGR_SLS']/IsFixedTermAgreement='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:TimeLimited>
										</xsl:if>									
										<xsl:if test=".//*[_type='F21_AGR_SLS']/FixedTermStartDate">
											<urn18:FixedContractStart>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/FixedTermStartDate" />
											</urn18:FixedContractStart>
										</xsl:if>																							
										<xsl:if test=".//*[_type='F21_AGR_SLS']/FixedTermEndDate">
											<urn18:FixedContractEnd>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/FixedTermEndDate" />
											</urn18:FixedContractEnd>
										</xsl:if>														
										<xsl:if test=".//*[_type='F21_AGR_SLS']/SpecialTerminationPeriod">
											<urn18:NoticeDays>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/SpecialTerminationPeriod" />
											</urn18:NoticeDays>
										</xsl:if>																									
										<xsl:if test=".//*[_type='F21_AGR_SLS']/IsSpecialTerminationAgreement">
											<urn18:NoticeBasis>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_AGR_SLS']/IsSpecialTerminationAgreement='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:NoticeBasis>
										</xsl:if>									
										<xsl:if test=".//*[_type='F21_AGR_SLS']/ReasonForAgreementStart">
											<urn18:ContractReason listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/ReasonForAgreementStart" />
											</urn18:ContractReason>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/AgreementStartDate">
											<urn18:ContractStart>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/AgreementStartDate" />
											</urn18:ContractStart>
										</xsl:if>			
										<xsl:if test=".//*[_type='F21_AGR_SLS']/ReasonForAgreementEnd">
											<urn18:Reason listAgencyIdentifier="NFI">
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/ReasonForAgreementEnd" />
											</urn18:Reason>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/AgreementEndDate">
											<urn18:EndOfOccurrence>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/AgreementEndDate" />
											</urn18:EndOfOccurrence>
										</xsl:if>			
										<xsl:if test=".//*[_type='F21_AGR_SLS']/AgreementType">
											<urn18:ContractType>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/AgreementType" />
											</urn18:ContractType>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/AgreementIdentification">
											<urn18:Identification>
												<xsl:value-of select=".//*[_type='F21_AGR_SLS']/AgreementIdentification" />
											</urn18:Identification>
										</xsl:if>															
										<xsl:if test=".//*[_type='F21_AGR_SLS']/IsDeliveryAgreement">
											<urn18:DeliveryContract>
												<xsl:choose>
												   <xsl:when test=".//*[_type='F21_AGR_SLS']/IsDeliveryAgreement='true'">1</xsl:when>
												   <xsl:otherwise>0</xsl:otherwise>
											   </xsl:choose>
											</urn18:DeliveryContract>
										</xsl:if>			
										<!-- NoticePeriod -->							
										<xsl:if test=".//*[_type='F21_AGR_SLS']/TerminationPeriodStartDate or .//*[_type='F21_AGR_SLS']/TerminationPeriodEndDate">
											<urn18:NoticePeriod>
												<xsl:if test=".//*[_type='F21_AGR_SLS']/TerminationPeriodStartDate">
													<urn18:NoticeStart>
														<xsl:value-of select=".//*[_type='F21_AGR_SLS']/TerminationPeriodStartDate" />
													</urn18:NoticeStart>
												</xsl:if>															
												<xsl:if test=".//*[_type='F21_AGR_SLS']/TerminationPeriodEndDate">
													<urn18:NoticeEnd>
														<xsl:value-of select=".//*[_type='F21_AGR_SLS']/TerminationPeriodEndDate" />
													</urn18:NoticeEnd>
												</xsl:if>															
											</urn18:NoticePeriod>
										</xsl:if>													
										<!-- Loop for SalesProduct -->
										<xsl:for-each select=".//*[_type='F21_PRD_SLS']">
											<urn18:SalesProduct>
												<urn18:ProductCode>
													<xsl:value-of select="ProductCode" />
												</urn18:ProductCode>
											</urn18:SalesProduct>											
										</xsl:for-each>
										<!-- BalanceSupplierInvolvedEnergyParty -->							
										<xsl:if test=".//*[_type='F21_AGR_SLS']/OrganisationIdentifier">							
											<urn18:BalanceSupplierInvolvedEnergyParty>											
												<urn18:Identification schemeAgencyIdentifier="9">
													<xsl:value-of select=".//*[_type='F21_AGR_SLS']/OrganisationIdentifier" />
												</urn18:Identification>
											</urn18:BalanceSupplierInvolvedEnergyParty>																						
										</xsl:if>
									</urn18:MasterDataContract>
								</xsl:if>								

						        <!-- ContractSituation -->							
								<xsl:if test=".//*[_type='F21_AGR_SIT']">									
									<urn18:ContractSituation>								
										<xsl:if test=".//*[_type='F21_AGR_SIT']/StartDateSalesAgreement">
											<urn18:NextContractStart>
												<xsl:value-of select=".//*[_type='F21_AGR_SIT']/StartDateSalesAgreement" />
											</urn18:NextContractStart>
										</xsl:if>			
										<urn18:EnergyContractByCustomer listAgencyIdentifier="NFI">
											<xsl:value-of select=".//*[_type='F21_AGR_SIT']/SalesAgreementCustomer" />
										</urn18:EnergyContractByCustomer>
										<!-- Possible that the field is not available, the default false -->							
										<urn18:TimeLimited>
											<xsl:choose>
											   <xsl:when test=".//*[_type='F21_AGD_SIT']/IsFixedTermAgreement='true'">1</xsl:when>
											   <xsl:otherwise>0</xsl:otherwise>
										   </xsl:choose>
										</urn18:TimeLimited>
										<xsl:if test=".//*[_type='F21_AGD_SIT']/FixedTermEndDate">										
											<urn18:FixedContractEnd>
												<xsl:value-of select=".//*[_type='F21_AGD_SIT']/FixedTermEndDate" />
											</urn18:FixedContractEnd>									
										</xsl:if>
										<xsl:if test=".//*[_type='F21_AGR_SIT']/EndDateValidSalesAgreement">										
											<urn18:NextContractEnd>
												<xsl:value-of select=".//*[_type='F21_AGR_SIT']/EndDateValidSalesAgreement" />
											</urn18:NextContractEnd>									
										</xsl:if>											
										<!-- Possible that the field is not available, the default false -->																	
										<urn18:NoticeBasis>
											<xsl:choose>
											   <xsl:when test=".//*[_type='F21_AGD_SIT']/IsSpecialTerminationAgreement='true'">1</xsl:when>
											   <xsl:otherwise>0</xsl:otherwise>
										   </xsl:choose>
										</urn18:NoticeBasis>
										<xsl:if test=".//*[_type='F21_AGD_SIT']/SpecialTerminationPeriod">
											<urn18:NoticeDays>
												<xsl:value-of select=".//*[_type='F21_AGD_SIT']/SpecialTerminationPeriod" />
											</urn18:NoticeDays>
										</xsl:if>																									
										<!-- NoticePeriod -->							
										<xsl:if test=".//*[_type='F21_AGD_SIT']/TerminationPeriodStartDate or .//*[_type='F21_AGD_SIT']/TerminationPeriodEndDate">
											<urn18:ContractSituationNoticePeriod>
												<xsl:if test=".//*[_type='F21_AGD_SIT']/TerminationPeriodStartDate">
													<urn18:NoticeStart>
														<xsl:value-of select=".//*[_type='F21_AGD_SIT']/TerminationPeriodStartDate" />
													</urn18:NoticeStart>
												</xsl:if>															
												<xsl:if test=".//*[_type='F21_AGD_SIT']/TerminationPeriodEndDate">
													<urn18:NoticeEnd>
														<xsl:value-of select=".//*[_type='F21_AGD_SIT']/TerminationPeriodEndDate" />
													</urn18:NoticeEnd>
												</xsl:if>															
											</urn18:ContractSituationNoticePeriod>
										</xsl:if>													
										<urn18:TransferContractByCustomer listAgencyIdentifier="NFI">
											<xsl:value-of select=".//*[_type='F21_AGR_SIT']/GridAgreementCustomer" />
										</urn18:TransferContractByCustomer>
									</urn18:ContractSituation>																	
								</xsl:if>								
						</urn18:MeteringPointUsedDomainLocation>								
						<!-- Loop for Agreement Customers -->							
						<xsl:for-each select=".//*[_type='F21_CUS']">
							<urn18:ConsumerInvolvedCustomerParty>
								<urn18:CustomerSubType listAgencyIdentifier="NFI">
									<xsl:value-of select="CustomerSubtype" />
								</urn18:CustomerSubType>
								<urn18:Identification schemeAgencyIdentifier="260">
									<xsl:value-of select="CustomerIdentification" />
								</urn18:Identification>
								<urn18:IdentificationType  listAgencyIdentifier="NFI">
									<xsl:value-of select="CustomerIdentificationType" />
								</urn18:IdentificationType>
								<urn18:CustomerType listAgencyIdentifier="NFI">
									<xsl:value-of select="CustomerType" />
								</urn18:CustomerType>
								<urn18:InformationRestriction>
									<xsl:choose>
										<xsl:when test="IsInformationRestricted='true'">1</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>			
								</urn18:InformationRestriction>
								<urn18:Language schemeAgencyIdentifier="5">
									<xsl:value-of select="Language" />
								</urn18:Language>
								<xsl:if test="AdditionalIdentification">							
									<urn18:AdditionalCode>
										<xsl:value-of select="AdditionalIdentification" />
									</urn18:AdditionalCode>
								</xsl:if>						
								<xsl:if test="CompanyName">							
									<urn18:Name>
										<xsl:value-of select="CompanyName" />
									</urn18:Name>
								</xsl:if>								
								<xsl:if test="GivenName">							
									<urn18:GivenName>
										<xsl:value-of select="GivenName" />
									</urn18:GivenName>
								</xsl:if>
								<xsl:if test="MiddleNames">							
									<urn18:MiddleName>
										<xsl:value-of select="MiddleNames" />
									</urn18:MiddleName>
								</xsl:if>
								<xsl:if test="FamilyName">							
									<urn18:FamilyName>
										<xsl:value-of select="FamilyName" />
									</urn18:FamilyName>
								</xsl:if>

								<xsl:if test="DateOfBirth">							
									<urn18:DateOfBirth>
										<xsl:value-of select="DateOfBirth" />
									</urn18:DateOfBirth>
								</xsl:if>


								<xsl:if test="EmailAddress">
									<urn18:Communication>
										<xsl:if test="EmailAddress">
											<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD02</urn18:CommunicationChannel>
											<urn18:CompleteNumber>
												<xsl:value-of select="EmailAddress" />
											</urn18:CompleteNumber>
										</xsl:if>
									</urn18:Communication>
								</xsl:if>
								<xsl:if test="TelephoneNumber">
									<urn18:Communication>
										<xsl:if test="TelephoneNumber">
											<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD01</urn18:CommunicationChannel>
											<urn18:CompleteNumber>
												<xsl:value-of select="TelephoneNumber" />
											</urn18:CompleteNumber>
										</xsl:if>
									</urn18:Communication>
								</xsl:if>

								<xsl:if test=".//*[_type='F21_CPA']">	
									<urn18:ConsumerInvolvedCustomerAddress>
										<xsl:if test=".//*[_type='F21_CPA']/AddressNote">							
											<urn18:CareOf>
												<xsl:value-of select=".//*[_type='F21_CPA']/AddressNote" />
											</urn18:CareOf>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_CPA']/StreetName">							
											<urn18:StreetName>
												<xsl:value-of select=".//*[_type='F21_CPA']/StreetName" />
											</urn18:StreetName>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_CPA']/BuildingNumber">							
											<urn18:BuildingNumber>
												<xsl:value-of select=".//*[_type='F21_CPA']/BuildingNumber" />
											</urn18:BuildingNumber>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_CPA']/StairwellIdentification">							
											<urn18:FloorIdentification>
												<xsl:value-of select=".//*[_type='F21_CPA']/StairwellIdentification" />
											</urn18:FloorIdentification>
										</xsl:if>
										<xsl:if test=".//*[_type='F21_CPA']/Apartment">							
											<urn18:RoomIdentification>
												<xsl:value-of select=".//*[_type='F21_CPA']/Apartment" />
											</urn18:RoomIdentification>
										</xsl:if>
										<urn18:Postcode>
											<xsl:value-of select=".//*[_type='F21_CPA']/PostalCode" />
										</urn18:Postcode>
										<xsl:if test=".//*[_type='F21_CPA']/POBox">							
											<urn18:Pobox>
												<xsl:value-of select=".//*[_type='F21_CPA']/POBox" />
											</urn18:Pobox>
										</xsl:if>
										<urn18:CityName>
											<xsl:value-of select=".//*[_type='F21_CPA']/PostOffice" />
										</urn18:CityName>
										<urn18:CountryCode schemeAgencyIdentifier="5">
											<xsl:value-of select=".//*[_type='F21_CPA']/CountryCode" />
										</urn18:CountryCode>
									</urn18:ConsumerInvolvedCustomerAddress>								
								</xsl:if>
							</urn18:ConsumerInvolvedCustomerParty>									
						</xsl:for-each>							
					</urn17:Transaction>
				</urn17:ResponseMPInfo>
			</urn17:ResponseMPInfoMessage>
		</xsl:otherwise>
	</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>