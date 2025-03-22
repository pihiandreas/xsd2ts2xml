<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:urn1="urn:fi:Datahub:mif:metering:E66_EnergyTimeSeries:v1"
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1"
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1"
	xmlns:urn4="urn:fi:Datahub:mif:metering:E66_EnergyTimeSeries:elements:v1"
	xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
	exclude-result-prefixes="enrich">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" />

	<xsl:template match="entity">
		<urn1:EnergyTimeSeriesMessage>
			<urn1:EnergyTimeSeries>
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
							<urn2:DocumentType>E66</urn2:DocumentType>
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
					<!-- in case of a notification, ignore the external message reference and relatedexternalmessage id's-->
					<xsl:if test="not(.//*[_type='TRANSACTION_HEADER']/InternalTransactionType='STS.NTF')">
						<xsl:if test="ExternalMessageReference">
							<urn2:SenderRoutingInformation>
								<xsl:value-of select="ExternalMessageReference" />
							</urn2:SenderRoutingInformation>
						</xsl:if>
						<xsl:if test="RelatedExternalMessageID">
							<urn2:OriginalBusinessDocumentReference>
								<xsl:value-of select="RelatedExternalMessageID" />
							</urn2:OriginalBusinessDocumentReference>
						</xsl:if>
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
							<xsl:when test="BusinessProcess='25'">
								<urn3:EnergyBusinessProcess>DH-514-2</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:when test="BusinessProcess='28'">
								<urn3:EnergyBusinessProcess>DH-515-2</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:when test="BusinessProcess='32'">
								<urn3:EnergyBusinessProcess>DH-521</urn3:EnergyBusinessProcess>
							</xsl:when>							
							<xsl:when test="BusinessProcess='33'">
								<urn3:EnergyBusinessProcess>DH-522</urn3:EnergyBusinessProcess>
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
									<urn3:EnergyIndustryClassification>
										<xsl:value-of select="Industry"/>
									</urn3:EnergyIndustryClassification>
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
						<urn4:UniqueIdentification>
							<xsl:value-of select="ExternalTransactionID" />
						</urn4:UniqueIdentification>
						<urn4:ObservationPeriodTimeSeriesPeriod>
							<urn4:ResolutionDuration>
								<xsl:value-of select=".//*[_type='STS']/ResolutionDuration"/>
							</urn4:ResolutionDuration>
							<urn4:Start>
								<xsl:value-of select=".//*[_type='STS']/PeriodStartTS" />
							</urn4:Start>
							<urn4:End>
								<xsl:value-of select=".//*[_type='STS']/PeriodEndTS" />
							</urn4:End>
						</urn4:ObservationPeriodTimeSeriesPeriod>
						<urn4:ProductIncludedProductCharacteristic>
							<urn4:Identification>
								<xsl:value-of select=".//*[_type='STS']/ProductType"/>
							</urn4:Identification>
							<!--UnitType: 	UNKNOWN(0), // Unknown
								KWH(6), // Kilowatt hours (kWh)
								KVARH(8), // Kilo volt-amp reactive hours (kvarh)
								WH(64), // Watt hours (Wh)
								MWH(65), // Megawatt hours (MWh)
								GWH(66), // Gigawatt hours (GWh)
								VARH(67), // Volt-amp reactive hours (varh)
								MVARH(70); // Megavolt-amp reactive hours (Mvarh)
								GVARH(71); // Gigavolt-amp reactive hours (Gvarh):#19934
						-->
							<xsl:choose>
								<xsl:when test=".//*[_type='STS']/UnitType='kWh'">
									<urn4:UnitType>kWh</urn4:UnitType>
								</xsl:when>
								<xsl:when test=".//*[_type='STS']/UnitType='kvarh'">
									<urn4:UnitType>kvarh</urn4:UnitType>
								</xsl:when>
								<xsl:when test=".//*[_type='STS']/UnitType='Wh'">
									<urn4:UnitType>Wh</urn4:UnitType>
								</xsl:when>
								<xsl:when test=".//*[_type='STS']/UnitType='MWh'">
									<urn4:UnitType>MWh</urn4:UnitType>
								</xsl:when>
								<xsl:when test=".//*[_type='STS']/UnitType='GWh'">
									<urn4:UnitType>GWh</urn4:UnitType>
								</xsl:when>
								<xsl:when test=".//*[_type='STS']/UnitType='varh'">
									<urn4:UnitType>varh</urn4:UnitType>
								</xsl:when>
								<xsl:when test=".//*[_type='STS']/UnitType='Mvarh'">
									<urn4:UnitType>Mvarh</urn4:UnitType>
								</xsl:when>
								<xsl:when test=".//*[_type='STS']/UnitType='Gvarh'">
									<urn4:UnitType>Gvarh</urn4:UnitType>
								</xsl:when>
							</xsl:choose>					
						</urn4:ProductIncludedProductCharacteristic>
						<urn4:MPDetailMeasurementMeteringPointCharacteristic>
							<!-- MeteringPointType:	UNKNOWN	0	Unknown
										E17	1	Consumption metering point
										E18	2	Production metering point
										E19	3	Combined consumption and production metering point
										E20	4	Exchange metering point
										F01	5	Accounting point-->
							<xsl:choose>
								<xsl:when test=".//*[_type='STS']/MeteringPointType">
									<xsl:choose>
										<xsl:when test=".//*[_type='STS']/MeteringPointType='1'">
											<urn4:MeteringPointType>E17</urn4:MeteringPointType>
										</xsl:when>
										<xsl:when test=".//*[_type='STS']/MeteringPointType='2'">
											<urn4:MeteringPointType>E18</urn4:MeteringPointType>
										</xsl:when>
										<xsl:when test=".//*[_type='STS']/MeteringPointType='3'">
											<urn4:MeteringPointType>E19</urn4:MeteringPointType>
										</xsl:when>
										<xsl:when test=".//*[_type='STS']/MeteringPointType='4'">
											<urn4:MeteringPointType>E20</urn4:MeteringPointType>
										</xsl:when>
										<xsl:when test=".//*[_type='STS']/MeteringPointType='5'">
											<urn4:MeteringPointType>F01</urn4:MeteringPointType>
										</xsl:when>
									</xsl:choose>								
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_PU'">
											<urn4:MeteringPointType>E18</urn4:MeteringPointType>
										</xsl:when>										
									</xsl:choose>
								</xsl:otherwise>									
							</xsl:choose>
						</urn4:MPDetailMeasurementMeteringPointCharacteristic>
						<urn4:MeteringPointUsedDomainLocation>
							<urn4:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select=".//*[_type='STS']/MeteringPointID" />
							</urn4:Identification>
						</urn4:MeteringPointUsedDomainLocation>
						<!--Optional:-->
						<xsl:if test=".//*[_type='STS']/MeteringGridArea">
							<urn4:MeteringGridAreaUsedDomainLocation>
								<urn4:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='STS']/MeteringGridArea" />
								</urn4:Identification>
							</urn4:MeteringGridAreaUsedDomainLocation>
						</xsl:if>
						<!--Optional:-->
						<xsl:if test=".//*[_type='STS']/MeteringGridAreaIn">
							<urn4:InAreaUsedDomainLocation>
								<urn4:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='STS']/MeteringGridAreaIn" />
								</urn4:Identification>
							</urn4:InAreaUsedDomainLocation>
						</xsl:if>				
						<!--Optional:-->
						<xsl:if test=".//*[_type='STS']/MeteringGridAreaOut">
							<urn4:OutAreaUsedDomainLocation>
								<urn4:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='STS']/MeteringGridAreaOut" />
								</urn4:Identification>
							</urn4:OutAreaUsedDomainLocation>
						</xsl:if>	
						<!--1 or more repetitions:-->
						<xsl:for-each select=".//*[_type='OBS']">
							<urn4:OBS>
								<urn4:SEQ>
									<xsl:value-of select="SEQ" />
								</urn4:SEQ>
								<urn4:EOBS>
									<!-- Quantity Quality(QQ):
									NONE(0): 21(temporary)
									MISSING(1) : 21(temporary)
									UNCERTAIN(2): 21(temporary)
									ESTIMATED(3): 56(estimated, approved for billing)
									-->
									<xsl:choose>
									<!-- When there is no QTY and the QQ='MISSING': QTY=0-->
										<xsl:when test="QTY">
											<urn4:QTY>
												<xsl:value-of select="QTY" />
											</urn4:QTY>
										</xsl:when>	
										<xsl:otherwise>
											<xsl:choose>
												<xsl:when test="QQ='MISSING'">
													<urn4:QTY>0</urn4:QTY>
												</xsl:when>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="QQ='NONE'">
											<urn4:QQ>21</urn4:QQ>
										</xsl:when>
										<xsl:when test="QQ='MISSING'">
											<urn4:QQ>21</urn4:QQ>
										</xsl:when>
										<xsl:when test="QQ='UNCERTAIN'">
											<urn4:QQ>21</urn4:QQ>
										</xsl:when>
										<xsl:when test="QQ='EST'">
											<urn4:QQ>56</urn4:QQ>
										</xsl:when>
									</xsl:choose>
								</urn4:EOBS>
							</urn4:OBS>
						</xsl:for-each>
					</urn1:Transaction>
				</xsl:for-each>
			</urn1:EnergyTimeSeries>
		</urn1:EnergyTimeSeriesMessage>
	</xsl:template>
</xsl:stylesheet>