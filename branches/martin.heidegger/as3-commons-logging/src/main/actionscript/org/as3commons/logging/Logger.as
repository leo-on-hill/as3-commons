/*
 * Copyright (c) 2008-2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package org.as3commons.logging {
	import org.as3commons.logging.level.DEBUG;
	import org.as3commons.logging.level.ERROR;
	import org.as3commons.logging.level.FATAL;
	import org.as3commons.logging.level.INFO;
	import org.as3commons.logging.level.WARN;
	import org.as3commons.logging.setup.ILogTarget;

	import flash.utils.getTimer;

	/**
	 * Proxy for an ILogger implementation. This class is used internally by the LoggerFactory and
	 * should not be used directly.
	 *
	 * <p>A LoggerProxy is created for each logger requested from the factory. This allows us to replace
	 * the ILogger implementations in the global logger factory when its internal factory changes.</p>
	 *
	 * @author Martin Heidegger mh@leichtgewicht.at
	 * @author Christophe Herreman
	 */
	public final class Logger implements ILogger {
		
		private static const _startTime: Number = new Date().getTime() - getTimer();
		
		/** The proxied logger. */
		private var _logTarget:ILogTarget;
		
		private var _name:String;
		private var _shortName:String;
		
		private var _debugEnabled:Boolean = false;
		private var _infoEnabled:Boolean = false;
		private var _warnEnabled:Boolean = false;
		private var _errorEnabled:Boolean = false;
		private var _fatalEnabled:Boolean = false;
		
		/**
		 * Creates a new LoggerProxy.
		 */
		public function Logger(name:String, logger:ILogTarget=null, logTargetLevel: LogSetupLevel=null) {
			_name = name;
			_shortName = name.substr( name.lastIndexOf(".")+1 );
			this.logTarget = logger;
			this.logTargetLevel = logTargetLevel;
		}
		
		public function set logTargetLevel(logTargetLevel:LogSetupLevel):void {
			if( logTargetLevel ) {
				_debugEnabled = logTargetLevel.matches( DEBUG );
				_infoEnabled  = logTargetLevel.matches( INFO );
				_warnEnabled  = logTargetLevel.matches( WARN );
				_errorEnabled = logTargetLevel.matches( ERROR );
				_fatalEnabled = logTargetLevel.matches( FATAL );
			} else {
				_debugEnabled =
				_infoEnabled  =
				_warnEnabled  =
				_errorEnabled =
				_fatalEnabled = false;
			}
		}
		
		/**
		 * Sets the proxied logger.
		 */
		public function set logTarget(logTarget:ILogTarget):void {
			_logTarget = logTarget;
		}
		
		/**
		 * @inheritDoc
		 */
		public function debug(message:*, ... params:*):void {
			if (_debugEnabled) {
				_logTarget.log( _name, _shortName, DEBUG, _startTime+getTimer(), message, params );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function info(message:*, ... params:*):void {
			if (_infoEnabled) {
				_logTarget.log( _name, _shortName, INFO, _startTime+getTimer(), message, params);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function warn(message:*, ... params:*):void {
			if (_warnEnabled) {
				_logTarget.log( _name, _shortName, WARN, _startTime+getTimer(), message, params);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function error(message:*, ... params:*):void {
			if (_errorEnabled) {
				_logTarget.log( _name, _shortName, ERROR, _startTime+getTimer(), message, params);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function fatal(message:*, ... params:*):void {
			if (_fatalEnabled) {
				_logTarget.log( _name, _shortName, FATAL, _startTime+getTimer(), message, params);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get debugEnabled():Boolean {
			return _debugEnabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get infoEnabled():Boolean {
			return _infoEnabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get warnEnabled():Boolean {
			return _warnEnabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get errorEnabled():Boolean {
			return _errorEnabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get fatalEnabled():Boolean {
			return _fatalEnabled;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function get shortName():String {
			return _shortName;
		}

		public function toString(): String {
			return "[Logger for '" + _name + "', target: " + ( _logTarget ? _logTarget : "null" ) + " ]";
		}
	}
}
