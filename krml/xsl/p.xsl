<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2005/xpath-functions">

    <!-- Literal (text/plain, without explicit datatype or language) -->
    <xsl:template
        match="p
        [
            (: does not have HTML element :)
            not(a|code|del|em|strong)
        ]">
        <!-- Make default language explicit -->
        <xsl:if test="$language">
            <string key="@language">
                <xsl:value-of select="$language"/>
            </string>
        </xsl:if>
        <!-- Cast content to number or string -->
        <xsl:choose>
            <xsl:when test="not(*) and number(text())">
                <number key="@value">
                    <xsl:value-of select="text()"/>
                </number>
            </xsl:when>
            <xsl:otherwise>
                <string key="@value">
                    <xsl:for-each select="node()">
                        <xsl:choose>
                            <!-- If the node is a <br/>, output a newline character -->
                            <xsl:when test="self::br">
                                <xsl:text>&#10;</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </string>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Literal (text/plain, with explicit datatype or language) -->
    <xsl:template
        match="p
        [
            (: does not have HTML element :)
            not(
                (a|del|em|strong)
                or code[following-sibling::node()]
            )
        ]
        [
            (: has a trailing `code` element :)
            code[
                not(following-sibling::node())

                (: `code` element is not a defined term :)
                and not(node() = /document/dl/dt)
            ]
        ]
        ">
        <xsl:variable name="type" select="code[not(following-sibling::*)]"/>
        <xsl:choose>
            <!-- Determine if code is BCP47 language tag -->
            <xsl:when test="matches($type, '^[a-z]{2,3}(?:-[a-zA-Z]{4})?(?:-[A-Z]{2,3})?$')">
                <string key="@language">
                    <xsl:value-of select="$type"/>
                </string>
            </xsl:when>
            <xsl:when test="$type = 'boolean'">
                <string key="@type">
                    <xsl:value-of>_boolean</xsl:value-of>
                </string>
            </xsl:when>
            <xsl:otherwise>
                <string key="@type">
                    <xsl:value-of select="$type"/>
                </string>
            </xsl:otherwise>
        </xsl:choose>
        <string key="@value">
            <xsl:value-of select="normalize-space(text())"/>
        </string>
    </xsl:template>

    <!-- Literal (text/plain, defined datatype) -->
    <xsl:template
        match="p
        [
            (: does not have HTML element :)
            not(a|del|em|strong)
        ]
        [
            (: has a trailing `code` element :)
            code[
                not(following-sibling::node())
                (: `code` element is a defined term :)
                and node() = /document/dl/dt
            ]
        ]
        ">
        <xsl:variable name="value" select="code"/>
        <string key="@type">
            <xsl:value-of select="/document/dl/dt[node() = $value]"/>
        </string>
        <string key="@value">
            <xsl:value-of select="normalize-space(text())"/>
        </string>
    </xsl:template>

    <!-- Literal (text/html, without language) -->
    <xsl:template
        match="p
        [
            (: has HTML element :)
            (a|code|del|em|strong)

            (: does not haves a trailing `code` element :)
            and not(
                code[not(following-sibling::node())]
                or $language
            )
        ]
        ">
        <string key="@type">
            <xsl:text>_HTML</xsl:text>
        </string>
        <string key="@value">
            <xsl:text>&lt;p&gt;</xsl:text>
            <xsl:choose>
                <xsl:when test="ends-with(., '&#160;')">
                    <xsl:value-of select="replace(normalize-space(serialize(node())), '&#160;$', '')" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="serialize(node())"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&lt;/p&gt;</xsl:text>
        </string>
    </xsl:template>

    <!-- Literal (text/html, with language) -->
    <xsl:template
        match="p
        [
            (: has HTML element :)
            (
                (a|del|em|strong)
                or code[following-sibling::node()]
            )

            (: has a trailing `code` element :)
            and (
                code[not(following-sibling::node())]
                or $language
            )
        ]
        ">
        <string key="@type">
            <xsl:text>_HTML</xsl:text>
        </string>
        <string key="@value">
            <xsl:text>&lt;p lang="</xsl:text>
            <xsl:choose>
                <xsl:when test="code[not(following-sibling::*)]">
                    <xsl:value-of select="code[not(following-sibling::*)]"/>
                </xsl:when>
                <xsl:when test="$language">
                    <xsl:value-of select="$language"/>
                </xsl:when>
            </xsl:choose>
            <xsl:text>"&gt;</xsl:text>
            <xsl:value-of select="normalize-space(serialize(node()[not(self::code[not(following-sibling::*)])]))"/>
            <xsl:text>&lt;/p&gt;</xsl:text>
        </string>
    </xsl:template>

</xsl:stylesheet>
