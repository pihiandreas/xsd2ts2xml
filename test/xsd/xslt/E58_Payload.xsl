<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
	<!--
 Set variable ProcesTypeUPS to check if proces is Update Accounting Point by Supplier (DH-124-1)
-->

	<xsl:variable name="ProcesType" select="//*[local-name()='EnergyBusinessProcess']"/> 

	<xsl:template name="AccountingPointTemplate" match="//*[local-name()='Transaction']">
		<_name>AccountingPoint</_name>
		<xsl:choose>
			<xsl:when test="$ProcesType='DH-125-1'">
				<_type>E58_ACP_MTS</_type>
			</xsl:when>		
			<xsl:when test="$ProcesType='DH-124-1'">
				<_type>E58_ACP_UPS</_type>
			</xsl:when>
			<xsl:when test="$ProcesType='DH-123'">
				<_type>E58_ACP_DEL</_type>
			</xsl:when>
			<xsl:when test="$ProcesType='DH-122-1' and ./*[local-name()='UpdateReason']='BM02'">
				<_type>E58_ACP_EAC</_type>
			</xsl:when>
			<xsl:when test="$ProcesType='DH-126-1' or $ProcesType='DH-127-1'">
				<_type>E58_ACP_REL</_type>
			</xsl:when>
			<xsl:otherwise>
				<_type>E58_ACP</_type>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="./*[local-name()='Description']">
			<xsl:element name="Description">
				<xsl:value-of select="./*[local-name()='Description']" />
			</xsl:element>
		</xsl:if>
		<xsl:element name="MeteringPointEAN">
			<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='Identification']" />
		</xsl:element>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='PhysicalStatusType']">
			<xsl:element name="MeteringPointStatus">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='PhysicalStatusType']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringPointType']">
			<xsl:element name="AccountingPointType">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringPointType']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringPointSubType']">
			<xsl:element name="AccountingPointSubtype">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringPointSubType']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='RemoteConnectable']">
			<xsl:element name="IsRemotelyConnectable">
				<xsl:choose>
					<xsl:when test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='RemoteConnectable']='0' or ./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='RemoteConnectable']='false'">false</xsl:when>
					<xsl:otherwise>true</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringTimeDivision']">
			<xsl:element name="MeteringTimeDivision">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringTimeDivision']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeterIdentification']">
			<xsl:element name="MeterNumber">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeterIdentification']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='RelatedMeteringPoint']">
			<xsl:element name="RelatedMeteringPointEAN">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='RelatedMeteringPoint']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='CommunityIdentification']">
			<xsl:element name="EnergyCommunityIdentifier">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='CommunityIdentification']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='CommunityName']">
			<xsl:element name="EnergyCommunityName">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='CommunityName']" />
			</xsl:element>
		</xsl:if>		
		<xsl:element name="MeteringGridAreaCode">
			<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringGridAreaUsedDomainLocation']/*[local-name()='Identification']" />
		</xsl:element>
		<xsl:element name="Latitude">
			<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPPositionMeteringPointGeographicalCoordinate']/*[local-name()='Latitude']" />
		</xsl:element>
		<xsl:element name="Longitude">
			<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPPositionMeteringPointGeographicalCoordinate']/*[local-name()='Longitude']" />
		</xsl:element>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='RemoteReadable']">
			<xsl:element name="IsRemotelyReadable">
				<xsl:choose>
					<xsl:when test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='RemoteReadable']='0' or ./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='RemoteReadable']='false'">false</xsl:when>
					<xsl:otherwise>true</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='MeteringMethod']">
			<xsl:element name="MeteringMethod">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='MeteringMethod']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='ResolutionDuration']">
			<xsl:element name="MeteringTimeStep">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='ResolutionDuration']" />
			</xsl:element>
		</xsl:if>		
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='UserGroup']">
			<xsl:element name="UserGroup">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='UserGroup']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='HeatingMethodType']">
			<xsl:element name="IsHeatingDependentOnElectricity">
				<xsl:choose>
					<xsl:when test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='HeatingMethodType']='0' or ./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='HeatingMethodType']='false'">false</xsl:when>
					<xsl:otherwise>true</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='FuseSize']">
			<xsl:element name="FuseSize">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='FuseSize']" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='ContractedConnectionCapacity']">
			<xsl:element name="ElectricPower">
				<xsl:value-of select="./*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='ContractedConnectionCapacity']" />
			</xsl:element>
		</xsl:if>

		<_entities>
			<xsl:apply-templates />
		</_entities>
	</xsl:template>
	<xsl:template name="AccountingPointAddressTemplate" match="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MeteringPointAddress']">
		<_entities_element>
			<entity>
				<_name>AccountingPointAddress</_name>
				<xsl:choose>
					<xsl:when test="$ProcesType='DH-124-1'">
						<_type>E58_MPA_UPS</_type>
					</xsl:when>
					<xsl:otherwise>
						<_type>E58_MPA</_type>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:element name="AddressType">
					<xsl:value-of select="./*[local-name()='Type']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='StreetName']">
					<xsl:element name="StreetName">
						<xsl:value-of select="./*[local-name()='StreetName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='BuildingNumber']">
					<xsl:element name="BuildingNumber">
						<xsl:value-of select="./*[local-name()='BuildingNumber']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='FloorIdentification']">
					<xsl:element name="StairwellIdentification">
						<xsl:value-of select="./*[local-name()='FloorIdentification']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='RoomIdentification']">
					<xsl:element name="Apartment">
						<xsl:value-of select="./*[local-name()='RoomIdentification']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='Postcode']">
					<xsl:element name="PostalCode">
						<xsl:value-of select="./*[local-name()='Postcode']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='CityName']">
					<xsl:element name="PostOffice">
						<xsl:value-of select="./*[local-name()='CityName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='CountryCode']">
					<xsl:element name="CountryCode">
						<xsl:value-of select="./*[local-name()='CountryCode']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='AddressFreeForm']">
					<xsl:element name="AddressNote">
						<xsl:value-of select="./*[local-name()='AddressFreeForm']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='Language']">
					<xsl:element name="Language">
						<xsl:value-of select="./*[local-name()='Language']" />
					</xsl:element>
				</xsl:if>

				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="GridAgreementTemplate" match="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='TaxCategory']">
		<_entities_element>
			<entity>
				<_name>GridAgreement</_name>
				<xsl:choose>
					<xsl:when test="$ProcesType='DH-124-1'">
						<_type>E58_AGR_UPS</_type>
					</xsl:when>
					<xsl:otherwise>
						<_type>E58_AGR</_type>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='TaxCategory']">
					<xsl:element name="TaxCategory">
						<xsl:value-of select="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='TaxCategory']" />
					</xsl:element>
				</xsl:if>

			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="ControlledLoadTemplate" match="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='LoadUnit']">
		<_entities_element>
			<entity>
				<_name>ControlledLoad</_name>
				<xsl:choose>
					<xsl:when test="$ProcesType='DH-124-1'">
						<_type>E58_CTL_UPS</_type>
					</xsl:when>
					<xsl:otherwise>
						<_type>E58_CTL</_type>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:element name="ControlledLoadIdentification">
					<xsl:value-of select="./*[local-name()='Identification']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='Name']">
					<xsl:element name="ControlledLoadName">
						<xsl:value-of select="./*[local-name()='Name']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='Description']">
					<xsl:element name="Description">
						<xsl:value-of select="./*[local-name()='Description']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='Timing']">
					<xsl:element name="Timing">
						<xsl:value-of select="./*[local-name()='Timing']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='Limits']">
					<xsl:element name="ControlLimits">
						<xsl:value-of select="./*[local-name()='Limits']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='MaxPower']">
					<xsl:element name="MaximumPower">
						<xsl:value-of select="./*[local-name()='MaxPower']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='UnitType']">
					<xsl:element name="MaximumPowerUnit">
						<xsl:value-of select="./*[local-name()='UnitType']" />
					</xsl:element>
				</xsl:if>

				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="StorageDeviceTemplate" match="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='StorageUnit']">
		<_entities_element>
			<entity>
				<_name>StorageDevice</_name>
				<xsl:choose>
					<xsl:when test="$ProcesType='DH-124-1'">
						<_type>E58_SDV_UPS</_type>
					</xsl:when>
					<xsl:otherwise>
						<_type>E58_SDV</_type>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:element name="StorageDeviceIdentification">
					<xsl:value-of select="./*[local-name()='Identification']" />
				</xsl:element>
				<xsl:element name="StorageDeviceName">
					<xsl:value-of select="./*[local-name()='Name']" />
				</xsl:element>
				<xsl:element name="StorageDeviceType">
					<xsl:value-of select="./*[local-name()='Type']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='Capacity']">
					<xsl:element name="Capacity">
						<xsl:value-of select="./*[local-name()='Capacity']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='UnitType']">
					<xsl:element name="CapacityUnit">
						<xsl:value-of select="./*[local-name()='UnitType']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='MaxCapacity']">
					<xsl:element name="MaximumPower">
						<xsl:value-of select="./*[local-name()='MaxCapacity']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='MaxCapacityUnitType']">
					<xsl:element name="MaximumPowerUnit">
						<xsl:value-of select="./*[local-name()='MaxCapacityUnitType']" />
					</xsl:element>
				</xsl:if>

				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="ProductionDeviceTemplate" match="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='ProductionUnit']">
		<_entities_element>
			<entity>
				<_name>ProductionDevice</_name>
				<xsl:choose>
					<xsl:when test="$ProcesType='DH-124-1'">
						<_type>E58_PDV_UPS</_type>
					</xsl:when>
					<xsl:otherwise>
						<_type>E58_PDV</_type>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:element name="ProductionDeviceIdentification">
					<xsl:value-of select="./*[local-name()='Identification']" />
				</xsl:element>
				<xsl:element name="ProductionDeviceName">
					<xsl:value-of select="./*[local-name()='Name']" />
				</xsl:element>
				<xsl:element name="ProductionType">
					<xsl:value-of select="./*[local-name()='Type']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='MaxCapacity']">
					<xsl:element name="MaximumPower">
						<xsl:value-of select="./*[local-name()='MaxCapacity']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='UnitType']">
					<xsl:element name="MaximumPowerUnit">
						<xsl:value-of select="./*[local-name()='UnitType']" />
					</xsl:element>
				</xsl:if>

				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="EstimatedYearlyUsageTemplate" match="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='EstimatedMetrics']">
		<xsl:choose>
			<xsl:when test="following-sibling::*" />
			<xsl:otherwise>
				<_entities_element>
					<entity>
						<_name>EstimatedYearlyUsage</_name>
						<xsl:choose>
							<xsl:when test="$ProcesType='DH-124-1'">
								<_type>E58_EYU_UPS</_type>
							</xsl:when>
							<xsl:otherwise>
								<_type>E58_EYU</_type>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:variable name="Position1" select="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='EstimatedMetrics'][position()=1]/*[local-name()='MeterTimeFrame']"/>
						<xsl:variable name="Position2" select="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='EstimatedMetrics'][position()=2]/*[local-name()='MeterTimeFrame']"/>

						<xsl:choose> 
							<xsl:when test="$Position1 = 'E11'">       
								<xsl:element name="EstimatedYearlyUsage1" >
									<xsl:value-of select="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='EstimatedMetrics'][position()=1]/*[local-name()='Total']"/>
								</xsl:element>
							</xsl:when>
						</xsl:choose>    
						<xsl:choose> 
							<xsl:when test="$Position2 = 'E11'">       
								<xsl:element name="EstimatedYearlyUsage1" >
									<xsl:value-of select="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='EstimatedMetrics'][position()=2]/*[local-name()='Total']"/>
								</xsl:element>
							</xsl:when>
						</xsl:choose>    

						<xsl:choose> 
							<xsl:when test="$Position1 = 'E10'">       
								<xsl:element name="EstimatedYearlyUsage2" >
									<xsl:value-of select="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='EstimatedMetrics'][position()=1]/*[local-name()='Total']"/>
								</xsl:element>
							</xsl:when>
						</xsl:choose>  

						<xsl:choose> 
							<xsl:when test="$Position2 = 'E10'">       
								<xsl:element name="EstimatedYearlyUsage2" >
									<xsl:value-of select="//*[local-name()='MeteringPointUsedDomainLocation']/*[local-name()='MPDetailMeteringPointCharacteristic']/*[local-name()='EstimatedMetrics'][position()=2]/*[local-name()='Total']"/>
								</xsl:element>
							</xsl:when>
						</xsl:choose>   

						<_entities>
							<xsl:apply-templates />
						</_entities>
					</entity>
				</_entities_element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>