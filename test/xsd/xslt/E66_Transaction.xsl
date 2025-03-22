<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:uuid="java:java.util.UUID" xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher" exclude-result-prefixes="enrich uuid" xmlns:urn="urn:cms:b2b:v01" xmlns:urn1="urn:fi:Datahub:mif:metering:E66_EnergyTimeSeries:v1" xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" xmlns:urn4="urn:fi:Datahub:mif:metering:E66_EnergyTimeSeries:elements:v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:template name="MeteringTransactionTemplate" match="urn1:Transaction">
		<xsl:param name="EnergyBusinessProcess"/>
		<xsl:param name="ProcessRole"/>
		<_name>Transaction</_name>
		<_type>TRANSACTION</_type>
		<xsl:if test="urn4:UniqueIdentification">
			<xsl:element name="ExternalTransactionID">
				<xsl:value-of select="urn4:UniqueIdentification"/>
			</xsl:element>
			<AuthorisationField1>
				<xsl:value-of select="$ProcessRole"/>
			</AuthorisationField1>
			<xsl:element name="ExternalTransactionType">
				<xsl:value-of select="$EnergyBusinessProcess"/>
			</xsl:element>
		</xsl:if>
		<_entities>
			<_entities_element>
				<_name>TransactionHeader</_name>
				<_type>TRANSACTION_HEADER</_type>
				<!--For MHB only -->
				<InternalTransactionType>
					<xsl:choose>
						<xsl:when test="$EnergyBusinessProcess='DH-211'">ETS.SUB</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$EnergyBusinessProcess"/>
						</xsl:otherwise>
					</xsl:choose>
				</InternalTransactionType>
				<InternalTransactionID>
					<xsl:value-of select="uuid:randomUUID()"/>
				</InternalTransactionID>
				<PayloadType>ETS</PayloadType>
			</_entities_element>
			<_entities_element>
				<_name>Payload</_name>
				<_type>PAYLOAD</_type>
				<_entities>
					<_entities_element>
						<_name>TransactionPayload</_name>
						<_type>ETS</_type>
						<xsl:if test="urn4:Identification">
							<xsl:element name="TimeSeriesID">
								<xsl:value-of select="urn4:Identification"/>
							</xsl:element>
						</xsl:if>
						<xsl:element name="MeteringPointID">
							<xsl:value-of select="urn4:MeteringPointUsedDomainLocation/urn4:Identification"/>
						</xsl:element>
						<!-- MeteringPointType:	UNKNOWN	0	Unknown
												E17	1	Consumption metering point
												E18	2	Production metering point
												E19	3	Combined consumption and production metering point
												E20	4	Exchange metering point
												F01	5	Accounting point-->
						<xsl:choose>
							<xsl:when test="urn4:MPDetailMeasurementMeteringPointCharacteristic/urn4:MeteringPointType='E17'">
								<MeteringPointType>1</MeteringPointType>
							</xsl:when>
							<xsl:when test="urn4:MPDetailMeasurementMeteringPointCharacteristic/urn4:MeteringPointType='E18'">
								<MeteringPointType>2</MeteringPointType>
							</xsl:when>
							<xsl:when test="urn4:MPDetailMeasurementMeteringPointCharacteristic/urn4:MeteringPointType='E19'">
								<MeteringPointType>3</MeteringPointType>
							</xsl:when>
							<xsl:when test="urn4:MPDetailMeasurementMeteringPointCharacteristic/urn4:MeteringPointType='E20'">
								<MeteringPointType>4</MeteringPointType>
							</xsl:when>
							<xsl:when test="urn4:MPDetailMeasurementMeteringPointCharacteristic/urn4:MeteringPointType='F01'">
								<MeteringPointType>5</MeteringPointType>
							</xsl:when>
							<xsl:otherwise>
								<MeteringPointType>0</MeteringPointType>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="urn4:MeteringGridAreaUsedDomainLocation/urn4:Identification">
							<xsl:element name="MeteringGridArea">
								<xsl:value-of select="urn4:MeteringGridAreaUsedDomainLocation/urn4:Identification"/>
							</xsl:element>
						</xsl:if>
						<xsl:if test="urn4:InAreaUsedDomainLocation/urn4:Identification">
							<xsl:element name="MeteringGridAreaIn">
								<xsl:value-of select="urn4:InAreaUsedDomainLocation/urn4:Identification"/>
							</xsl:element>
						</xsl:if>
						<xsl:if test="urn4:OutAreaUsedDomainLocation/urn4:Identification">
							<xsl:element name="MeteringGridAreaOut">
								<xsl:value-of select="urn4:OutAreaUsedDomainLocation/urn4:Identification"/>
							</xsl:element>
						</xsl:if>
						<xsl:element name="PeriodStartTS">
							<xsl:value-of select="urn4:ObservationPeriodTimeSeriesPeriod/urn4:Start"/>
						</xsl:element>
						<xsl:element name="PeriodEndTS">
							<xsl:value-of select="urn4:ObservationPeriodTimeSeriesPeriod/urn4:End"/>
						</xsl:element>
						<_entities>
							<xsl:call-template name="ChannelTemplate"/>
						</_entities>
					</_entities_element>
				</_entities>
			</_entities_element>
		</_entities>
	</xsl:template>
	<xsl:template name="ChannelTemplate">
		<_entities_element>
			<_name>Channel</_name>
			<_type>CNL</_type>
			<!--ResolutionDuration: UNKNOWN(0), // Unknown
										PT1S(-2), // 1-second intervals
										PT1M(-3), // 1-minute intervals
										PT5M(-4), // 5-minute intervals
										PT10M(-5), // 10-minute intervals
										PT15M(-6), // 15-minute intervals
										PT30M(-7), // 30-minute intervals
										PT1H(-8), // 1-hour intervals
										P1D(-101), // Daily Intervals
										P1M(-102), // Monthly Intervals
										P3M(-103), // Quarterly intervals
										P1Y(-104); // Yearly Intervals	-->
			<xsl:choose>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='PT1S'">
					<ResolutionDuration>-2</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='PT1M'">
					<ResolutionDuration>-3</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='PT5M'">
					<ResolutionDuration>-4</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='PT10M'">
					<ResolutionDuration>-5</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='PT15M'">
					<ResolutionDuration>-6</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='PT30M'">
					<ResolutionDuration>-7</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='PT1H'">
					<ResolutionDuration>-8</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='P1D'">
					<ResolutionDuration>-101</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='P1M'">
					<ResolutionDuration>-102</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='P3M'">
					<ResolutionDuration>-103</ResolutionDuration>
				</xsl:when>
				<xsl:when test="urn4:ObservationPeriodTimeSeriesPeriod/urn4:ResolutionDuration='P1Y'">
					<ResolutionDuration>-104</ResolutionDuration>
				</xsl:when>
				<xsl:otherwise>
					<ResolutionDuration>0</ResolutionDuration>
				</xsl:otherwise>
			</xsl:choose>
			<!--ProductType:	unknown (0)
									8716867000030(1) //Active energy
									8716867000139(2) //Reactive energy input
									8716867000146(3) //Reactive energy output
									8716867000047(4) //Reactive energy -->
			<xsl:choose>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:Identification='8716867000030'">
					<ProductType>1</ProductType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:Identification='8716867000139'">
					<ProductType>2</ProductType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:Identification='8716867000146'">
					<ProductType>3</ProductType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:Identification='8716867000047'">
					<ProductType>4</ProductType>
				</xsl:when>
				<xsl:otherwise>
					<ProductType>0</ProductType>
				</xsl:otherwise>
			</xsl:choose>
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
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='kWh'">
					<UnitType>6</UnitType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='kvarh'">
					<UnitType>8</UnitType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='Wh'">
					<UnitType>64</UnitType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='MWh'">
					<UnitType>65</UnitType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='GWh'">
					<UnitType>66</UnitType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='varh'">
					<UnitType>67</UnitType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='Mvarh'">
					<UnitType>70</UnitType>
				</xsl:when>
				<xsl:when test="urn4:ProductIncludedProductCharacteristic/urn4:UnitType='Gvarh'">
					<UnitType>71</UnitType>
				</xsl:when>
				<xsl:otherwise>
					<UnitType>0</UnitType>
				</xsl:otherwise>
			</xsl:choose>
			<_entities>
				<!-- Potential performance fix candidate, for each loop-->
				<xsl:for-each select="urn4:OBS">
					<xsl:call-template name="ObservationTemplate">
					</xsl:call-template>
				</xsl:for-each>
			</_entities>
		</_entities_element>
	</xsl:template>
	<xsl:template name="ObservationTemplate" match="urn4:OBS">
		<_entities_element>
			<_name>OBS</_name>
			<_type>OBS</_type>
			<xsl:if test="urn4:SEQ">
				<xsl:element name="SEQ">
					<xsl:value-of select="urn4:SEQ"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="urn4:EOBS/urn4:QTY">
				<xsl:element name="QTY">
					<xsl:value-of select="urn4:EOBS/urn4:QTY"/>
				</xsl:element>
			</xsl:if>
			<!-- Quantity Quality(QQ):	NONE(0), 
			
										MISSING(10), QM=true 
										UNCERTAIN(30), QQ=Z02
										EST(40), QQ=99
										CALC(50), n/a
										OK(60), QQ is absent
										REVISED(70), QQ= Z01
										PMISSING (20), QQ=Z04 response to request only
										21 (100), QQ=21 outbound only NBS code
										56 (110) QQ=56 outbound only NBS code
			-->
			<xsl:choose>
				<xsl:when test="urn4:EOBS/urn4:QQ">
					<xsl:choose>
						<xsl:when test="urn4:EOBS/urn4:QQ='Z02'">
							<QQ>30</QQ>
						</xsl:when>
						<xsl:when test="urn4:EOBS/urn4:QQ='99'">
							<QQ>40</QQ>
						</xsl:when>
						<xsl:when test="urn4:EOBS/urn4:QQ='Z01'">
							<QQ>70</QQ>
						</xsl:when>
						<xsl:when test="urn4:EOBS/urn4:QQ='Z04'">
							<QQ>20</QQ>
						</xsl:when>
						<xsl:when test="urn4:EOBS/urn4:QQ='21'">
							<QQ>100</QQ>
						</xsl:when>
						<xsl:when test="urn4:EOBS/urn4:QQ='56'">
							<QQ>110</QQ>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="urn4:EOBS/urn4:QM">
					<QQ>10</QQ>
				</xsl:when>
				<xsl:otherwise>
					<QQ>60</QQ>
				</xsl:otherwise>
			</xsl:choose>
		</_entities_element>
	</xsl:template>
</xsl:stylesheet>