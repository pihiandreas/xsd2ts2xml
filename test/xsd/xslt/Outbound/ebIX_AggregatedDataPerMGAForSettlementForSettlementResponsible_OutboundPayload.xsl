<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:crs="un:unece:260:data:EEM-AggregatedDataPerMGAForSettlementForSettlementResponsible" xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher" exclude-result-prefixes="enrich">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:template match="entity">
		<crs:AggregatedDataPerMGAForSettlementForSettlementResponsible xsi:schemaLocation="un:unece:260:data:EEM-AggregatedDataPerMGAForSettlementForSettlementResponsible ebIX_AggregatedDataPerMGAForSettlementForSettlementResponsible_2014pB.xsd">
			<crs:Header>
				<xsl:if test="ExternalMessageID">
					<crs:Identification>
						<xsl:value-of select="ExternalMessageID"/>
					</crs:Identification>
				</xsl:if>
				<crs:DocumentType listAgencyIdentifier="260">E31</crs:DocumentType>
				<xsl:variable name="CreationDate" select="enrich:getReceivedTimestamp()"/>
				<xsl:if test="$CreationDate">
					<crs:Creation>
						<xsl:value-of select="concat((substring-before($CreationDate,'.')),'Z')"/>
					</crs:Creation>
				</xsl:if>
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
					<xsl:variable name="BalanceSupplier" select="enrich:getOrganisationIdentifier(.//*[_type='STS']/Supplier)"/>
					<crs:BalanceSupplierInvolvedEnergyParty>
						<crs:Identification schemeAgencyIdentifier="9">
							<xsl:value-of select="$BalanceSupplier"/>
						</crs:Identification>
					</crs:BalanceSupplierInvolvedEnergyParty>
					<crs:ProductIncludedProductCharacteristic>
						<crs:Identification schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='STS']/ProductType"/>
						</crs:Identification>
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
						<crs:MeteringPointType listAgencyIdentifier="260">E17</crs:MeteringPointType>
						<!--SettlementMethod	TimeSeriesType  	Description
							E01(Profiled)		IB_BS_CON_PD		Supplier consumption profiled			
							E02(Non-Profiled)	IB_BS_CON_NPD		Supplier consumption non-profiled
							E01(Profiled)		IB_BS_OCON_PD		Supplier PU own consumption profiled
							E02(Non-Profiled)	IB_BS_OCON_NPD		Supplier PU own consumption non-profiled
							E02(Non-Profiled)	IB_MGA_LOSS			MGA losses
						-->
						<xsl:choose>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_CON_PD'">
								<crs:SettlementMethodType listAgencyIdentifier="260">E01</crs:SettlementMethodType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_CON_NPD'">
								<crs:SettlementMethodType listAgencyIdentifier="260">E02</crs:SettlementMethodType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_OCON_PD'">
								<crs:SettlementMethodType listAgencyIdentifier="260">E01</crs:SettlementMethodType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_OCON_NPD'">
								<crs:SettlementMethodType listAgencyIdentifier="260">E02</crs:SettlementMethodType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_MGA_LOSS'">
								<crs:SettlementMethodType listAgencyIdentifier="260">E02</crs:SettlementMethodType>
							</xsl:when>
						</xsl:choose>
						<!--TimeSeriesType  BusinessType	Description
								IB_BS_CON_PD	A04			Supplier consumption profiled			
								IB_BS_CON_NPD	A04			Supplier consumption non-profiled
								IB_BS_OCON_PD	B36			Supplier PU own consumption profiled
								IB_BS_OCON_NPD	B36			Supplier PU own consumption non-profiled
								IB_MGA_LOSS		A15			MGA losses
						-->
						<xsl:choose>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_CON_PD'">
								<crs:BusinessType listAgencyIdentifier="330">A04</crs:BusinessType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_CON_NPD'">
								<crs:BusinessType listAgencyIdentifier="330">A04</crs:BusinessType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_OCON_PD'">
								<crs:BusinessType listAgencyIdentifier="330">B36</crs:BusinessType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_BS_OCON_NPD'">
								<crs:BusinessType listAgencyIdentifier="330">B36</crs:BusinessType>
							</xsl:when>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='IB_MGA_LOSS'">
								<crs:BusinessType listAgencyIdentifier="330">A15</crs:BusinessType>
							</xsl:when>
						</xsl:choose>
					</crs:MPDetailMeasurementMeteringPointCharacteristic>
					<crs:MeteringGridAreaUsedDomainLocation>
						<crs:Identification schemeAgencyIdentifier="305">
							<xsl:value-of select=".//*[_type='STS']/MeteringGridArea"/>
						</crs:Identification>
					</crs:MeteringGridAreaUsedDomainLocation>
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
		</crs:AggregatedDataPerMGAForSettlementForSettlementResponsible>
	</xsl:template>
</xsl:stylesheet>