Shader "Hidden/Unlit/Text 2" {
Properties {
 _MainTex ("Alpha (A)", 2D) = "white" { }
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  Offset -1.000000, -1.000000
  GpuProgramID 22997
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
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 col_1;
					  highp vec2 factor_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
					  factor_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
					  col_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.w = (xlv_COLOR.w * tmpvar_4.w);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (min (min (tmpvar_3.x, tmpvar_3.y), min (factor_2.x, factor_2.y)), 0.0, 1.0);
					  col_1.w = (col_1.w * tmpvar_5);
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
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 col_1;
					  highp vec2 factor_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
					  factor_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
					  col_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.w = (xlv_COLOR.w * tmpvar_4.w);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (min (min (tmpvar_3.x, tmpvar_3.y), min (factor_2.x, factor_2.y)), 0.0, 1.0);
					  col_1.w = (col_1.w * tmpvar_5);
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
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying mediump vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 col_1;
					  highp vec2 factor_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
					  factor_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
					  col_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.w = (xlv_COLOR.w * tmpvar_4.w);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (min (min (tmpvar_3.x, tmpvar_3.y), min (factor_2.x, factor_2.y)), 0.0, 1.0);
					  col_1.w = (col_1.w * tmpvar_5);
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
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD1.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD1.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					void main()
					{
					    u_xlat0 = -abs(vs_TEXCOORD1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _ClipArgs0.xy;
					    u_xlat0.zw = vec2(u_xlat0.z * _ClipArgs1.x, u_xlat0.w * _ClipArgs1.y);
					    u_xlat0.xz = min(u_xlat0.yw, u_xlat0.xz);
					    u_xlat0.x = min(u_xlat0.z, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0.w;
					    u_xlat0.x = u_xlat0.x * u_xlat16_1;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD1.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD1.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					void main()
					{
					    u_xlat0 = -abs(vs_TEXCOORD1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _ClipArgs0.xy;
					    u_xlat0.zw = vec2(u_xlat0.z * _ClipArgs1.x, u_xlat0.w * _ClipArgs1.y);
					    u_xlat0.xz = min(u_xlat0.yw, u_xlat0.xz);
					    u_xlat0.x = min(u_xlat0.z, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0.w;
					    u_xlat0.x = u_xlat0.x * u_xlat16_1;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD1.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD1.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					void main()
					{
					    u_xlat0 = -abs(vs_TEXCOORD1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _ClipArgs0.xy;
					    u_xlat0.zw = vec2(u_xlat0.z * _ClipArgs1.x, u_xlat0.w * _ClipArgs1.y);
					    u_xlat0.xz = min(u_xlat0.yw, u_xlat0.xz);
					    u_xlat0.x = min(u_xlat0.z, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0.w;
					    u_xlat0.x = u_xlat0.x * u_xlat16_1;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = vs_COLOR0.xyz;
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
Fallback "Unlit/Text"
}