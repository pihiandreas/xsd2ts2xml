<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="AccountingPointTemplate" match="//*[local-name()='Transaction']">
       <_name>AccountingPoint</_name>
       <_type>F02_ACP</_type>
       <xsl:if test="./*[local-name()='AddressFreeForm']">
       <xsl:element name="AddressNote">
           <xsl:value-of select="./*[local-name()='AddressFreeForm']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='StreetName']">
       <xsl:element name="StreetName">
           <xsl:value-of select="./*[local-name()='StreetName']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='Identification']">
       <xsl:element name="MeteringPointEAN">
           <xsl:value-of select="./*[local-name()='Identification']" />
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
       <xsl:if test="./*[local-name()='MeterIdentification']">
       <xsl:element name="MeterNumber">
           <xsl:value-of select="./*[local-name()='MeterIdentification']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='MeteringPointType']">
       <xsl:element name="AccountingPointType">
           <xsl:value-of select="./*[local-name()='MeteringPointType']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='MeteringPointSubType']">
       <xsl:element name="AccountingPointSubtype">
           <xsl:value-of select="./*[local-name()='MeteringPointSubType']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='RelatedMeteringPoint']">
       <xsl:element name="RelatedMeteringPointEAN">
           <xsl:value-of select="./*[local-name()='RelatedMeteringPoint']" />
       </xsl:element>
       </xsl:if>

</xsl:template>
</xsl:stylesheet>
