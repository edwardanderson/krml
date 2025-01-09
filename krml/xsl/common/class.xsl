<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2005/xpath-functions">

    <xsl:template name="class">
        <xsl:param name="application" select="''"/>
        <xsl:variable name="self-class" select="count(a/@title)"/>
        <xsl:variable name="child-class" select="count(ul/li[text() eq 'a']/ul/li)"/>
        <xsl:variable name="parent-class" select="count(ancestor::li[ul/li[text() = ('â')]])"/>
        <xsl:variable name="application-class" select="if ($application ne '') then 1 else 0"/>
        <xsl:if test="($self-class + $child-class + $parent-class + $application-class) ge 1">
            <array key="@type">
                <!-- Self -->
                <xsl:apply-templates select="a/@title"/>
                <!-- Child -->
                <xsl:apply-templates select="ul/li[text() eq 'a']/ul/li" mode="class"/>
                <!-- Parent -->
                <xsl:apply-templates select="ancestor::li[ul/li[text() = ('â', '^a')]]" mode="class"/>
                <!-- Application-->
                <xsl:if test="$application ne ''">
                    <string>
                        <xsl:value-of select="$application"/>
                    </string>
                </xsl:if>
            </array>
        </xsl:if>
    </xsl:template>

    <xsl:template match="@title">
        <xsl:variable name="value" select="."/>
        <string>
            <xsl:choose>
                <xsl:when test="$value = /document/dl/dt/text()">
                    <xsl:value-of select="encode-for-uri($value)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$value"/>
                </xsl:otherwise>
            </xsl:choose>
        </string>
    </xsl:template>

    <xsl:template match="li[text() eq 'a']/ul/li[not(a)]" mode="class">
        <string>
            <xsl:value-of select="text()"/>
        </string>
    </xsl:template>

    <xsl:template match="li[text() eq 'a']/ul/li[a]" mode="class">
        <string>
            <xsl:value-of select="a/@href"/>
        </string>
    </xsl:template>

    <xsl:template match="li[ul/li[text() = ('â', '^a')]][not(a)]" mode="class">
        <string>
            <xsl:value-of select="text()"/>
        </string>
    </xsl:template>

    <xsl:template match="li[ul/li[text() = ('â', '^a')]][a]" mode="class">
        <string>
            <xsl:value-of select="a/@href"/>
        </string>
    </xsl:template>

</xsl:stylesheet>
