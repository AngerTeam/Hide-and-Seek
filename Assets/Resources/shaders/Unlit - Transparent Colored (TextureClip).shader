Shader "Hidden/Unlit/Transparent Colored (TextureClip)" {
Properties {
 _MainTex ("Base (RGB), Alpha (A)", 2D) = "black" { }
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  Offset -1.000000, -1.000000
  GpuProgramID 38541
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying mediump vec4 xlv_COLOR;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (((
					    (_glesVertex.xy * _ClipRange0.zw)
					   + _ClipRange0.xy) * 0.5) + vec2(0.5, 0.5));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ClipTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying mediump vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  mediump vec4 tmpvar_3;
					  tmpvar_3 = (tmpvar_2 * xlv_COLOR);
					  col_1.xyz = tmpvar_3.xyz;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ClipTex, xlv_TEXCOORD1);
					  col_1.w = (tmpvar_3.w * tmpvar_4.w);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying mediump vec4 xlv_COLOR;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (((
					    (_glesVertex.xy * _ClipRange0.zw)
					   + _ClipRange0.xy) * 0.5) + vec2(0.5, 0.5));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ClipTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying mediump vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  mediump vec4 tmpvar_3;
					  tmpvar_3 = (tmpvar_2 * xlv_COLOR);
					  col_1.xyz = tmpvar_3.xyz;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ClipTex, xlv_TEXCOORD1);
					  col_1.w = (tmpvar_3.w * tmpvar_4.w);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying mediump vec4 xlv_COLOR;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (((
					    (_glesVertex.xy * _ClipRange0.zw)
					   + _ClipRange0.xy) * 0.5) + vec2(0.5, 0.5));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ClipTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying mediump vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  mediump vec4 tmpvar_3;
					  tmpvar_3 = (tmpvar_2 * xlv_COLOR);
					  col_1.xyz = tmpvar_3.xyz;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ClipTex, xlv_TEXCOORD1);
					  col_1.w = (tmpvar_3.w * tmpvar_4.w);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ClipTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ClipTex, vs_TEXCOORD1.xy).w;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat1.w = u_xlat10_0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ClipTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ClipTex, vs_TEXCOORD1.xy).w;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat1.w = u_xlat10_0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ClipTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ClipTex, vs_TEXCOORD1.xy).w;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat1.w = u_xlat10_0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {

}
SubProgram "gles hw_tier02 " {

}
SubProgram "gles hw_tier03 " {

}
SubProgram "gles3 hw_tier01 " {

}
SubProgram "gles3 hw_tier02 " {

}
SubProgram "gles3 hw_tier03 " {

}
}
 }
}
Fallback "Unlit/Transparent Colored"
}