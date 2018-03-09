/////////////////////////////////////////////////////////
// Drop shadow effect
// Original Construct 2 effect by Somebody
// Ported to Construct 3 by Jeremy Lonien aka Ludonaut
/////////////////////////////////////////////////////////

precision lowp float;

varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;

// uniform float pixelWidth;
// uniform float pixelHeight;
// these were used in C2 and replaced by pixelSize in C3.

// available uniforms in C3:
uniform mediump vec2 srcStart; // current foreground rectangle, clamped
uniform mediump vec2 srcEnd;
uniform mediump vec2 srcOriginStart; // same as above but unclamped
uniform mediump vec2 srcOriginEnd;
uniform mediump vec2 layoutStart; // fg tex in layout coordinates
uniform mediump vec2 layoutEnd;
uniform lowp sampler2D samplerBackground; // bg texture sampler used for bg blending
uniform mediump vec2 destStart; // current bg rectangle in texture coordinates
uniform mediump vec2 destEnd;
uniform mediump float seconds; // used for animated effects
uniform mediump vec2 pixelSize; // size of a texel in fg texture coordinates
uniform mediump float layerScale; // layer scale as a factor (1 is unscaled)
uniform mediump float layerAngle;  // current layer angle in radians

// our custom effect parameters supplied via frontend user input
uniform lowp float offsetX; // in pixels
uniform lowp float offsetY; // in pixels
uniform lowp float dropopacity; // in percent

void main(void)
{	
	lowp vec4 front = texture2D(samplerFront, vTex);

	// the way it was done in C2
    // lowp float a = texture2D(samplerFront, vTex + vec2(-offsetX * pixelWidth, offsetY * pixelHeight)).a;
    
    // this works but has scaling issues. (offset increases the smaller the game window gets)
	lowp float a = texture2D(samplerFront, vTex + vec2(-offsetX * pixelSize.x, offsetY * pixelSize.y)).a;

	// according to C3 docs this is how to calculate the current texture coordinate:
	// lowp vec2 srcOriginSize = srcOriginEnd - srcOriginStart;
	// lowp vec2 n = ((vTex - srcOriginStart) / srcOriginSize);

	// this does absolutely nothing though??
	//lowp float a = texture2D(samplerFront, vTex + vec2(-offsetX * n.x, offsetY * n.y)).a;

	gl_FragColor = vec4(front.rgb, front.a + a * dropopacity);
}