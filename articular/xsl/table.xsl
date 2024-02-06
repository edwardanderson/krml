<?xml version="1.0" encoding="utf-8"?>

<!-- Tables are not currently supported as in-list elements. -->

<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2005/xpath-functions">

    <!-- Table -->
    <xsl:template match="table">
        <string key="@type">html:table</string>
        <map key="_value">
            <string key="@value">
                <xsl:value-of select="serialize(.)"/>
            </string>
            <string key="@type">rdf:HMTL</string>
        </map>
        <!-- Reference -->
        <xsl:apply-templates select="(thead|tbody)/tr/(th|td)/a" mode="reference"/>
    </xsl:template>

</xsl:stylesheet>