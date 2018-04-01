/////////////////////////////////////////////////////////
// Outline / Stroke effect
// based on the pixi.js filter of the same name.
// Converted to Construct 3 by Jeremy Lonien aka Ludonaut
//
// big caveats: works only on objects, objects need padding, thick outlines are glitchy, quality setting doesn't actually work.

varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;

precision mediump float;

uniform float thickness;
uniform vec3 outlineColor;
uniform float quality;

const float DOUBLE_PI = 3.14159265358979323846264 * 2.;
const float samples = 40.0;
// todo: turn this into a non-const / uniform somehow?
// loop below won't compile with a non-const
// maybe just hardcode ten consts

void main(void) {
	vec4 ownColor = texture2D(samplerFront, vTex);
	vec4 curColor;
	float maxAlpha = 0.;
	vec2 displaced;

	for (float angle = 0.; angle <= DOUBLE_PI; angle += (DOUBLE_PI / samples)) {
		displaced.x = vTex.x + (thickness / 100.) * cos(angle);
		displaced.y = vTex.y + (thickness / 100.) * sin(angle);
		curColor = texture2D(samplerFront, displaced);
		maxAlpha = max(maxAlpha, curColor.a);
	}

	float resultAlpha = max(maxAlpha, ownColor.a);

	gl_FragColor = vec4((ownColor.rgb + outlineColor.rgb * (1. - ownColor.a)) * resultAlpha, resultAlpha);
}