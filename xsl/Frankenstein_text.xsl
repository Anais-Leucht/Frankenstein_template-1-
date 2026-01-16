<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="1.0">

  <!-- OUTPUT AS HTML -->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- ROOT TEMPLATE -->
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Frankenstein TEI Edition</title>
        <!-- CSS relative to XML location (/xml --> ../css/style.css) -->
        <link rel="stylesheet" href="../css/style.css"/>
      </head>
      <body>
        <!-- Render metadata -->
        <xsl:apply-templates select="//tei:teiHeader"/>
        <!-- Render main text body -->
        <xsl:apply-templates select="//tei:body"/>
      </body>
    </html>
  </xsl:template>

  <!-- TEI HEADER -->
  <xsl:template match="tei:teiHeader">
    <div class="tei-header">
      <h2>About this Manuscript</h2>
      <table class="metadata">
        <tr><th>Title</th><td><xsl:value-of select=".//tei:title"/></td></tr>
        <tr><th>Author</th><td><xsl:value-of select=".//tei:author"/></td></tr>
        <tr><th>Editor</th><td><xsl:value-of select=".//tei:editor"/></td></tr>
        <tr><th>Licence</th><td><xsl:value-of select=".//tei:licence"/></td></tr>
      </table>
      <ul>
        <li>Total modifications: <xsl:value-of select="count(//tei:del | //tei:add)"/></li>
        <li>Total additions: <xsl:value-of select="count(//tei:add)"/></li>
        <li>Mary: <xsl:value-of select="count(//tei:del[@hand='#MWS'] | //tei:add[@hand='#MWS'])"/></li>
        <li>Percy: <xsl:value-of select="count(//tei:del[@hand='#PBS'] | //tei:add[@hand='#PBS'])"/></li>
      </ul>
    </div>
  </xsl:template>

  <!-- BODY -->
  <xsl:template match="tei:body">
    <div class="tei-body">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- DIVS -->
  <xsl:template match="tei:div">
    <div class="tei-div">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- PARAGRAPHS -->
  <xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- MARGINAL ADDITIONS -->
  <xsl:template match="tei:add[@place='marginleft']">
    <span class="marginAdd"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- DELETIONS -->
  <xsl:template match="tei:del">
    <del class="{@hand}"><xsl:apply-templates/></del>
  </xsl:template>

  <!-- SUPRALINEAR ADDITIONS -->
  <xsl:template match="tei:add[@place='supralinear']">
    <span class="supraAdd"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- OVERWRITTEN TEXT -->
  <xsl:template match="tei:add[@place='overwritten']">
    <span class="overwritten"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- LINE BREAKS -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <!-- HIGHLIGHT RENDITIONS -->
  <xsl:template match="tei:hi[@rend='underline']">
    <u><xsl:apply-templates/></u>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='sup']">
    <sup><xsl:apply-templates/></sup>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='sub']">
    <sub><xsl:apply-templates/></sub>
  </xsl:template>
  <xsl:template match="tei:hi">
    <span class="{@rend}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- PAGE BREAKS -->
  <xsl:template match="tei:pb">
    <span class="circledPage"><xsl:value-of select="@n"/></span>
  </xsl:template>

</xsl:stylesheet>
