package org.as3commons.collections.utils {
	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.Set;
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.ICollection;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISet;
	/**
	 * <p>Uses the Builder Pattern to simplify the creation of new ISet instances in a fluent fashion.</p>
	 *  
	 * @author John Reeves.
	 * @example Creating a new LinkedSet instance using SetBuilder.
	 * &lt;listing version="3.0"&gt;
	 * 		const result : IMap = SetBuilder.linkedSet()
	 * 			.add("item-one")
	 * 			.add("item-two")
	 * 			.build();
	 * 		
	 * 		// Creates the following Set: { item-one, item-two }
	 * 		trace(result);
	 * &lt;/listing&gt;
	 */
	public class SetBuilder {
		/**
		 * Backing ISet instance which will be modified during Builder operation.
		 */
		private var _set : ISet;
		
		/**
		 * <p>Starts the construction of a new Set instance</p>
		 * 
		 * @return a SetBuilder instance which will build and return an instance of Set
		 */
		public static function set() : SetBuilder {
			return new SetBuilder(new Set());
		}
		
		/**
		 * <p>Starts construction of a new LinkedSet instance.</p>
		 * 
		 * @return a SetBuilder instance which will build and return an instance of LinkedSet
		 */		
		public static function linkedSet() : SetBuilder {
			return new SetBuilder(new LinkedSet());
		}

		/**
		 * <p>Starts construction of a new SortedSet instance.</p>
		 * 
		 * @param comparator the sort criterion which will be used by the resulting SortedSet instance.
		 * @return a MapBuilder instance which will build and return an instance of SortedSet
		 */	
		public static function sortedSet(comparator : IComparator) : SetBuilder {
			return new SetBuilder(new SortedSet(comparator));
		}
		
		/**
		 * <p>Please make use of one of the static factory methods for creating a new SetBuilder instance.</p>
		 * @private
		 */
		public function SetBuilder(underlyingSet : ISet) {
			_set = underlyingSet;
		}
		
		/**
		 * <p>Adds the supplied item to the ISet under construction, returns a reference to this
		 * SetBuilder instance.</p>
		 * 
		 * @param item to add to the ISet instance under construction.
		 * @return a reference to this SetBuilder instance to allow method chaining.
		 */
		public function add(item : *) : SetBuilder {
			_set.add(item);
			return this;
		}
		
		/**
		 * <p>Adds all the elements contained in the supplied ICollection instance to the ISet under
		 * construction.</p>
		 * 
		 * @param collection all elements from the supplied collection will be added to the ISet instance
		 * under construction.
		 * @return a reference to this SetBuilder instance to allow method chaining.
		 */
		public function addAll(collection : ICollection) : SetBuilder {
			const items : IIterator = collection.iterator();
			while (items.hasNext()) {
				_set.add(items.next());
			}
			return this;
		}
		
		/**
		 * <p>Completes construction.</p>
		 */
		public function build() : ISet {
			return _set;
		}
	}
}
