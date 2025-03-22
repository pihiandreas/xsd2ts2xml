<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:query:F20_ResponseMPList:v1" 
    xmlns:urn18="urn:fi:Datahub:mif:query:F20_ResponseMPList:elements:v1">
	<xsl:import href="AcknowledgementTransaction.xsl" />		
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">

	<!-- In case of reject or Accept transaction import the AcknowledgementTransaction XSLT otherwise perform the F20 XSLT -->
	<xsl:choose>
		<xsl:when test=".//*[_type='REJECT_TRANSACTION'] or .//*[_type='ACCEPT_TRANSACTION']">
				<xsl:apply-imports/>
		</xsl:when>
	    <xsl:otherwise>
			<urn17:ResponseMPListMessage>
				<urn17:ResponseMPList>
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
						<!-- Loop for Accountin Points -->

						<xsl:for-each select=".//*[_type='F20_ACP']">
							<urn18:MeteringPointList>
								<!-- F20_ACP -->
								<urn18:Identification schemeAgencyIdentifier="9">
									<xsl:value-of select="MeteringPointEAN" />
								</urn18:Identification>
								<urn18:PhysicalStatusType listAgencyIdentifier="NFI">
									<xsl:value-of select="MeteringPointStatus" />
								</urn18:PhysicalStatusType>
								<urn18:RemoteConnectable>
									<xsl:choose>
									   <xsl:when test="IsRemotelyConnectable='false'">0</xsl:when>
									   <xsl:otherwise>1</xsl:otherwise>
								   </xsl:choose>
								</urn18:RemoteConnectable>
								<urn18:MeteringPointType listAgencyIdentifier="NFI">
									<xsl:value-of select="AccountingPointType" />
								</urn18:MeteringPointType>
								<urn18:MeteringPointSubType listAgencyIdentifier="NFI">
									<xsl:value-of select="AccountingPointSubtype" />
								</urn18:MeteringPointSubType>
								<xsl:if test="MeteringTimeDivision">
									<urn18:MeteringTimeDivision>
										<xsl:value-of select="MeteringTimeDivision" />
									</urn18:MeteringTimeDivision>
								</xsl:if>
								<xsl:if test="MeterNumber">							
									<urn18:MeterIdentification>
										<xsl:value-of select="MeterNumber" />
									</urn18:MeterIdentification>
								</xsl:if>
								<xsl:if test="RelatedMeteringPointEAN">							
									<urn18:RelatedMeteringPoint schemeAgencyIdentifier="9">
										<xsl:value-of select="RelatedMeteringPointEAN" />
									</urn18:RelatedMeteringPoint>
								</xsl:if>
								<xsl:if test="EnergyCommunityIdentifier">							
									<urn18:CommunityIdentification>
										<xsl:value-of select="EnergyCommunityIdentifier" />
									</urn18:CommunityIdentification>
								</xsl:if>								
								<xsl:if test="EnergyCommunityName">							
									<urn18:CommunityName>
										<xsl:value-of select="EnergyCommunityName" />
									</urn18:CommunityName>
								</xsl:if>																
								<xsl:if test="IsNettingApplied">							
									<urn18:Netting>
										<xsl:choose>
											<xsl:when test="IsNettingApplied='false'">0</xsl:when>
											<xsl:otherwise>1</xsl:otherwise>
										</xsl:choose>								
									</urn18:Netting>
								</xsl:if>																								

								<!-- F20_MGA -->
								<urn18:MeteringGridAreaUsedDomainLocation>
									<urn18:Name>
										<xsl:value-of select=".//*[_type='F20_MGA']/MeteringGridAreaName" />
									</urn18:Name>
									<urn18:Identification schemeAgencyIdentifier="305">
										<xsl:value-of select=".//*[_type='F20_MGA']/MeteringGridAreaCode" />
									</urn18:Identification>
									<urn18:Type>
										<xsl:value-of select=".//*[_type='F20_MGA']/MeteringGridAreaType" />
									</urn18:Type>
								</urn18:MeteringGridAreaUsedDomainLocation>

								<!-- F20_MPA -->

								<xsl:for-each select=".//*[_type='F20_MPA']">
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
											<xsl:value-of select="Country" />
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

								<!-- F20_ACP -->
								<xsl:if test="Latitude">
									<urn18:MPPositionMeteringPointGeographicalCoordinate>							
										<urn18:Latitude>
											<xsl:value-of select="Latitude" />
										</urn18:Latitude>						
										<urn18:Longitude>
											<xsl:value-of select="Longitude" />
										</urn18:Longitude>
									</urn18:MPPositionMeteringPointGeographicalCoordinate>
								</xsl:if>
							</urn18:MeteringPointList>
						</xsl:for-each>
					</urn17:Transaction>
				</urn17:ResponseMPList>
			</urn17:ResponseMPListMessage>
		</xsl:otherwise>
	</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>