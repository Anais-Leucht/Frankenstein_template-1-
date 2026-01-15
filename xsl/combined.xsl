<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0">

  <!-- Output HTML -->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Root template: wraps the whole page -->
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>TEI Document</title>
        <link rel="stylesheet" href="/Frankenstein_template-1-/css/styles.css"/>
        <style>
          .marginLeft { color: blue; font-style: italic; }
          .circledPage { font-weight: bold; }
          .supraAdd { vertical-align: super; font-size: smaller; }
          .overwritten { text-decoration: line-through; color: red; }
        </style>
      </head>
      <body>
        <!-- Apply header templates first -->
        <xsl:apply-templates select="//tei:teiHeader"/>
        <!-- Then body templates -->
        <xsl:apply-templates select="//tei:body"/>
      </body>
    </html>
  </xsl:template>

  <!-- TEI Header -->
  <xsl:template match="tei:teiHeader">
    <div class="row">
      <div class="col">
        <h4>About the manuscript page:</h4>
        <table class="metadata">
          <tr>
            <th>Title</th>
            <td><xsl:value-of select=".//tei:title"/></td>
          </tr>
          <tr>
            <th>Author</th>
            <td><xsl:value-of select=".//tei:author"/></td>
          </tr>
          <tr>
            <th>Licence</th>
            <td><xsl:value-of select=".//tei:licence"/></td>
          </tr>
        </table>
      </div>
      <div class="col">
        <ul>
          <li>Total number of modifications:
              <xsl:value-of select="count(//tei:del | //tei:add)"/>
          </li>
          <li>Number of additions:
              <xsl:value-of select="count(//tei:add)"/>
          </li>
          <li>Number of modifications by Mary:
              <xsl:value-of select="count(//tei:del[@hand='#MWS'] | //tei:add[@hand='#MWS'])"/>
          </li>
          <li>Number of modifications by Percy:
              <xsl:value-of select="count(//tei:del[@hand='#PBS'] | //tei:add[@hand='#PBS'])"/>
          </li>
        </ul>
      </div>
    </div>
  </xsl:template>

  <!-- TEI Body -->
  <xsl:template match="tei:body">
    <div class="row">
      <div class="col-3">
        <xsl:for-each select="//tei:add[@place='marginleft']">
          <div class="marginLeft">
            <xsl:choose>
              <xsl:when test="parent::tei:del">
                <del class="{@hand}">
                  <xsl:apply-templates/>
                </del><br/>
              </xsl:when>
              <xsl:otherwise>
                <span class="{@hand}">
                  <xsl:apply-templates/><br/>
                </span>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </xsl:for-each>
      </div>
      <div class="col-9">
        <div class="transcription">
          <xsl:apply-templates select="//tei:div"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- TEI Div -->
  <xsl:template match="tei:div">
    <div class="MWS"><xsl:apply-templates/></div>
  </xsl:template>

  <!-- Paragraph -->
  <xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- Marginal additions -->
  <xsl:template match="tei:add[@place='marginleft']">
    <span class="marginAdd"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Deletions -->
  <xsl:template match="tei:del">
    <del class="{@hand}"><xsl:apply-templates/></del>
  </xsl:template>

  <!-- Supralinear additions -->
  <xsl:template match="tei:add[@place='supralinear']">
    <span class="supraAdd"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Line breaks -->
  <xsl:template match="tei:lb"><br/></xsl:template>

  <!-- Highlighting -->
  <xsl:template match="tei:hi[@rend='underline']"><u><xsl:apply-templates/></u></xsl:template>
  <xsl:template match="tei:hi[@rend='sup']"><sup><xsl:apply-templates/></sup></xsl:template>
  <xsl:template match="tei:hi[@rend='sub']"><sub><xsl:apply-templates/></sub></xsl:template>
  <xsl:template match="tei:hi"><span class="{@rend}"><xsl:apply-templates/></span></xsl:template>

  <!-- Overwritten additions -->
  <xsl:template match="tei:add[@place='overwritten']">
    <span class="overwritten"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Page breaks -->
  <xsl:template match="tei:pb">
    <span class="circledPage"><xsl:value-of select="@n"/></span>
  </xsl:template>

</xsl:stylesheet>
