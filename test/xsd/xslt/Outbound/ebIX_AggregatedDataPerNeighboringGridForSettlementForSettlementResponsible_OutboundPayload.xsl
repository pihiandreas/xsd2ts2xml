<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:crs="un:unece:260:data:EEM-AggregatedDataPerNeighboringGridForSettlementForSettlementResponsible" xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher" exclude-result-prefixes="enrich">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:template match="entity">
		<crs:AggregatedDataPerNeighboringGridForSettlementForSettlementResponsible xsi:schemaLocation="un:unece:260:data:EEM-AggregatedDataPerNeighboringGridForSettlementForSettlementResponsible ebIX_AggregatedDataPerNeighboringGridForSettlementForSettlementResponsible_2014pB.xsd">
			<crs:Header>
				<xsl:if test="ExternalMessageID">
					<crs:Identification>
						<xsl:value-of select="ExternalMessageID"/>
					</crs:Identification>
				</xsl:if>
				<crs:DocumentType listAgencyIdentifier="260">E31</crs:DocumentType>
				<crs:Creation>
					<xsl:value-of select="concat((substring-before(enrich:getReceivedTimestamp(),'.')),'Z')"/>
				</crs:Creation>
				<xsl:variable name="JuridicalSenderID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalSenderID)"/>
				<crs:SenderEnergyParty>
					<xsl:if test="$JuridicalSenderID">
						<crs:Identification schemeAgencyIdentifier="9">
							<xsl:value-of select="$JuridicalSenderID"/>
						</crs:Identification>
					</xsl:if>
				</crs:SenderEnergyParty>
				<xsl:variable name="JuridicalReceiverID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalReceiverID)"/>
				<crs:RecipientEnergyParty>
					<xsl:if test="$JuridicalReceiverID">
						<crs:Identification schemeAgencyIdentifier="305">
							<xsl:value-of select="$JuridicalReceiverID"/>
						</crs:Identification>
					</xsl:if>
				</crs:RecipientEnergyParty>
			</crs:Header>
			<crs:ProcessEnergyContext>
				<xsl:choose>
					<xsl:when test="BusinessProcess='31'">
						<crs:EnergyBusinessProcess listAgencyIdentifier="260">E44</crs:EnergyBusinessProcess>
					</xsl:when>
					<xsl:otherwise>
						<crs:EnergyBusinessProcess listAgencyIdentifier="260">E44</crs:EnergyBusinessProcess>
					</xsl:otherwise>
				</xsl:choose>
				<!--EnergyBusinessProcessRole-->
				<xsl:if test="ProcessRole">
					<xsl:choose>
						<xsl:when test="ProcessRole='1'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">EZ</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='2'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">DDM</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='3'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">DDM2</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='4'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">DDK</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='5'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">DDQ</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='6'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">DDX</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='7'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">DEA</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='8'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">MDR</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='9'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">SP</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:when test="ProcessRole='10'">
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">ESC</crs:EnergyBusinessProcessRole>
						</xsl:when>
						<xsl:otherwise>
							<crs:EnergyBusinessProcessRole listAgencyIdentifier="330">
								<xsl:value-of select="ProcessRole"/>
							</crs:EnergyBusinessProcessRole>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!--EnergyIndustryClassification-->
				<xsl:choose>
					<xsl:when test="Industry">
						<xsl:choose>
							<xsl:when test="Industry='1'">
								<crs:EnergyIndustryClassification listAgencyIdentifier="330">23</crs:EnergyIndustryClassification>
							</xsl:when>
							<xsl:otherwise>
								<crs:EnergyIndustryClassification listAgencyIdentifier="330">
									<xsl:value-of select="Industry"/>
								</crs:EnergyIndustryClassification>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<crs:EnergyIndustryClassification listAgencyIdentifier="330">23</crs:EnergyIndustryClassification>
					</xsl:otherwise>
				</xsl:choose>
			</crs:ProcessEnergyContext>
			<xsl:variable name="RegistrationTimestamp" select="RegistrationTimestamp"/>
			<xsl:for-each select=".//*[_type='TRANSACTION']">
				<crs:PayloadEnergyTimeSeries>
					<crs:Identification>
						<xsl:value-of select="ExternalTransactionID"/>
					</crs:Identification>
					<crs:RegistrationDateTime>
						<xsl:value-of select="$RegistrationTimestamp"/>
					</crs:RegistrationDateTime>
					<crs:ObservationPeriodTimeSeriesPeriod>
						<crs:ResolutionDuration>
							<xsl:value-of select=".//*[_type='STS']/ResolutionDuration"/>
						</crs:ResolutionDuration>
						<crs:Start>
							<xsl:value-of select=".//*[_type='STS']/PeriodStartTS"/>
						</crs:Start>
						<crs:End>
							<xsl:value-of select=".//*[_type='STS']/PeriodEndTS"/>
						</crs:End>
					</crs:ObservationPeriodTimeSeriesPeriod>
					<crs:ProductIncludedProductCharacteristic>
						<crs:Identification schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='STS']/ProductType"/>
						</crs:Identification>
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
								<!-- for ebix the unit type is in uppercase-->
								<crs:UnitType listAgencyIdentifier="330">KWH</crs:UnitType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/UnitType='kvarh'">
								<crs:UnitType listAgencyIdentifier="330">kvarh</crs:UnitType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/UnitType='Wh'">
								<crs:UnitType listAgencyIdentifier="330">Wh</crs:UnitType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/UnitType='MWh'">
								<!-- for ebix the unit type is in uppercase-->
								<crs:UnitType listAgencyIdentifier="330">MWH</crs:UnitType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/UnitType='GWh'">
								<crs:UnitType listAgencyIdentifier="330">GWh</crs:UnitType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/UnitType='varh'">
								<crs:UnitType listAgencyIdentifier="330">varh</crs:UnitType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/UnitType='Mvarh'">
								<crs:UnitType listAgencyIdentifier="330">Mvarh</crs:UnitType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/UnitType='Gvarh'">
								<crs:UnitType listAgencyIdentifier="330">GvArh</crs:UnitType>
							</xsl:when>
						</xsl:choose>
					</crs:ProductIncludedProductCharacteristic>
					<crs:MPDetailMeasurementMeteringPointCharacteristic>
						<crs:MeteringPointType listAgencyIdentifier="260">E20</crs:MeteringPointType>
					</crs:MPDetailMeasurementMeteringPointCharacteristic>
					<crs:MeteringGridAreaUsedDomainLocation>
						<xsl:choose>
							<!--In case the MeteringGridArea is Swedish use another schemeAgencyIdentifier. Now determined by length 3, but should be based on MBA -->
							<xsl:when test="string-length(.//*[_type='STS']/MeteringGridArea) = 3">
								<crs:Identification schemeAgencyIdentifier="260" schemeIdentifier="SVK">
									<xsl:value-of select=".//*[_type='STS']/MeteringGridArea"/>
								</crs:Identification>
							</xsl:when>
							<xsl:otherwise>
								<crs:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='STS']/MeteringGridArea"/>
								</crs:Identification>
							</xsl:otherwise>
						</xsl:choose>
					</crs:MeteringGridAreaUsedDomainLocation>
					<xsl:if test=".//*[_type='STS']/MeteringGridArea">
						<crs:InAreaUsedDomainLocation>
							<xsl:choose>
								<!--In case the MeteringGridArea is Swedish use another schemeAgencyIdentifier. Now determined by length 3, but should be based on MBA -->
								<xsl:when test="string-length(.//*[_type='STS']/MeteringGridArea) = 3">
									<crs:Identification schemeAgencyIdentifier="260" schemeIdentifier="SVK">
										<xsl:value-of select=".//*[_type='STS']/MeteringGridArea"/>
									</crs:Identification>
								</xsl:when>
								<xsl:otherwise>
									<crs:Identification schemeAgencyIdentifier="305">
										<xsl:value-of select=".//*[_type='STS']/MeteringGridArea"/>
									</crs:Identification>
								</xsl:otherwise>
							</xsl:choose>
						</crs:InAreaUsedDomainLocation>
					</xsl:if>
					<xsl:if test=".//*[_type='STS']/mgaNeighbor">
						<crs:OutAreaUsedDomainLocation>
							<xsl:choose>
								<!--In case the MeteringGridArea is Swedish use another schemeAgencyIdentifier. Now determined by length 3, but should be based on MBA -->
								<xsl:when test="string-length(.//*[_type='STS']/mgaNeighbor) = 3">
									<crs:Identification schemeAgencyIdentifier="260" schemeIdentifier="SVK">
										<xsl:value-of select=".//*[_type='STS']/mgaNeighbor"/>
									</crs:Identification>
								</xsl:when>
								<xsl:otherwise>
									<crs:Identification schemeAgencyIdentifier="305">
										<xsl:value-of select=".//*[_type='STS']/mgaNeighbor"/>
									</crs:Identification>
								</xsl:otherwise>
							</xsl:choose>
						</crs:OutAreaUsedDomainLocation>
					</xsl:if>
					<xsl:for-each select=".//*[_type='OBS']">
						<crs:ObservationIntervalObservationPeriod>
							<crs:Sequence>
								<xsl:value-of select="SEQ"/>
							</crs:Sequence>
							<crs:ObservationDetailEnergyObservation>
								<xsl:choose>
									<xsl:when test="QTY">
										<crs:EnergyQuantity>
											<xsl:value-of select='format-number( round(1000*QTY) div 1000 ,"########0.000" )'/>
										</crs:EnergyQuantity>
									</xsl:when>
									<xsl:otherwise>
										<crs:EnergyQuantity>0.0</crs:EnergyQuantity>
									</xsl:otherwise>
								</xsl:choose>
								<!-- Quantity Quality(QQ):
									NONE(0): 21(temporary)
									MISSING(1) : 21(temporary)
									UNCERTAIN(2): 21(temporary)
									ESTIMATED(3): 56(estimated, approved for billing)
									-->
								<xsl:choose>
									<xsl:when test="QQ='NONE'">
										<crs:QuantityQuality listAgencyIdentifier="330">21</crs:QuantityQuality>
									</xsl:when>
									<xsl:when test="QQ='MISSING'">
										<crs:QuantityQuality listAgencyIdentifier="330">21</crs:QuantityQuality>
									</xsl:when>
									<xsl:when test="QQ='UNCERTAIN'">
										<crs:QuantityQuality listAgencyIdentifier="330">21</crs:QuantityQuality>
									</xsl:when>
									<xsl:when test="QQ='EST'">
										<crs:QuantityQuality listAgencyIdentifier="330">56</crs:QuantityQuality>
									</xsl:when>
								</xsl:choose>
							</crs:ObservationDetailEnergyObservation>
						</crs:ObservationIntervalObservationPeriod>
					</xsl:for-each>
				</crs:PayloadEnergyTimeSeries>
			</xsl:for-each>
		</crs:AggregatedDataPerNeighboringGridForSettlementForSettlementResponsible>
	</xsl:template>
</xsl:stylesheet>