<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:urn1="urn:fi:Datahub:mif:metering:F07_RequestMeasuredData:v1" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1"
	xmlns:urn4="urn:fi:Datahub:mif:metering:F07_RequestMeasuredData:elements:v1"
	xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
	exclude-result-prefixes="enrich">


	<!--This parameters will set to enrich the fields-->
	<xsl:param name="TenantCode" select="'CMS'" />
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" />

	<xsl:template match="entity">
		<urn1:RequestMeasuredDataMessage>
			<urn1:RequestMeasuredData>
				<urn1:Header>
					<xsl:if test="ExternalMessageID">
						<urn2:Identification>
							<xsl:value-of select="ExternalMessageID" />
						</urn2:Identification>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="ExternalMessageType">
							<urn2:DocumentType>
								<xsl:value-of select="ExternalMessageType" />
							</urn2:DocumentType>
						</xsl:when>
						<xsl:otherwise>
							<urn2:DocumentType>F07</urn2:DocumentType>
						</xsl:otherwise>
					</xsl:choose>
					<urn2:Creation>
						<xsl:value-of select="enrich:getReceivedTimestamp()" />
					</urn2:Creation>
					<xsl:variable name="PhysicalSenderID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/PhysicalSenderID)"/>
					<urn2:PhysicalSenderEnergyParty>
						<xsl:if test="$PhysicalSenderID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$PhysicalSenderID" />
							</urn2:Identification>
						</xsl:if>
					</urn2:PhysicalSenderEnergyParty>
					<xsl:variable name="JuridicalSenderID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalSenderID)"/>
					<urn2:JuridicalSenderEnergyParty>
						<xsl:if test="$JuridicalSenderID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$JuridicalSenderID" />
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalSenderEnergyParty>
					<xsl:variable name="JuridicalReceiverID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalReceiverID)"/>
					<urn2:JuridicalRecipientEnergyParty>
						<xsl:if test="$JuridicalReceiverID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$JuridicalReceiverID" />
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalRecipientEnergyParty>
					<xsl:variable name="PhysicalReceiverID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/PhysicalReceiverID)"/>
					<urn2:PhysicalRecipientEnergyParty>
						<xsl:if test="$PhysicalReceiverID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$PhysicalReceiverID" />
							</urn2:Identification>
						</xsl:if>				
					</urn2:PhysicalRecipientEnergyParty>
					<xsl:if test="SenderRoutingInformation">
						<urn2:SenderRoutingInformation>
							<xsl:value-of select="SenderRoutingInformation" />
						</urn2:SenderRoutingInformation>
					</xsl:if>
					<xsl:if test="ExternalMessageReference">
						<urn2:OriginalBusinessDocumentReference>
							<xsl:value-of select="ExternalMessageReference" />
						</urn2:OriginalBusinessDocumentReference>
					</xsl:if>	
					<xsl:if test="MessageNumber">
						<urn2:MessageNumber>
							<xsl:value-of select="MessageNumber" />
						</urn2:MessageNumber>
					</xsl:if>
					<xsl:if test="MessageCount">
						<urn2:MessagesTotal>
							<xsl:value-of select="MessageCount" />
						</urn2:MessagesTotal>
					</xsl:if>
					<xsl:if test="RegistrationTimestamp">
						<urn2:RegistrationTimestamp>
							<xsl:value-of select="RegistrationTimestamp" />
						</urn2:RegistrationTimestamp>
					</xsl:if>
				</urn1:Header>
				<urn1:ProcessEnergyContext>
					<!--EnergyBusinessProcess-->
					<xsl:if test="BusinessProcess">
						<xsl:choose>
							<xsl:when test="BusinessProcess='8'">
								<urn3:EnergyBusinessProcess>DH-212-1</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:when test="BusinessProcess='9'">
								<urn3:EnergyBusinessProcess>DH-212-2</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:when test="BusinessProcess='10'">
								<urn3:EnergyBusinessProcess>DH-212-3</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:when test="BusinessProcess='11'">
								<urn3:EnergyBusinessProcess>DH-212-4</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:when test="BusinessProcess='15'">
								<urn3:EnergyBusinessProcess>DH-212-5</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:otherwise>
								<urn3:EnergyBusinessProcess>
									<xsl:value-of select="BusinessProcess"/>
								</urn3:EnergyBusinessProcess>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!--EnergyBusinessProcessRole-->
					<xsl:if test="ProcessRole">
						<xsl:choose>
							<xsl:when test="ProcessRole='1'">
								<urn3:EnergyBusinessProcessRole>EZ</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='2'">
								<urn3:EnergyBusinessProcessRole>DDM</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='3'">
								<urn3:EnergyBusinessProcessRole>DDM2</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='4'">
								<urn3:EnergyBusinessProcessRole>DDK</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='5'">
								<urn3:EnergyBusinessProcessRole>DDQ</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='6'">
								<urn3:EnergyBusinessProcessRole>DDX</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='7'">
								<urn3:EnergyBusinessProcessRole>DEA</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='8'">
								<urn3:EnergyBusinessProcessRole>MDR</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='9'">
								<urn3:EnergyBusinessProcessRole>SP</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='10'">
								<urn3:EnergyBusinessProcessRole>ESC</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:otherwise>
								<urn3:EnergyBusinessProcessRole>
									<xsl:value-of select="ProcessRole" />
								</urn3:EnergyBusinessProcessRole>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!--EnergyIndustryClassification-->
					<xsl:choose>
						<xsl:when test="Industry">
							<xsl:choose>
								<xsl:when test="Industry='1'">
									<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="Industry"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
						</xsl:otherwise>
					</xsl:choose>	
				</urn1:ProcessEnergyContext>
				<xsl:for-each select=".//*[_type='TRANSACTION']">
					<urn1:Transaction>
						<urn4:MeteringPoint schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='CETS']/MeteringPointID" />
						</urn4:MeteringPoint>
						<urn4:MeteringArea schemeAgencyIdentifier="305">
							<xsl:value-of select=".//*[_type='CETS']/MeteringGridArea" />
						</urn4:MeteringArea>
						<!--Optional:-->
						<xsl:if test=".//*[_type='CETS']/MeteringGridAreaIn">
							<urn4:InAreaUsedDomainLocation>
								<urn4:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='CETS']/MeteringGridAreaIn" />
								</urn4:Identification>
							</urn4:InAreaUsedDomainLocation>
						</xsl:if>				
						<!--Optional:-->
						<xsl:if test=".//*[_type='CETS']/MeteringGridAreaOut">
							<urn4:OutAreaUsedDomainLocation>
								<urn4:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='CETS']/MeteringGridAreaOut" />
								</urn4:Identification>
							</urn4:OutAreaUsedDomainLocation>
						</xsl:if>	
						<urn4:RequestPeriod>
							<urn4:Start>
								<xsl:value-of select=".//*[_type='CETS']/PeriodStartTS" />
							</urn4:Start>
							<urn4:End>
								<xsl:value-of select=".//*[_type='CETS']/PeriodEndTS" />
							</urn4:End>
						</urn4:RequestPeriod>
					</urn1:Transaction>
				</xsl:for-each>
			</urn1:RequestMeasuredData>
		</urn1:RequestMeasuredDataMessage>
	</xsl:template>
</xsl:stylesheet>